//
//  SearchViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var viewModel: SearchViewModel?
    var presenter : UITableView?
    var searchType: MediaType?
    
    lazy var searchBar : UISearchBar = CustomSearchBar(frame: self.view.frame)
    
    private(set) var searchDataSource: SearchDataSource?
    
    lazy var rightBarButtonItem : UIBarButtonItem = {
        var rightBarButton = UIBarButtonItem(title: "Type", style: .done, target: self, action: #selector(sortList))
        rightBarButton.tintColor = .gray
        return rightBarButton
    }()
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPresenter), for: .valueChanged)
        return refreshControl
    }()
    
    /// Initiliase method for SearchViewController with Dependency Injection
    /// - Parameters:
    ///   - viewModel: Required ViewModel for View
    ///   - tableView: Create&Assign TableView
    init(viewModel: SearchViewModel = SearchViewModel(),
         type: MediaType = .movie,
         tableView: UITableView = BaseTableView(cellArray: [SearchTVBasicCell.self])) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.presenter = tableView
        self.searchType = type
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUIComponents()
        self.initViewModel()
    }
    
    func initUIComponents() {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        guard let strongPresenter = self.presenter else { return }
        view.addSubview(strongPresenter)
        strongPresenter.frame = view.frame
        strongPresenter.refreshControl = refreshControl
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    // MARK: Initiliase View Model Actions
    private func initViewModel()
    {
        
        viewModel?.reloadViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.presenter?.refreshControl?.endRefreshing()
                self?.searchDataSource = self?.setUpDataSource()
            }
        }
        
        viewModel?.showAlertClosure = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withMessage: errorMessage)
        }
    }
    
    @objc func refreshPresenter() {
        guard let searchText = searchBar.text, let type = searchType else { return }
        self.viewModel?.searchQuery(query: searchText, type: type, isNewRequest: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText.trimmingCharacters(in: .whitespaces).count == 0 {
            return
        }
        guard let type = self.searchType else { return }
        viewModel?.searchQuery(query: searchText, type: type, isNewRequest: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    @objc func sortList() {
        DispatchQueue.main.async { [weak self] in
            let filterVC = ChooserPopoverTableViewController(searchTypes: [MediaType.movie.rawValue,MediaType.tv.rawValue]) { (selectedOption) in
                
                self?.searchBar.text = ""
                
                guard let selectedType = MediaType(rawValue: selectedOption) else { return }
                
                self?.searchType = selectedType
                
                guard let type = self?.searchType else { return }
                
                self?.viewModel?.searchQuery(type: type, isNewRequest: true)
            }
            let referenceView = self?.rightBarButtonItem.value(forKey: "view") as? UIView
            
            _ = ChooserPopoverViewModel.configurePresentation(forController: filterVC, referenceView: referenceView)
            
            self?.present(filterVC, animated: true)
        }
    }

}

class SearchDataSource: TableArrayDataSource<SearchItem, SearchTVBasicCell> {}

//// MARK: - Private Methods
fileprivate extension SearchViewController {
    func setUpDataSource(filter: String? = nil) -> SearchDataSource? {
        guard let tableView = self.presenter, let searchResult = viewModel?.getSearchResult() else {
            return nil
        }
        
        let dataSource = SearchDataSource(tableView: tableView, array: [searchResult], cellConfig: [CellConfigModel(row: CellConfigModel.RowConfig(0,80))])
        dataSource.tableItemSelectionFetchHandler = { [weak self] (indexPath, isSelected) in
            if isSelected {
                if let searchCell: SearchTVBasicCell = tableView.cellForRow(at: indexPath) as? SearchTVBasicCell, let searchItem = searchCell.searchItem {
                    DispatchQueue.main.async {
                        self?.navigationController?.pushViewController(ContentDetailController(content: searchItem.toContentModel()), animated: true)
                    }
                }
            } else {
                self?.viewModel?.fetchData(indexPath: indexPath)
            }
        }
        return dataSource
    }
}

