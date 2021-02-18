//
//  HomeViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright (c) 2021 UmutSERIFLER. All rights reserved.

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel?
    var presenter : UITableView?
    
    /// Initiliase method for HomeViewController with Dependency Injection
    /// - Parameters:
    ///   - viewModel: Required ViewModel for View
    ///   - tableView: Create&Assign TableView
    init(viewModel: HomeViewModel = HomeViewModel(), tableView: UITableView = BaseTableView(cellArray: [ContentGroupTVCell.self])) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.presenter = tableView
        self.title = "Categories".uppercased()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let strongPresenter = self.presenter else { return }
        view.addSubview(strongPresenter)
        strongPresenter.frame = view.frame
        strongPresenter.delegate = self
        strongPresenter.dataSource = self
        self.initViewModel()
    }
    
    // MARK: Initiliase View Model Actions
    
    private func initViewModel()
    {
        
        viewModel?.reloadViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.presenter?.reloadData()
            }
        }
        
        viewModel?.showAlertClosure = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withMessage: errorMessage)
        }
        
        viewModel?.getExtendedContents()
    }
    
    func openViewController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}

extension HomeViewController: CellProtocol, CategoryHeaderViewProtocol {
    func seeContentDetail(content: ContentModel?) {
        self.openViewController(with: ContentDetailController(content: content))
    }
    
    func seeAllCategoryContants(type: MediaType) {
        self.openViewController(with: CategoryViewController(forCategory: type.rawValue))
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.getContentCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section) == 0 ? .leastNormalMagnitude : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0, let category = viewModel?.getContents(in: section) else { return nil }
        let categoryHeader: CategoryHeaderView = CategoryHeaderView(size: tableView.frame.size,delegation: self ,title: category.contentType.rawValue.uppercased(), number: category.content.totalResults)
        return categoryHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section) == 0 ? 150 : 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _ = viewModel?.getContentsWithData()
        if let cell: ContentGroupTVCell = tableView.dequeueReusableCell(withIdentifier: ContentGroupTVCell.identifier, for: indexPath) as? ContentGroupTVCell {
            guard let content = viewModel?.getContents(in: indexPath.section) else {
                return cell
            }
            cell.setData(with: content, delegation: self)
            return cell
        }
        return UITableViewCell()
    }
    
}


