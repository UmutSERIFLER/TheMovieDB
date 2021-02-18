//
//  CategoryViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    var categoryViewModel: CategoryViewModel?
    var categoryCollectionView: UICollectionView?
    private(set) var productDataSource: ProductDataSource?
    
    init(viewModel: CategoryViewModel = CategoryViewModel(),
         collectionView: UICollectionView = BaseCollectionView(cellArray: [CategoryCVCell.self]),
         forCategory: String) {
        super.init(nibName: nil, bundle: nil)
        self.categoryViewModel = viewModel
        self.categoryCollectionView = collectionView
        self.title = forCategory.uppercased()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUIComponents()
        self.initViewModel()
    }
    
    func initUIComponents() {
        guard let collectionView = self.categoryCollectionView else { return }
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.frame
    }
    
    // Initiliase View Model Actions
    func initViewModel() {
        
        categoryViewModel?.reloadViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.productDataSource = self?.setUpDataSource()
            }
        }
        
        categoryViewModel?.showAlertClosure = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withMessage: errorMessage)
        }
        self.categoryViewModel?.getPopularContents(type: self.title)
    }
//
//    @objc func sortList() {
//        DispatchQueue.main.async { [weak self] in
//            let filterVC = ChooserPopoverTableViewController { (selectedOption) in
//                self?.productDataSource = self?.setUpDataSource(filter: selectedOption)
//            }
//            filterVC.preferredContentSize = CGSize(width: 150, height: 50)
//            let presentationController = ChooserPopoverViewModel.configurePresentation(forController: filterVC)
//            let referenceView = self?.rightBarButtonItem.value(forKey: "view") as? UIView
//            presentationController.sourceView = referenceView
//            presentationController.sourceRect = referenceView?.bounds ?? CGRect(origin: .zero, size: CGSize(width: 50, height: 100))
//            presentationController.permittedArrowDirections = [.up]
//            self?.present(filterVC, animated: true)
//        }
//    }

}

class ProductDataSource: CollectionArrayDataSource<ContentModel, CategoryCVCell> {}

//// MARK: - Private Methods
fileprivate extension CategoryViewController {
    func setUpDataSource(filter: String? = nil) -> ProductDataSource? {
        guard let products = categoryViewModel?.getContents(), let collectionView = self.categoryCollectionView else {
            return nil
        }
        let dataSource = ProductDataSource(collectionView: collectionView, array: [products], cellConfig: [CellConfigModel(row: CellConfigModel.RowConfig(0,300))])
        dataSource.collectionItemSelectionFetchHandler = { [weak self] (indexPath, isSelected) in
            if isSelected {
                if let contentCell: CategoryCVCell = collectionView.cellForItem(at: indexPath) as? CategoryCVCell, let content = contentCell.content {
                    DispatchQueue.main.async {
                        self?.navigationController?.pushViewController(ContentDetailController(content: content), animated: true)
                    }
                }
            } else {
                self?.categoryViewModel?.fetchData(indexPath: indexPath)
            }
        }
        return dataSource
    }
}
