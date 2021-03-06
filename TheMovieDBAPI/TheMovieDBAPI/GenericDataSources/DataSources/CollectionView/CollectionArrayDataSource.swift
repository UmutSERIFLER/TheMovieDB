//
//  CollectionArrayDataSource.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

open class CollectionArrayDataSource<T, Cell: UICollectionViewCell>: CollectionDataSource<ArrayDataProvider<T>, Cell>
    where Cell: ConfigurableCell, Cell.T == T
{
    // MARK: - Lifecycle
    convenience init(collectionView: UICollectionView, array: [T], cellConfig: [CellConfigModel] = []) {
        self.init(collectionView: collectionView, array: [array], cellConfig: cellConfig)
    }

    init(collectionView: UICollectionView, array: [[T]], cellConfig: [CellConfigModel]) {
        let provider = ArrayDataProvider(array: array, cellConfig: cellConfig)
        super.init(collectionView: collectionView, provider: provider)
    }

    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }

    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
}
