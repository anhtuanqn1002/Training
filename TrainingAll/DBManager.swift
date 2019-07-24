//
//  DBManager.swift
//  TrainingAll
//
//  Created by TuanNVA on 7/24/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import SQLite
import RealmSwift

struct DrugCategory {
    let id: Int
    let name: String
    let parentID: Int
    let type: Int
    
    init?(row: Row) {
        do {
            id = try row.get(Expression<Int>("id"))
            name = try row.get(Expression<String>("name"))
            parentID = try row.get(Expression<Int>("parent_id"))
            type = try row.get(Expression<Int>("type"))
        } catch {
            return nil
        }
    }
}

struct Drug {
    let id: Int
    let drugRegisterID: String
    let pharmaceuticalForm: String
    let proprietaryName: String
    let drugImage: String
    let name: String
    let isViewed: Int
    let status: Int
    let categoryID: Int
    let thanhphan: String
    let infor: String
    let nameNoAccent: String
    
    init?(row: Row) {
        do {
            id = try row.get(Expression<Int>("id"))
            drugRegisterID = try row.get(Expression<String>("drug_register_id"))
            pharmaceuticalForm = try row.get(Expression<String>("pharmaceutical_form"))
            proprietaryName = try row.get(Expression<String>("proprietary_name"))
            drugImage = try row.get(Expression<String>("drug_image"))
            name = try row.get(Expression<String>("name"))
            isViewed = try row.get(Expression<Int>("is_viewed"))
            status = try row.get(Expression<Int>("status"))
            categoryID = try row.get(Expression<Int>("category_id"))
            thanhphan = try row.get(Expression<String>("thanhphan"))
            infor = try row.get(Expression<String>("infor"))
            nameNoAccent = try row.get(Expression<String>("name_no_accent"))
        } catch {
            return nil
        }
    }
}

final class DBManager {
    private init() {}
    static let shared = DBManager()

    func getCategories() {
        guard let path = Bundle.main.path(forResource: "drugs", ofType: "sqlite") else { return }
        let db = try! Connection(path)
        let drugCategoryTable = Table("tbDrugCategory")
        let drugCategory: [DrugCategory] = try! db.prepare(drugCategoryTable).compactMap { row in
            return DrugCategory(row: row)
        }
        print(drugCategory.count)
        
        let drugTable = Table("tbDrug")
        let drug: [Drug] = try! db.prepare(drugTable).compactMap { row in
            return Drug(row: row)
        }
        print(drug.count)
    }
}
