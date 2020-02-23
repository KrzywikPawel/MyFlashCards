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
        return dataToCircleCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
//      MARK:  refactor to categoriescollectionviewcell
        cell.configurateCell(dataToCircleCollection[indexPath.row].name, dataToCircleCollection[indexPath.row].img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(identifier: "FlashCardViewController") as! FlashCardViewController
        pushVC.name = dataToCircleCollection[indexPath.row].name
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
}
