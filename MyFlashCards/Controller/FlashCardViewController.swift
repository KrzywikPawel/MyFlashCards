//
//  FlashCardViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 19/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
import Foundation
class FlashCardViewController: UIViewController{
    @IBOutlet var setView: CategoryView!
    var categoryName = ""
    var categoryType = ""
    var divisor: CGFloat!
    var isPolishSite = false
    let backCardPoint =  CGPoint(x: 221, y: 300)
    var words = [WordStruct]()
    var hardWords = [WordStruct]()
    var showedCard = 0
    var flashCard = UIView()
    let endWord = "end words"
    let emptyHardwords = "your hard words is empty"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        setView.delegate = self
        setView.setNavigationController(self.navigationController!)
        divisor = (view.frame.width / 2) / 0.61
        checkType()
    }
    
    internal func checkType(){
        switch categoryType {
        case "System":
            takeDataFromDatabase()
            break
        case "YourCategory":
            setView.createDeleteBtnIfYourCategory(navigationItem)
            takeDataFromUserDefaults()
            break
        default:
            print("error categoryType")
        }
    }
    
    private func takeDataFromDatabase(){
        let categoryData =  TakeCategory()
        //        MARK: change medicine to name from circle collection categories
        categoryData.parseData(categoryName) { (takedWords) in
            self.words = takedWords
            self.words.shuffle()
            self.setView.setWordLbl(self.words[self.showedCard].ang)
            self.showFlashCard()
        }
    }
    
    private func takeDataFromUserDefaults(){
        let parser = OperationInMemory()
        words = parser.loadCategory(categoryName)
        words.shuffle()
        setView.setWordLbl(words[showedCard].ang)
        showFlashCard()
    }
    
    private func showFlashCard() {
        if showedCard >= words.count {
            setView.setWordLbl(endWord)
        } else {
            setView.backCardToStartPosition(flashCard,backCardPoint)
            setView.setWordLbl(words[showedCard].ang)
        }
    }
    
    @IBAction private func flashCardTapGesture(_ sender: UITapGestureRecognizer) {
        setView.transitionFlashCardView()
        let onFlashCard = self.setView.takeWordLblText()
        if onFlashCard != endWord && onFlashCard != emptyHardwords{
            if isPolishSite {
                isPolishSite = false
                setView.setWordLbl(words[showedCard].ang)
            } else {
                isPolishSite = true
                setView.setWordLbl(words[showedCard].pol)
            }
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
        //        MARK: animation refactor to view or stay in controller?
        if sender.state == UIGestureRecognizer.State.ended {
            if flashCard.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    self.flashCard.center = CGPoint(x: self.flashCard.center.x - 200, y: self.flashCard.center.y)
                    self.flashCard.alpha = 0
                    self.addWordToHard()
                }
                self.showedCard = self.showedCard + 1
                setView.backCardToStartPosition(setView.flashCardView,backCardPoint)
                showFlashCard()
            } else if flashCard.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    self.flashCard.center = CGPoint(x: self.flashCard.center.x + 200, y: self.flashCard.center.y)
                    self.flashCard.alpha = 0
                    self.deleteFromHardWord()
                }
                showedCard = showedCard + 1
                setView.backCardToStartPosition(setView.flashCardView,backCardPoint)
                showFlashCard()
            }
            setView.backCardToStartPosition(setView.flashCardView,backCardPoint)
        }
    }
    
    private func deleteFromHardWord() {
        let onFlashCard = setView.takeWordLblText()
        if onFlashCard != endWord && onFlashCard != emptyHardwords {
            if let index = hardWords.firstIndex(of: words[showedCard]) {
                hardWords.remove(at: index)
            }
        }
    }
    
    private func addWordToHard() {
        let textInSing = setView.takeWordLblText()
        if textInSing != endWord && textInSing != emptyHardwords {
            if hardWords.contains(where: {$0 == self.words[self.showedCard]}) {
                //check duplicate
            } else {
                self.hardWords.append(self.words[self.showedCard])
            }
        }
    }
}




