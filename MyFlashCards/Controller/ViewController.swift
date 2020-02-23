//
//  ViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataToCircleCollection = [CircleCollectionDataStruct]()
    
    @IBOutlet var setView: MainView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.setNavigationController(self.navigationController!)
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
