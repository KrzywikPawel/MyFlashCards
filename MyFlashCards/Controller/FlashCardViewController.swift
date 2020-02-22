//
//  FlashCardViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 19/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
import Foundation
class FlashCardViewController: UIViewController {
    //     MARK: alert wszystkie slowka pokazane reset or back to main or show this whose dont know
    @IBOutlet var categoryView: CategoryView!
    var divisor: CGFloat!
    var isPolishSite = false
    let backCardPoint = CGPoint(x: 221, y: 275)
    var words = [WordStruct]()
    var showedCard = 0
    var flashCard = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeData()
        divisor = (view.frame.width / 2) / 0.61
    }
    
    private func takeData(){
        let categoryData =  TakeCategory()
//        MARK: change medicine to name from circle collection categories
        categoryData.parseData("Medicine") { (takedWords) in
            self.words = takedWords
            self.words.shuffle()
            self.categoryView.setWordLbl(self.words[self.showedCard].ang)
            self.showFlashCard()
        }
    }
    
    func showFlashCard() {
        //        MARK: exception when index out of range
        if showedCard >= words.count {
            categoryView.setWordLbl("koniec slowek")
        } else {
            categoryView.backCardToStartPosition(flashCard,backCardPoint)
            categoryView.setWordLbl(words[showedCard].ang)
        }
    }
    
    @IBAction func flashCardTapGesture(_ sender: UITapGestureRecognizer) {
        categoryView.transitionFlashCardView()
        if isPolishSite {
            isPolishSite = false
            categoryView.setWordLbl(words[showedCard].ang)
        } else {
            isPolishSite = true
            categoryView.setWordLbl(words[showedCard].pol)
        }
    }
    
    @IBAction func flashCardPanGesture(_ sender: UIPanGestureRecognizer) {
        flashCard = sender.view!
        let point = sender.translation(in: view)
        flashCard.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = flashCard.center.x - view.center.x
        let scale = min(100/abs(xFromCenter), 1)
        flashCard.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            categoryView.showThumbUp(alphaCalculate)
        } else {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            categoryView.showThumbDown(alphaCalculate)
        }
        
        //        MARK: czy card potrzebny? moze wystarczy flashcardview
        if sender.state == UIGestureRecognizer.State.ended {
            if flashCard.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    self.flashCard.center = CGPoint(x: self.flashCard.center.x - 200, y: self.flashCard.center.y)
                    self.flashCard.alpha = 0
                }
                showedCard = showedCard + 1
                categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
                showFlashCard()
            } else if flashCard.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    self.flashCard.center = CGPoint(x: self.flashCard.center.x + 200, y: self.flashCard.center.y)
                    self.flashCard.alpha = 0
                }
                showedCard = showedCard + 1
                categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
                showFlashCard()
            }
            categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
        }
    }
}
