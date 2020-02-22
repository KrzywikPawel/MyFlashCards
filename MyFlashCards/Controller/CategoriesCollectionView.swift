//
//  CategoriesCollectionView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit
extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
//      MARK:  refactor to categoriescollectionviewcell
        cell.categoryImage.image = UIImage(named: "hospital")
        cell.categoryNameLbl.text = namesArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped on \(indexPath)")
    }
}
