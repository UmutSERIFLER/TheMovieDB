//
//  ContentGroupTVCell.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class ContentGroupTVCell: UITableViewCell {
    
    var cellDelegation: CellProtocol?
    
    private(set) var contentGroup: ContentGroupModel? {
        didSet {
            setUpUIWithData()
        }
    }
    
    /// setData Method can be used to initiliase/set this ui component for Dependency Injection
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: self.frame.size), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ContentCVBasicCell.self, forCellWithReuseIdentifier: ContentCVBasicCell.identifier)
        collectionView.register(ContentCVExtendedCell.self, forCellWithReuseIdentifier: ContentCVExtendedCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(with content: ContentGroupModel, delegation: CellProtocol?) {
        self.contentGroup = content
        self.cellDelegation = delegation
    }
    
    func setUpUIWithData() {
        self.backgroundColor = .clear
        contentView.addSubview(contentCollectionView)
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension ContentGroupTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentGroup?.content.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contentGroup?.contentType {
        case .all:
            if let contentSmallCell: ContentCVBasicCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCVBasicCell.identifier, for: indexPath) as? ContentCVBasicCell {
                contentSmallCell.content = self.contentGroup?.content.results[indexPath.row]
                return contentSmallCell
            }
        case .movie, .tv:
            if let contentExtendedCell : ContentCVExtendedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCVExtendedCell.identifier, for: indexPath) as? ContentCVExtendedCell {
                contentExtendedCell.content = self.contentGroup?.content.results[indexPath.row]
                return contentExtendedCell
            }
        case .none, .some(.person):
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
}

extension ContentGroupTVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ContentCVBasicCell {
            self.cellDelegation?.seeContentDetail(content: cell.content)
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? ContentCVExtendedCell {
            self.cellDelegation?.seeContentDetail(content: cell.content)
        }
    }
}

extension ContentGroupTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // These values might be changed based on cell design 
        return CGSize(width: self.frame.height, height: self.frame.height)
    }
}

