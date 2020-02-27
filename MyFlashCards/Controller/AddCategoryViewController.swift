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
        let parser = OperationInMemory()
        let wordsInCategory = parser.loadCategory(name)
        return wordsInCategory
    }
    
    func addWordToCategory() {
        let category = setView.takeCategoryNameTextField()
        let angWord = setView.takeAngTextField()
        let polWord = setView.takePolTextField()
        setView.clearTextFields()
        let wordToSave = WordStruct(angWord, polWord)
        OperationInMemory().saveCategory(category, wordToSave: wordToSave)
    }
    
    func backToYourCategoriesScreen() {
        navigationController?.popViewController(animated: true)
    }
}
