//
//  SaveReadMemory.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 24/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
class OperationInMemory{
    let arrayWithCategoriesNamesInMemory = "yourCategoriesNames"
    
    func saveCategory(_ categoryName: String, wordToSave: WordStruct){
        if var isInMemory = UserDefaults.standard.value([WordStruct].self, forKey: categoryName){
            if isInMemory.contains(where: {$0 == wordToSave}){
                
            } else {
                isInMemory.append(wordToSave)
                UserDefaults.standard.set(encodable: isInMemory, forKey: categoryName)
                saveNameCategory(categoryName)
            }
        } else {
            var newCategory = [WordStruct]()
            newCategory.append(wordToSave)
            UserDefaults.standard.set(encodable: newCategory, forKey: categoryName)
            saveNameCategory(categoryName)
        }
    }
    
    private func saveNameCategory(_ categoryName: String){
        if var yourCategoriesNames = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory) {
            print("zapis \(categoryName)")
            yourCategoriesNames.append(categoryName)
            UserDefaults.standard.set(yourCategoriesNames,forKey: arrayWithCategoriesNamesInMemory)
        } else {
            var array = [String]()
            array.append(categoryName)
            UserDefaults.standard.set(array,forKey: arrayWithCategoriesNamesInMemory)
        }
    }
    
    func loadCategory(_ categoryName: String) -> [WordStruct]{
        if let isInMemory = UserDefaults.standard.value([WordStruct].self, forKey: categoryName){
            return isInMemory
        } else {
            let emptyCategory = [WordStruct]()
            return emptyCategory
        }
    }
    
    func loadNamesArray() -> [String]{
        if let namesInArray = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory){
            return namesInArray
        } else {
            //            return empty doesnt throw exception but meaby dont see anybody in other func taken this
            let emptyNamesArray = [String]()
            return emptyNamesArray
        }
    }
    
    func deleteCategory(_ categoryName: String){
        let memory = UserDefaults.standard
        memory.removeObject(forKey: categoryName)
        var categoriesNamesArray = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory)
        if let deleteIndex = categoriesNamesArray!.firstIndex(of: categoryName){
            categoriesNamesArray?.remove(at: deleteIndex)
            UserDefaults.standard.set(categoriesNamesArray,forKey: arrayWithCategoriesNamesInMemory)
        }
    }
}

fileprivate extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
