//
//  CategoryView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 21/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit

protocol BtnActionInFlashCardView: class {
    func loadWordsAgainBtn(_ sender:UIButton)
    func reviewHardWordsBtn(_ sender:UIButton)
    func deleteCategory()
    func backBtnAction()
    func saveHardWord()
    func dontSaveHardWord()
}

class CategoryView: UIView {
    @IBOutlet weak private var wordLbl: UILabel!
    @IBOutlet weak var flashCardImg: UIImageView!
    @IBOutlet weak  var flashCardView: UIView!
    @IBOutlet weak private var thumbDown: UIImageView!
    @IBOutlet weak private var thumbUp: UIImageView!
    @IBOutlet weak var loadAgainBtn: UIButton!
    @IBOutlet weak var reviewHardBtn: UIButton!
    
    private let cardViewImg = "flashCard"
    private let thumbUpImgName = "thumbUp"
    private let thumbDownImgName = "thumbDown"
    weak var delegate: BtnActionInFlashCardView?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        loadAgainBtn.titleLabel?.alpha = 0.68
        //        reviewHardBtn.titleLabel?.alpha = 0.68
    }
    
    func setWordLbl(_ word: String) {
        wordLbl.text = word
    }
    
    func transitionFlashCardView() {
        UIView.transition(with: flashCardView, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func createDeleteBtnIfYourCategory(_ navigationItem: UINavigationItem) {
        let deleteBtn = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteCategory(_:)))
        navigationItem.rightBarButtonItem = deleteBtn
    }
    
    @objc func deleteCategory(_ sender:UIButton) {
        delegate?.deleteCategory()
    }
    
    private func setImgFlashCard() {
        flashCardImg.image = UIImage(named: cardViewImg)
    }
    
    func showThumbUp(_ alphaCalculate: CGFloat) {
        let thumbUpImg = UIImage(named: thumbUpImgName)
        thumbUp.image = thumbUpImg
        thumbUp.tintColor = .green
        thumbUp.alpha = alphaCalculate
    }
    
    func showThumbDown(_ alphaCalculate: CGFloat) {
        let thumbDownImg = UIImage(named: thumbDownImgName)
        thumbDown.image = thumbDownImg
        thumbDown.tintColor = .red
        thumbDown.alpha = alphaCalculate
    }
    
    func backCardToStartPosition(_ card: UIView, _ backCardPoint: CGPoint) {
        UIView.animate(withDuration: 0.4, animations: {
            self.flashCardView.center = backCardPoint
            card.transform = CGAffineTransform.identity
            card.alpha = 1
            self.thumbDown.alpha = 0
            self.thumbUp.alpha = 0
        })
    }
    
    func takeWordLblText() -> String {
        return wordLbl.text!
    }
    
    func setNavigationController(_ navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    func createBackBtnItem(_ navigationItem: UINavigationItem) {
        let createBackBtn = CreateBarBackBtn()
        let backBtn = createBackBtn.setBarBackBtn()
        backBtn.addTarget(self, action: #selector(backToMainScreen(_:)), for: .touchUpInside)
        let leftBarBtnItem = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = leftBarBtnItem
    }
    
    func createAlertSaveHardWord() -> UIAlertController {
        let saveAlert = UIAlertController(title: "write down hard words?", message: "you can back to learn it later", preferredStyle: .alert)
        let saveOption = UIAlertAction(title: "save", style: .default) { (result) in
            self.delegate?.saveHardWord()
        }
        saveAlert.addAction(saveOption)
        let dontSave = UIAlertAction(title: "don't save", style: .default) { (result) in
            self.delegate?.dontSaveHardWord()
        }
        saveAlert.addAction(dontSave)
        return saveAlert
    }
    
    @objc func backToMainScreen(_ sender:UIButton) {
        delegate?.backBtnAction()
    }
    
    @IBAction func loadAgainBtn(_ sender: UIButton) {
        delegate?.loadWordsAgainBtn(sender)
    }
    @IBAction func reviewHardBtn(_ sender: UIButton) {
        delegate?.reviewHardWordsBtn(sender)
    }
}
