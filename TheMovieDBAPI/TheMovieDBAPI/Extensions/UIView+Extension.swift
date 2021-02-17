//
//  UIView+Extension.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

extension UIView {
    
    class var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class func loadFromNib<T: UIView>() -> T {
        let nib = Bundle.main.loadNibNamed(T.identifier, owner: self)!
        let nibView = nib.first as! T
        nibView.translatesAutoresizingMaskIntoConstraints = false
        return nibView
    }
}
