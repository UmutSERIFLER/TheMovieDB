//
//  ContentDetailView.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit
import Kingfisher

class ContentDetailView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentDescription: UILabel!
    @IBOutlet weak var contentPopularity: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUIView(){
        Bundle.main.loadNibNamed(ContentDetailView.identifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setContentInformations(content: ContentModel){
        contentName.text = content.originalName ?? content.originalTitle
        contentDescription.text = content.overview
        contentPopularity.text = String(content.popularity ?? 0)
        guard let contentURL = content.getContentImageURL(resolution: .medium) else {
            return
        }
        contentImage.kf.indicatorType = .activity
        contentImage.kf.setImage(with: contentURL)
    }

}

