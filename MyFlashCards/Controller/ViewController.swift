//
//  ViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 17/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var namesArray = [String]()
    @IBOutlet var setView: MainView!
    override func viewDidLoad() {
        super.viewDidLoad()
        takeData()
    }
    
    private func takeData(){
        let data = TakeCategoriesNames()
        data.takeData { (names) in
            self.namesArray = names
            self.setView.categoriesCollectionView.reloadData()
        }
    }
}

