//
//  ViewController.swift
//  TrainingAll
//
//  Created by Anh Tuan on 3/13/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController {

    var listViewController: [UIViewController] = []
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .brown
        settings.style.selectedBarBackgroundColor = .green
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarLeftContentInset = 18
        settings.style.buttonBarRightContentInset = 18
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction private func handleAction(_ sender: Any) {
        let index = Int.random(in: 0...listViewController.count)
        let contentVC = ContentViewController()
        contentVC.indicator.title = "Content \(index)"
        listViewController.insert(contentVC, at: index)
        reloadPagerTabStripView()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        var topicViewControllers: [UIViewController] = []
//        let categories = viewModel.topics
//        for item in categories {
//            switch item.type {
//            case .forYou, .follow:
//                let newsfeed = NewsfeedViewController()
//                newsfeed.indicator.title = item.name
//                topicViewControllers.append(newsfeed)
//            case .normal:
//                let topicViewController = TopicViewController()
//                topicViewController.indicator.title = item.name
//                let topicViewModel = viewModel.createTopicViewModel(item)
//                topicViewController.viewModel = topicViewModel
//                topicViewControllers.append(topicViewController)
//            }
//        }
//
//        return topicViewControllers
        if listViewController.count == 0 {
            listViewController.append(ContentViewController())
        }
        return listViewController
    }
}

