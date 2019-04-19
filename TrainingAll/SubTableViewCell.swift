//
//  SubTableViewCell.swift
//  TrainingAll
//
//  Created by TuanNVA on 4/19/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

struct Item {
    var title: String
}

class Items {
    var items: [Item] = []
}

class SubTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var array: Items?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(_ arr: Items) {
        self.array = arr
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.reloadData()
    }
}

extension SubTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = array?.items[indexPath.row].title
        return cell
    }
}
