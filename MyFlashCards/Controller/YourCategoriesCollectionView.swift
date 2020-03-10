//
//  YourCategoriesCollectionView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit

extension YourCategoriesViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if yourCategoriesNames.count == 0 {
            let setEmptyMessage = SetEmptyCollectionViewMessage()
            setEmptyMessage.collectionViewEmptyMessage(collectionView, emptyCollectionMessage)
        } else {
            collectionView.restore()
        }
        return yourCategoriesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let img = UIImage(named: "hospital")
        let categoryName = yourCategoriesNames[indexPath.row]
        cell.configurateCell(categoryName, img!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        pushVC.categoryName = yourCategoriesNames[indexPath.row]
        pushVC.categoryType = "YourCategory"
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    
    
}
