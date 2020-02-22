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
    //    MARK: randomize sequence in words
    @IBOutlet var categoryView: CategoryView!
    var divisor: CGFloat!
    var isPolishSite = false
    let backCardPoint = CGPoint(x: 221, y: 275)
    var words = [WordStruct]()
    var showedCard = 0
    var card = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        takeData()
        divisor = (view.frame.width / 2) / 0.61
    }
    
    private func takeData(){
        let categoryData =  TakeCategory()
        categoryData.parseData("Medicine") { (words) in
            self.words = words
            self.categoryView.setWordLbl(self.words[self.showedCard].ang)
            self.showFlashCard()
        }
    }
    
    func showFlashCard(){
        print("el")
//        MARK: exception when index out of range
        print(words.count)
        print(words[showedCard].ang)
        categoryView.backCardToStartPosition(card,backCardPoint)
        categoryView.setWordLbl(words[showedCard].ang)
        //        }
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
        card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = card.center.x - view.center.x
        let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        if xFromCenter > 0 {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            categoryView.showThumbUp(alphaCalculate)
        } else {
            let alphaCalculate = abs(xFromCenter) / view.center.x
            categoryView.showThumbDown(alphaCalculate)
        }
        
        //        MARK: tutaj dodanie next fisha
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    self.card.center = CGPoint(x: self.card.center.x - 200, y: self.card.center.y)
                    self.card.alpha = 0
                }
                showedCard = showedCard + 1
                categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
                showFlashCard()
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    self.card.center = CGPoint(x: self.card.center.x + 200, y: self.card.center.y)
                    self.card.alpha = 0
                }
                showedCard = showedCard + 1
                categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
                showFlashCard()
            }
//            categoryView.backCardToStartPosition(card,backCardPoint)
            categoryView.backCardToStartPosition(categoryView.flashCardView,backCardPoint)
        }
    }
}
