//
//  ViewController.swift
//  TrainingAll
//
//  Created by Anh Tuan on 3/13/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let datasource: [Int] = [Int](0...53)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        RCValues.shared.fetchCloudValues()
        print("==> \(RCValues.shared.getValue(.mainColor).stringValue)")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = "\(datasource[indexPath.row])"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {}

class MyLayout: UICollectionViewLayout {
    
    var attributed: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    var contentSize: CGSize!
    
    override func prepare() {
        super.prepare()
        attributed.removeAll()
        
        
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        attribute.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        attributed[IndexPath(row: 0, section: 0)] = attribute
        self.contentSize = CGSize(width: 400, height: 400)
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.attributed {
            if (attributes.value as! UICollectionViewLayoutAttributes).frame.intersects(rect ) {
                layoutAttributes.append((attributes.value as! UICollectionViewLayoutAttributes))
            }
        }
        return layoutAttributes
    }
}
