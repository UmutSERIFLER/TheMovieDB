//
//  CategoryCVCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCVCell: UICollectionViewCell, ConfigurableCell {
    
    func configure(_ item: ContentModel, at indexPath: IndexPath) {
        self.content = item
    }
    
    // Update Model
    var content: ContentModel? {
        didSet {
            contentName.text = content?.title
            contentDescription.text = content?.overview
            guard let contentURL = self.content?.getContentImageURL(resolution: .medium) else {
                return
            }
            contentImage.kf.indicatorType = .activity
            contentImage.kf.setImage(with: contentURL)
        }
    }
    
    fileprivate lazy var contentImage : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var contentName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var contentDescription : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var contentPrice : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(contentImage)
        contentView.addSubview(contentName)
        contentView.addSubview(contentDescription)
        contentView.addSubview(contentPrice)
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentImage.heightAnchor.constraint(equalToConstant: 225),
            
            
            contentName.topAnchor.constraint(equalTo: contentImage.bottomAnchor),
            contentName.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentName.heightAnchor.constraint(equalToConstant: 25),
            
            contentDescription.topAnchor.constraint(equalTo: contentName.bottomAnchor),
            contentDescription.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentDescription.heightAnchor.constraint(equalToConstant: 25),
            
            contentPrice.topAnchor.constraint(equalTo: contentDescription.bottomAnchor),
            contentPrice.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentPrice.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
