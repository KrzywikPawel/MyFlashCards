//
//  ViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var dataToCircleCollection = [CircleCollectionDataStruct]()
    
    @IBOutlet var setView: MainView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
