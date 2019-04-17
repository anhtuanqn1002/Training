//
//  ViewController.swift
//  TrainingAll
//
//  Created by Anh Tuan on 3/13/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: InfiniteCollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    let items = ["1", "2", "3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.infiniteDataSource = self
        DispatchQueue.main.async {
            self.layout.itemSize = self.collectionView.bounds.size            
        }
//        collectionView.infiniteDelegate = self
    }
}

extension ViewController: InfiniteCollectionViewDataSource {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: dequeueIndexPath) as! CollectionViewCell
        cell.label.text = items[usableIndexPath.row]
        return cell
    }
    
    
}
