//
//  YourCategoriesViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class YourCategoriesViewController: UIViewController {
    
    @IBOutlet var setView: YourCategoriesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        setView.yourCategoriesCollectionView.register(nibCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
    }
    
  
    
}
