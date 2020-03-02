//
//  ViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, BtnActionInMainView {
    
    var dataToCircleCollection = [CircleCollectionDataStruct]()
    
    @IBOutlet var setView: MainView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.delegate = self
        setView.setNavigationController(self.navigationController!)
        let nibCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        setView.categoriesCollectionView.register(nibCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        takeData()
    }
    
    private func takeData(){
        let data = CircleCollectionData()
        data.takeData { (dataToCircleCollection) in
            self.dataToCircleCollection = dataToCircleCollection
            self.setView.categoriesCollectionView.reloadData()
        }
    }
    
    func hardestWordsAction() {
        let mainStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(identifier: "CategoryViewController") as CategoryViewController
        pushVC.categoryType = "HardWords"
        self.navigationController?.pushViewController(pushVC, animated: true)
     }
}
