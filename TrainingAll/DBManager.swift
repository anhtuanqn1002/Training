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
    
    init?(row: Row, template: String = "") {
        var prefix = ""
        if !template.isEmpty {
            prefix = "\"\(template)\".\""
        }
        do {
            
            id = try row.get(Expression<Int>("\(prefix)id\""))
            drugRegisterID = try row.get(Expression<String>("\(prefix)drug_register_id\""))
            pharmaceuticalForm = try row.get(Expression<String>("\(prefix)pharmaceutical_form\""))
            proprietaryName = try row.get(Expression<String>("\(prefix)proprietary_name\""))
            drugImage = try row.get(Expression<String>("\(prefix)drug_image\""))
            name = try row.get(Expression<String>("\(prefix)name\""))
            isViewed = try row.get(Expression<Int>("\(prefix)is_viewed\""))
            status = try row.get(Expression<Int>("\(prefix)status\""))
            categoryID = try row.get(Expression<Int>("\(prefix)category_id\""))
            thanhphan = try row.get(Expression<String>("\(prefix)thanhphan\""))
            infor = try row.get(Expression<String>("\(prefix)infor\""))
            nameNoAccent = try row.get(Expression<String>("\(prefix)name_no_accent\""))
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
        
        let categoriesTable = drugCategoryTable.filter(Expression<Int>("parent_id") == 0)
        let categories = try! db.prepare(categoriesTable).compactMap { DrugCategory(row: $0) }
        print(categories.count)
        
        let subCategoriesTable = drugCategoryTable.filter(Expression<Int>("parent_id") == 161)
        let subCategories = try! db.prepare(subCategoriesTable).compactMap { DrugCategory(row: $0) }
        print(subCategories.count)
        
        let subCategoriesTable2 = drugCategoryTable.filter(Expression<Int>("parent_id") == 162)
        let subCategories2 = try! db.prepare(subCategoriesTable2).compactMap { DrugCategory(row: $0) }
        print(subCategories2.count)
        
        
        let drugCategoryMappingTable = Table("tbDrugCategoryMapping")
        let id = Expression<Int>("id")
        let drugRegisterID = Expression<String>("drug_register_id")
//        drugCategoryMappingTable[*]
        let query = drugCategoryMappingTable
//            .select(drugCategoryMappingTable[*])
//            .select(drugTable[id])
            .join(.leftOuter, drugTable, on: Expression<Int>("id_drug") == drugTable[Expression<Int>("id")])
            .filter(Expression<Int>("id_cat") == subCategories2[0].id)
        
        
        
        
//        let getDrug = try! db.prepare("Select * from tbDrugCategoryMapping join tbDrug on id_drug = tbDrug.id where id_cat = 163")
//        getDrug.compactMap { (result) -> Drug? in
//            result[0]
//            return nil
//        }
//        let stmt = try db.prepare("SELECT id, email FROM users")
//        for row in stmt {
//            for (index, name) in stmt.columnNames.enumerated() {
//                print ("\(name):\(row[index]!)")
//                // id: Optional(1), email: Optional("alice@mac.com")
//            }
//        }
        
//        let drugs = try! db.prepare("Select * from tbDrugCategoryMapping join tbDrug on id_drug = tbDrug.id where id_cat = 163").compactMap { Drug(row: $0) }
        
        let drugs = try! db.prepare(query).compactMap { Drug(row: $0, template: "tbDrug") }
        print(drugs.count)
    }
}
