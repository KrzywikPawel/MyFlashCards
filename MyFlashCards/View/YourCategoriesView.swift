//
//  YourCategoriesView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit
import ACBRadialCollectionView
protocol BtnActionInYourCategories: class {
    func addNewCategoryBtn()
}

class YourCategoriesView: UIView{
    
    @IBOutlet weak var yourCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var addNewCategoryBtn: UIButton!
    weak var delegate: BtnActionInYourCategories?
    
    
    override func awakeFromNib() {
        addNewCategoryBtn.titleLabel?.alpha = 0.68
        setBackground()
        setYourCategoriesCollectionView()
    }
    
    private func setBackground(){
        let backgroundImg = UIImage(named: "yourCategoriesBackground")
        let backgroundView = UIImageView.init(frame: self.frame)
        backgroundView.image = backgroundImg
        backgroundView.contentMode = .scaleAspectFit
        self.insertSubview(backgroundView, at: 0)
    }
    
    @IBAction func addNewCategoryBtn(_ sender: UIButton) {
        delegate?.addNewCategoryBtn()
    }
    
    
    private func setYourCategoriesCollectionView() {
        yourCategoriesCollectionView.backgroundColor = .clear
        let itemRadius: CGFloat = 100
        let center = CGPoint(x: 100, y: 70)
        let radius: CGFloat = 200
        let startAngle = CGFloat(0)
        let endAngle = CGFloat.pi / 2
        let rotateCells = true
        let cellSize = CGSize(width: itemRadius, height: itemRadius)
        let direction = ACBRadialCollectionViewScrollDirection.clockwise
        yourCategoriesCollectionView.enableRadialLayout(WithCenter: center, radius: radius, cellSize: cellSize, angularSpacing: 20.0, scrollDirection: direction, startAngle: startAngle, endAngle: endAngle)
        yourCategoriesCollectionView.applyRotationToCells = rotateCells
    }
    
}
