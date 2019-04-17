//
//  InfiniteScrollView.swift
//  TrainingAll
//
//  Created by TuanNVA on 4/16/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class InfiniteScrollView: UIView {
    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    var workItems: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    var firstItem: String!
    var lastItem: String!
    
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: InfiniteScrollView.self)
        let nib = UINib(nibName: "InfiniteScrollView", bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        if let childView = views[0] as? UIView {
            addViewOverlay(childView: childView, toView: self)
        }
        loadingCompleted()
    }
    
    private func addViewOverlay(childView: UIView, toView parentView: UIView) {
        parentView.addSubview(childView)
        // Use bounds not frame or it'll be offset
        if frame == CGRect.zero {
            frame = childView.frame
        } else {
            childView.frame = bounds
        }
        addConstrainOverlay(childView: childView, toView: parentView)
    }
    
    private func addConstrainOverlay(childView: UIView, toView parentView: UIView) {
        childView.bounds = parentView.bounds // use for non auto layout project.
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childView.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            childView.heightAnchor.constraint(equalTo: parentView.heightAnchor),
            childView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
            ])
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! //{
//        didSet {
//            layout.itemSize = collectionView.bounds.size
//        }
    //}
    func loadingCompleted() {
        
        firstItem = items[0]
        lastItem = items.last!
        DispatchQueue.main.async {
            self.layout.itemSize = CGSize(width: 100, height: 100)
        }
//        workItems.insert(lastItem, at: 0)
//        workItems.append(firstItem)
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let contentOffsetWhenFullyScrolledRight = collectionView.frame.size.width * CGFloat(workItems.count - 1)
//        if scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight {
//            let newIndexPath = IndexPath(row: 1, section: 0)
//            collectionView.scrollToItem(at: newIndexPath, at: UICollectionView.ScrollPosition.left, animated: false)
//        } else if scrollView.contentOffset.x == 0 {
//            let newIndexPath = IndexPath(row: workItems.count - 2, section: 0)
//            collectionView.scrollToItem(at: newIndexPath, at: UICollectionView.ScrollPosition.left, animated: false)
//        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.size.width {
////            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
////        }
//        infiniteLoop(scrollView)
//        print("scrollViewDidScroll")
//    }
//    var currentIndex: Int = 0
//    func infiniteLoop(_ scrollView: UIScrollView) {
//        var index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
////        guard currentIndex != index else { return }
//        currentIndex = index
//        if index <= 0 {
//            index = workItems.count  - 2
//            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(index), y: 0), animated: false)
//        } else if index >= workItems.count - 1 {
//            index = 1
//            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
//        }
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        infiniteLoop(scrollView)
//        print("scrollViewDidEndDragging")
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let fullyScrolledContentOffset:CGFloat = collectionView.frame.size.width * CGFloat(workItems.count - 1)
//        if (scrollView.contentOffset.x >= fullyScrolledContentOffset) {
//            if workItems.count > 2 {
//                reversePhotoArray(workItems, startIndex: 0, endIndex: workItems.count - 1)
//                reversePhotoArray(workItems, startIndex: 0, endIndex: 1)
//                reversePhotoArray(workItems, startIndex: 2, endIndex: workItems.count - 1)
//                let indexPath = IndexPath(row: 1, section: 0)
////                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
//                collectionView.setContentOffset(CGPoint(x: scrollView.bounds.size.width * CGFloat(indexPath.row), y: 0), animated: false)
//            }
//        } else if scrollView.contentOffset.x == 0 {
//            if workItems.count > 2 {
//                reversePhotoArray(workItems, startIndex: 0, endIndex: workItems.count - 1)
//                reversePhotoArray(workItems, startIndex: 0, endIndex: workItems.count - 3)
//                reversePhotoArray(workItems, startIndex: workItems.count - 2, endIndex: workItems.count - 1)
//                let indexPath: IndexPath = IndexPath(row: workItems.count - 2, section: 0)
////                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
//                collectionView.setContentOffset(CGPoint(x: scrollView.bounds.size.width * CGFloat(indexPath.row), y: 0), animated: false)
//            }
//        }
//    }
    
//    func reversePhotoArray(_ photoArray:[String], startIndex:Int, endIndex:Int) {
//        if startIndex >= endIndex{
//            return
//        }
////        swap(&workItems[startIndex], &workItems[endIndex])
//        let t = workItems[startIndex]
//        workItems[startIndex] = workItems[endIndex]
//        workItems[endIndex] = t
//
//        reversePhotoArray(workItems, startIndex: startIndex + 1, endIndex: endIndex - 1)
//    }
}

extension InfiniteScrollView: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return workItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: dequeueIndexPath) as! CollectionViewCell
        cell.label.text = workItems[usableIndexPath.row]
//        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return workItems.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
//        cell.label.text = workItems[indexPath.row]
//        return cell
//    }
}

extension InfiniteScrollView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
}
