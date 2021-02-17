//
//  ContentDetailViewController.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 17/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class ContentDetailController: UIViewController {

    var content: ContentModel?
    
    init(content: ContentModel?) {
        super.init(nibName: nil, bundle: nil)
        self.content = content
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let strongContent = self.content else { return }
        let contentDV = ContentDetailView(frame: self.view.frame)
        contentDV.setContentInformations(content: strongContent)
        self.view.addSubview(contentDV)
        self.title = strongContent.title
    }
}
