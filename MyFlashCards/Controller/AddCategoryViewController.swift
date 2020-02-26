//
//  AddCategoryViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    @IBOutlet var setView: AddCategoryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.setNavigationController(self.navigationController!)
        setView.addBtn.addTarget(self, action: #selector(addWordToCategory(_:)), for: .touchUpInside)
    }
    
    @objc private func addWordToCategory(_ sender: UIButton){
        let category = setView.takeCategoryNameTextField()
        let angWord = setView.takeAngTextField()
        let polWord = setView.takePolTextField()
        let wordToSave = WordStruct(angWord, polWord)
        OperationInMemory().saveCategory(category, wordToSave: wordToSave)
    }
    
    private func takeCategory(_ name: String) -> [WordStruct]{
        let parser = OperationInMemory()
        let wordsInCategory = parser.loadCategory(name)
        return wordsInCategory
    }
    
}
