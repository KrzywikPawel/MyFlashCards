//
//  SaveReadMemory.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 24/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
class OperationInMemory{
    
    func saveCategory(_ categoryName: String, wordToSave: WordStruct){
        if var isInMemory = UserDefaults.standard.value([WordStruct].self, forKey: categoryName){
            if isInMemory.contains(where: {$0 == wordToSave}){
                
            } else {
                isInMemory.append(wordToSave)
                UserDefaults.standard.set(encodable: isInMemory, forKey: categoryName)
            }
        } else {
            var newCategory = [WordStruct]()
            newCategory.append(wordToSave)
            UserDefaults.standard.set(encodable: newCategory, forKey: categoryName)
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
    
    func deleteCategory(_ categoryName: String){
        let memory = UserDefaults.standard
        memory.removeObject(forKey: categoryName)
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
