//
//  ViewController3.swift
//  TrainingAll
//
//  Created by TuanNVA on 4/19/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var array: [String] = []
    var pageOneDoc,pageTwoDoc, pageThreeDoc: UILabel!
    var imageView: UIImageView!
    
    var prevIndex = 0
    var currIndex = 0
    var nextIndex = 0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            self.width = self.scrollView.bounds.size.width
            self.height = self.scrollView.bounds.size.height
        self.scrollView.delegate = self
        for i in 0..<10 {
            self.array.append("Doc :\(i + 1)")
        }
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
            self.containerView.addSubview(self.imageView)
            self.containerView.sendSubviewToBack(self.imageView)
            
        self.pageOneDoc = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 44))
        self.pageTwoDoc = UILabel(frame: CGRect(x: self.width, y: 0, width: self.width, height: 44))
        self.pageThreeDoc = UILabel(frame: CGRect(x: self.width * 2, y: 0, width: self.width, height: 44))

        self.pageOneDoc.textAlignment = .center
        self.pageTwoDoc.textAlignment = .center
        self.pageThreeDoc.textAlignment = .center
        
        self.loadPageWithId(index: 9, onPage: 0)
        self.loadPageWithId(index: 0, onPage: 1)
        self.loadPageWithId(index: 1, onPage: 2)
        
        self.scrollView.addSubview(self.pageOneDoc)
        self.scrollView.addSubview(self.pageTwoDoc)
        self.scrollView.addSubview(self.pageThreeDoc)
        
        self.scrollView.contentSize = CGSize(width: self.width * 3, height: self.height)
        self.scrollView.scrollRectToVisible(CGRect(x: self.width, y: 0, width: self.width, height: self.height), animated: false)
        }
    }
    
    func loadPageWithId(index: Int, onPage: Int) {
        switch onPage {
        case 0:
            pageOneDoc.text = array[index]
            imageView.image = UIImage(named: "image1.jpg")
        case 1:
            pageTwoDoc.text = array[index]
            imageView.image = UIImage(named: "image2.jpg")
        case 2:
            pageThreeDoc.text = array[index]
            imageView.image = UIImage(named: "image3.jpg")
        default:
            break
        }
    }
}

extension ViewController3: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > scrollView.frame.size.width) {
            loadPageWithId(index: currIndex, onPage: 0)
            currIndex = (currIndex >= array.count - 1) ? 0 : currIndex + 1
            loadPageWithId(index: currIndex, onPage: 1)
            
            // Load content on the last page. This is either from the next item in the array
            // or the first if we have reached the end.
            nextIndex = (currIndex >= array.count - 1) ? 0 : currIndex + 1
            loadPageWithId(index: nextIndex, onPage: 2)
        }
        if(scrollView.contentOffset.x < scrollView.frame.size.width) {
            // We are moving backward. Load the current doc data on the last page.
            loadPageWithId(index: currIndex, onPage: 2)
            // Subtract one from the currentIndex or go to the end if we have reached the beginning.
            currIndex = (currIndex == 0) ? array.count - 1 : currIndex - 1
            loadPageWithId(index: currIndex, onPage: 1)
            
            // Load content on the first page. This is either from the prev item in the array
            // or the last if we have reached the beginning.
            prevIndex = (currIndex == 0) ? array.count - 1 : currIndex - 1
            loadPageWithId(index: prevIndex, onPage: 0)
        }
        
        // Reset offset back to middle page
        scrollView.scrollRectToVisible(CGRect(x: width, y: 0, width: width, height: 416), animated: false)
    }
}
