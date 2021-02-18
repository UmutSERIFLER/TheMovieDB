//
//  ContentCVExtendedCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class ContentCVExtendedCell: UICollectionViewCell {
    
    var content: ContentModel? {
        didSet {
            self.contentName.text = content?.originalName ?? content?.originalTitle
            contentView.backgroundColor = (content?.mediaType == .person) ? .blue : (content?.mediaType == .movie) ? .lightGray : .darkGray
            guard let contentURL = self.content?.getContentImageURL(resolution: .medium) else {
                return
            }
            contentImage.kf.setImage(with: contentURL)
        }
    }

    fileprivate lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var contentName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .clear
        contentView.addSubview(contentImage)
        contentView.addSubview(contentName)
        NSLayoutConstraint.activate([
            contentImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            contentImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            contentImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            contentName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            contentName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            contentName.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
