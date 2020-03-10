//
//  testBar.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 09/03/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit
import ACBRadialCollectionView
class testBar: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, BtnActionInMainView {
    func hardestWordsAction() {
        print("elo")
    }
    
    
    @IBOutlet weak var collection: UICollectionView!
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seba", for: indexPath) as! TestCollectionViewCell
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let pushVC = mainStoryboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
//        self.navigationController?.pushViewController(pushVC, animated: true)
//    }
    
    private func setCategoriesCollectionView() {
        //        collection.backgroundColor = .clear
        let itemRadius: CGFloat = 100
        let center = CGPoint(x: 100, y: 70)
        let radius: CGFloat = 200
        let startAngle = CGFloat(0)
        let endAngle = CGFloat.pi / 2
        let rotateCells = true
        let cellSize = CGSize(width: itemRadius, height: itemRadius)
        let direction = ACBRadialCollectionViewScrollDirection.clockwise
        collection.enableRadialLayout(WithCenter: center, radius: radius, cellSize: cellSize, angularSpacing: 20.0, scrollDirection: direction, startAngle: startAngle, endAngle: endAngle)
        collection.applyRotationToCells = rotateCells
    }
    
    var dataToCircleCollection = [CircleCollectionDataStruct]()
    
    @IBOutlet var setView: MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.delegate = self
        setView.setNavigationController(self.navigationController!)
        let nibCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        setView.categoriesCollectionView.register(nibCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        takeDataToCircleCollection()
    }
    
    private func takeDataToCircleCollection(){
        let data = CircleCollectionData()
        data.takeData { (dataToCircleCollection) in
            self.dataToCircleCollection = dataToCircleCollection
            self.setView.categoriesCollectionView.reloadData()
        }
    }
    //
    //  CategoriesCollectionView.swift
    //  MyFlashCards
    //
    //  Created by Pawel Krzywik on 17/02/2020.
    //  Copyright © 2020 Pawel Krzywik. All rights reserved.
    //
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return dataToCircleCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.configurateCell(dataToCircleCollection[indexPath.row].name, dataToCircleCollection[indexPath.row].img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        pushVC.categoryName = dataToCircleCollection[indexPath.row].name
        pushVC.categoryType = "System"
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


