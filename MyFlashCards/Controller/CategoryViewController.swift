//
//  FlashCardViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 19/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
import Foundation
class CategoryViewController: UIViewController{
    @IBOutlet var setView: CategoryView!
    var categoryName = ""
    var categoryType = ""
    var isHardWordsView = false
    var divisor: CGFloat!
    var isPolishSite = false
    var backCardPoint = CGPoint()
    var words = [WordStruct]()
    var hardWords = [WordStruct]()
    var showedCard = 0
    var flashCard = UIView()
    let operationInMemory = OperationInMemory()
    let endWordsComunicate = "end words"
    let reloadWordsComunicate = "load or add another words"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        backCardPoint = setView.flashCardView.center
        print(setView.flashCardView.center)
        setView.delegate = self
        setView.setNavigationController(self.navigationController!)
        setView.createBackBtnItem(self.navigationItem)
        divisor = (view.frame.width / 2) / 0.61
        checkType()
    }
    
    internal func checkType() {
        switch categoryType {
        case "System":
            takeDataFromDatabase()
            break
        case "YourCategory":
            setView.createDeleteBtnIfYourCategory(navigationItem)
            takeDataFromUserDefaults()
            break
        case "HardWords":
            categoryName = operationInMemory.namedHardWordArrayInMemory
            takeDataFromUserDefaults()
            break
        default:
            print("error categoryType")
        }
    }
    
    private func takeDataFromDatabase(){
        let categoryData =  TakeCategory()
        categoryData.parseData(categoryName) { (takedWords) in
            self.words = takedWords
            self.flashCardStartAction()
        }
    }
    
    private func takeDataFromUserDefaults() {
        words = operationInMemory.loadCategory(categoryName)
        if isHardWordsView == true {
            hardWords = words
        }
        flashCardStartAction()
    }
    
    private func flashCardStartAction() {
        if words.count != 0 {
            words.shuffle()
            setView.setWordLbl(words[showedCard].ang)
            showFlashCard()
        } else {
            setView.setWordLbl(endWordsComunicate)
            setView.backCardToStartPosition(flashCard,backCardPoint)
        }
    }
    
    private func showFlashCard() {
        if showedCard >= words.count {
            setView.backCardToStartPosition(flashCard,backCardPoint)
            if setView.takeWordLblText() == endWordsComunicate {
                setView.setWordLbl(reloadWordsComunicate)
            }else {
                setView.setWordLbl(endWordsComunicate)
            }
        } else {
            setView.backCardToStartPosition(flashCard,backCardPoint)
            setView.setWordLbl(words[showedCard].ang)
        }
    }
    
    @IBAction private func flashCardTapGesture(_ sender: UITapGestureRecognizer) {
        swipeAndGoToStartPositionFlashCard()
    }
    
    private func swipeAndGoToStartPositionFlashCard() {
        setView.transitionFlashCardView()
        let onFlashCard = self.setView.takeWordLblText()
        if onFlashCard != endWordsComunicate && onFlashCard != reloadWordsComunicate{
            if isPolishSite {
                isPolishSite = false
                setView.setWordLbl(words[showedCard].ang)
            } else {
                isPolishSite = true
                setView.setWordLbl(words[showedCard].pol)
            }
        }else if onFlashCard == reloadWordsComunicate {
            setView.setWordLbl(endWordsComunicate)
        }else {
            setView.setWordLbl(reloadWordsComunicate)
        }
    }
    
    @IBAction private func flashCardPanGesture(_ sender: UIPanGestureRecognizer) {
        flashCard = sender.view!
        let point = sender.translation(in: view)
        flashCard.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = flashCard.center.x - view.center.x
        let scale = min(100/abs(xFromCenter), 1)
        flashCard.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            setView.showThumbUp(alphaCalculate)
        } else {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            setView.showThumbDown(alphaCalculate)
        }
        endedHoldFlashCard(sender)
    }
    
    private func endedHoldFlashCard(_ sender: UIPanGestureRecognizer) {
        //        MARK: animation refactor to view or stay in controller?
        if sender.state == UIGestureRecognizer.State.ended {
            if flashCard.center.x < 75 {
                swipeLeft()
            } else if flashCard.center.x > (view.frame.width - 75) {
                swipeRight()
            }else{
                swipeAndGoToStartPositionFlashCard()
                setView.backCardToStartPosition(flashCard,backCardPoint)
                
            }
        }
    }
    
    private func swipeLeft() {
        UIView.animate(withDuration: 0.3) {
            self.flashCard.center = CGPoint(x: self.flashCard.center.x - 200, y: self.flashCard.center.y)
            self.flashCard.alpha = 0
            self.addWordToHard()
        }
        nextFlashCard()
    }
    
    private func swipeRight() {
        UIView.animate(withDuration: 0.3) {
            self.flashCard.center = CGPoint(x: self.flashCard.center.x + 200, y: self.flashCard.center.y)
            self.flashCard.alpha = 0
            self.deleteFromHardWord()
        }
        nextFlashCard()
    }
    
    private func nextFlashCard() {
        showedCard = showedCard + 1
        showFlashCard()
    }
    
    private func deleteFromHardWord() {
        let wordOnFlashCard = setView.takeWordLblText()
        if wordOnFlashCard != endWordsComunicate && wordOnFlashCard != reloadWordsComunicate {
            if let index = hardWords.firstIndex(of: words[showedCard]) {
                hardWords.remove(at: index)
            }
        }
    }
    
    private func addWordToHard() {
        let wordOnFlashCard = setView.takeWordLblText()
        addWordToTemporaryHard(wordOnFlashCard)
    }
    
    private func addWordToTemporaryHard(_ wordOnFlashCard: String) {
        if wordOnFlashCard != endWordsComunicate && wordOnFlashCard != reloadWordsComunicate {
            if hardWords.contains(where: {$0 == self.words[self.showedCard]}) {
                //check duplicate
            } else {
                self.hardWords.append(self.words[self.showedCard])
            }
        }
    }
}




