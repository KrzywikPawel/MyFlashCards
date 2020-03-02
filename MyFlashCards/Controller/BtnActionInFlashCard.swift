//
//  BtnActionInFlashCard.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 26/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
extension CategoryViewController: BtnActionInFlashCardView {
    
    func backBtnAction() {
        if hardWords.count != 0 {
            let saveAlert = setView.createAlertSaveHardWord()
            self.present(saveAlert,animated: true)
        }
    }
    
    func deleteCategory() {
        let deleteYourCategory = OperationInMemory()
        deleteYourCategory.deleteCategory(categoryName)
        backToYourCategoriesView()
        
    }
    
    func backToYourCategoriesView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadAgainBtn(_ sender: UIButton) {
        showedCard = 0
        checkType()
    }
    
    
    func reviewHardBtn(_ sender: UIButton) {
        if hardWords.count == 0 {
            setView.setWordLbl(emptyHardwords)
        } else {
            showedCard = 0
            words = hardWords
            setView.setWordLbl(words[0].ang)
        }
    }
    
    func saveHardWord() {
        let operationInMemory = OperationInMemory()
        operationInMemory.saveToMemory(hardWords)
        self.navigationController?.popViewController(animated: true)
    }
    
    func dontSaveHardWord() {
        self.navigationController?.popViewController(animated: true)
    }
}
