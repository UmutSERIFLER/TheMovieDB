//
//  CategoryHeaderView.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

protocol CategoryHeaderViewProtocol {
    func seeAllCategoryContants(type: MediaType)
}

class CategoryHeaderView: UIView {
    
    fileprivate lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 15)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllCategory), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont(name: "Arial", size: 22)
        headerTitle.textColor = .blue
        headerTitle.textAlignment = .left
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    var categoryHeaderDelegation: CategoryHeaderViewProtocol?
    
    convenience init(size: CGSize, delegation: CategoryHeaderViewProtocol? = nil ,title: String = "", number: Int = 0) {
        let customFrame = CGRect(origin: .zero, size: size)
        self.init(frame: customFrame)
        categoryHeaderDelegation = delegation
        headerTitle.text = title
        categoryButton.setTitle("SE ALLE (\(number))", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func seeAllCategory() {
        guard let title = headerTitle.text?.lowercased(), let mediaType = MediaType(rawValue: title) else { return }
        self.categoryHeaderDelegation?.seeAllCategoryContants(type: mediaType)
    }
    
    //common func to init our view
    private func setupView() {
        addSubview(categoryButton)
        addSubview(headerTitle)
        NSLayoutConstraint.activate([
            
            headerTitle.heightAnchor.constraint(equalTo: self.heightAnchor),
            headerTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            headerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            categoryButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            categoryButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            categoryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
}
