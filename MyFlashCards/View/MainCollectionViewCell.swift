//
//  MainCollectionViewCell.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    func configurateCell(_ categoryName: String,_ categoryImg: UIImage){
        categoryImage.image = categoryImg
        categoryNameLbl.text = categoryName
    }
}
