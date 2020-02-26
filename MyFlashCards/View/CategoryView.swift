//
//  CategoryView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 21/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit

protocol BtnAction: class {
    func loadAgainBtn(_ sender:UIButton)
    func reviewHardBtn(_ sender:UIButton)
    func deleteCategory()
}

class CategoryView: UIView {
    @IBOutlet weak private var wordLbl: UILabel!
    @IBOutlet weak private var flashCardImg: UIImageView!
    @IBOutlet weak  var flashCardView: UIView!
    @IBOutlet weak private var thumbDown: UIImageView!
    @IBOutlet weak private var thumbUp: UIImageView!
    @IBOutlet weak var loadAgainBtn: UIButton!
    @IBOutlet weak var reviewHardBtn: UIButton!
    
    private let cardViewImg = "flashCard"
    private let thumbUpImgName = "thumbUp"
    private let thumbDownImgName = "thumbDown"
    weak var delegate: BtnAction?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        loadAgainBtn.titleLabel?.alpha = 0.68
        reviewHardBtn.titleLabel?.alpha = 0.68
        setBackground()
        setFlashCard()
    }
    
    
    
    func setWordLbl(_ word: String){
        wordLbl.text = word
    }
    
    func transitionFlashCardView(){
        UIView.transition(with: flashCardView, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    @IBAction func loadAgainBtn(_ sender: UIButton) {
        delegate?.loadAgainBtn(sender)
    }
    @IBAction func reviewHardBtn(_ sender: UIButton) {
        delegate?.reviewHardBtn(sender)
    }
    
    
    private func setBackground() {
        let backgroundImg = UIImage(named: "flashCardBackground")
        let backgroundImageView = UIImageView.init(frame: self.frame)
        backgroundImageView.image = backgroundImg
        backgroundImageView.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImageView, at: 0)
    }
    
    private func setFlashCard(){
        flashCardView.backgroundColor = .clear
        flashCardView.translatesAutoresizingMaskIntoConstraints = false
        flashCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        flashCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -267).isActive = true
        flashCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 67).isActive = true
        flashCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        flashCardView.widthAnchor.constraint(equalToConstant: 308).isActive = true
        flashCardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func createDeleteBtnIfYourCategory(_ navigationItem: UINavigationItem){
        let deleteBtn = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteCategory(_:)))
        navigationItem.rightBarButtonItem = deleteBtn
    }
    
    @objc func deleteCategory(_ sender:UIButton){
        delegate?.deleteCategory()
    }
    
    private func setImgFlashCard(){
        flashCardImg.image = UIImage(named: cardViewImg)
    }
    
    func showThumbUp(_ alphaCalculate: CGFloat){
        let thumbUpImg = UIImage(named: thumbUpImgName)
        thumbUp.image = thumbUpImg
        thumbUp.tintColor = .green
        thumbUp.alpha = alphaCalculate
    }
    
    func showThumbDown(_ alphaCalculate: CGFloat){
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
    
    func takeWordLblText() -> String{
        return wordLbl.text!
    }
    
    func setNavigationController(_ navigationController: UINavigationController){
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
    
    
    
}
