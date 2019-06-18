//
//  ContentViewController.swift
//  TrainingAll
//
//  Created by TuanNVA on 6/18/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ContentViewController: UIViewController {

    var indicator = IndicatorInfo(title: "Content")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ContentViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return indicator
    }
}
