//
//  SaveReadMemory.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 24/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
class OperationInMemory {
    let arrayWithCategoriesNamesInMemory = "yourCategoriesNames"
    let namedHardWordArrayInMemory = "hardWords"
    
    private func saveNameCategory(_ categoryName: String) {
        if var yourCategoriesNames = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory) {
            yourCategoriesNames.append(categoryName)
            UserDefaults.standard.set(yourCategoriesNames,forKey: arrayWithCategoriesNamesInMemory)
        } else {
            var categoryNameArray = [String]()
            categoryNameArray.append(categoryName)
            UserDefaults.standard.set(categoryNameArray,forKey: arrayWithCategoriesNamesInMemory)
        }
    }
    
    func replaceHardWords(_ hardWords: [WordStruct]) {
        deleteCategory(namedHardWordArrayInMemory)
        saveNewArray(hardWords, key: namedHardWordArrayInMemory)
    }
    
    
    /// - parameter categoryName: without this parameter, func saved hardwords
    func saveToMemory(categoryName:String = "0" , _ wordsToSave: [WordStruct]) {
        switch categoryName {
        case "0":
            if let isInMemory = UserDefaults.standard.value([WordStruct].self, forKey: namedHardWordArrayInMemory) {
                saveIfArrayExist(where: isInMemory, what: wordsToSave, key: namedHardWordArrayInMemory)
            } else {
                saveNewArray(wordsToSave, key: namedHardWordArrayInMemory)
            }
        default:
            if let isInMemory = UserDefaults.standard.value([WordStruct].self, forKey: categoryName) {
                saveIfArrayExist(where: isInMemory, what: wordsToSave, key: categoryName)
            } else {
                saveNameCategory(categoryName)
                saveNewArray(wordsToSave, key: categoryName)
            }
        }
    }
    
    func loadCategory(_ categoryName: String) -> [WordStruct] {
        if let categoryIsInMemory = UserDefaults.standard.value([WordStruct].self, forKey: categoryName) {
            return categoryIsInMemory
        } else {
            let emptyCategory = [WordStruct]()
            return emptyCategory
        }
    }
    
    func loadNamesArray() -> [String] {
        if let namesInArray = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory) {
            return namesInArray
        } else {
            let emptyNamesArray = [String]()
            return emptyNamesArray
        }
    }
    
    func deleteCategory(_ categoryName: String) {
        let operationInMemory = UserDefaults.standard
        operationInMemory.removeObject(forKey: categoryName)
        var categoriesNamesArray = UserDefaults.standard.stringArray(forKey: arrayWithCategoriesNamesInMemory)
        if let deleteIndex = categoriesNamesArray!.firstIndex(of: categoryName) {
            categoriesNamesArray?.remove(at: deleteIndex)
            operationInMemory.set(categoriesNamesArray,forKey: arrayWithCategoriesNamesInMemory)
        }
    }
    
    private func saveIfArrayExist(where writedWords: [WordStruct], what hardWords:[WordStruct], key: String) {
        var wordsInMemory = writedWords
        for wordToSave in hardWords {
            if wordsInMemory.contains(where: {$0 == wordToSave}) {
                
            } else {
                wordsInMemory.append(wordToSave)
            }
        }
        UserDefaults.standard.set(encodable: wordsInMemory, forKey: key)
    }
    
    private func saveNewArray(_ hardWords: [WordStruct], key: String) {
        UserDefaults.standard.set(encodable: hardWords, forKey: key)
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
