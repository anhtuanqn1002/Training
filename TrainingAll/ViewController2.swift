//
//  ViewController2.swift
//  TrainingAll
//
//  Created by TuanNVA on 4/19/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var array: [Items] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "SubTableViewCell", bundle: nil), forCellReuseIdentifier: "SubTableViewCell")
        for i in 0..<4 {
            let items = Items()
            items.items.append(Item(title: "\(i * 3 + 1)"))
            items.items.append(Item(title: "\(i * 3 + 2)"))
            items.items.append(Item(title: "\(i * 3 + 3)"))
            items.items.append(Item(title: "\(i * 3 + 4)"))
            items.items.append(Item(title: "\(i * 3 + 5)"))
            array.append(items)
        }
        let items1 = Items()
        items1.items.append(Item(title: "\(5 * 3 + 1)"))
        items1.items.append(Item(title: "\(5 * 3 + 2)"))
        array.append(items1)
        
        let items = Items()
        items.items.append(Item(title: "\(6 * 3 + 1)"))
        items.items.append(Item(title: "\(6 * 3 + 2)"))
        array.append(items)
        tableView.reloadData()
        tableView.rowHeight = 300
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubTableViewCell", for: indexPath) as! SubTableViewCell
        cell.display(array[indexPath.row])
        return cell
    }
}
