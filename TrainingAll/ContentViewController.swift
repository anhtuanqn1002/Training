//
//  ContentViewController.swift
//  TrainingAll
//
//  Created by TuanNVA on 3/21/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    
    var heightOfContent: CGFloat {
        return scrollView.contentSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.alpha = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.alpha = 1.0
    }
}
