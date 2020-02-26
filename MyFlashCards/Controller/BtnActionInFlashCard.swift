//
//  BtnActionInFlashCard.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 26/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
extension FlashCardViewController: BtnAction{
    func deleteCategory() {
        let deleteYourCategory = OperationInMemory()
        deleteYourCategory.deleteCategory(categoryName)
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
