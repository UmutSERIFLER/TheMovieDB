//
//  SearchTVBasicCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class SearchTVBasicCell: UITableViewCell, ConfigurableCell {
    
    var searchItem: SearchItem? {
        didSet {
            setUpUIWithData()
        }
    }
    
    func configure(_ item: SearchItem, at indexPath: IndexPath) {
        self.searchItem = item
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var contentName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var contentDescription: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpUIWithData() {
        contentView.addSubview(contentImage)
        contentView.addSubview(contentName)
        contentView.addSubview(contentDescription)
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            
            contentName.leadingAnchor.constraint(equalTo: contentImage.trailingAnchor, constant: 10),
            contentName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentName.topAnchor.constraint(equalTo: self.topAnchor),
            contentName.heightAnchor.constraint(equalToConstant: 30),
            
            contentDescription.topAnchor.constraint(equalTo: contentName.bottomAnchor),
            contentDescription.leadingAnchor.constraint(equalTo: contentImage.trailingAnchor, constant: 10),
            contentDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            contentDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        contentName.text = searchItem?.originalName ?? searchItem?.originalTitle
        contentDescription.text = searchItem?.overview
        guard let contentURL = self.searchItem?.getContentImageURL(resolution: .medium) else {
            return
        }
        contentImage.kf.indicatorType = .activity
        contentImage.kf.setImage(with: contentURL)
        
    }
    
}

