//
//  MainView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit
import ACBRadialCollectionView
class MainView: UIView{
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var yourCategoryBtn: UIButton!
    @IBOutlet weak var lastCategoryImage: UIImageView!
    fileprivate var datasourceArray: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackground()
        setCategoriesCollectionView()
        lastCategoryImage.image = UIImage(named: "hospital")
        for i in 1...10 {
            datasourceArray.append(String(i))
        }
    }
    
    
    private func setBackground() {
        let backgroundImg = UIImage(named: "MainViewBackground")
        let backgroundImageView = UIImageView.init(frame: self.frame)
        backgroundImageView.image = backgroundImg
        backgroundImageView.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImageView, at: 0)
    }
    
    private func setCategoriesCollectionView() {
        categoriesCollectionView.backgroundColor = .clear
        let itemRadius: CGFloat = 100
        let center = CGPoint(x: 100, y: 80)
        let radius: CGFloat = 200
        let startAngle = CGFloat(0)
        let endAngle = CGFloat.pi / 2
        let rotateCells = true
        let cellSize = CGSize(width: itemRadius, height: itemRadius)
        let direction = ACBRadialCollectionViewScrollDirection.clockwise
        categoriesCollectionView.enableRadialLayout(WithCenter: center, radius: radius, cellSize: cellSize, angularSpacing: 20.0, scrollDirection: direction, startAngle: startAngle, endAngle: endAngle)
        categoriesCollectionView.applyRotationToCells = rotateCells
    }
}

