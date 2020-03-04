//
//  AddCategoryViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController, AddCategoryBtnAction {
    
    @IBOutlet var setView: AddCategoryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.delegate = self
        setView.setNavigationController(self.navigationController!)
        setView.createBackBtnItem(self.navigationItem)
    }
    
    private func takeCategory(_ name: String) -> [WordStruct]{
        let operationInMemory = OperationInMemory()
        let wordsInCategory = operationInMemory.loadCategory(name)
        return wordsInCategory
    }
    
    func addWordToCategory() {
        let category = setView.takeCategoryNameTextField()
        let angWord = setView.takeAngTextField()
        let polWord = setView.takePolTextField()
        setView.clearWordsTextFields()
        let wordToSave = WordStruct(angWord, polWord)
        let arrayWithAddWord = [wordToSave]
        OperationInMemory().saveToMemory(categoryName: category, arrayWithAddWord)
    }
    
    func backToYourCategoriesScreen() {
        navigationController?.popViewController(animated: true)
    }
}
