//
//  BtnActionInFlashCard.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 26/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
extension CategoryViewController: BtnActionInFlashCardView {
    
    func backToMainScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func deleteCategory() {
        let deleteYourCategory = OperationInMemory()
        deleteYourCategory.deleteCategory(categoryName)
        backToYourCategoriesView()
        
    }
    
    func backToYourCategoriesView() {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainstoryboard.instantiateViewController(identifier: "YourCategoriesViewController") as! YourCategoriesViewController
        navigationController?.pushViewController(pushVC, animated: true)
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
}
