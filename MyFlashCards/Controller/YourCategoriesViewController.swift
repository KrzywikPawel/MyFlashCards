//
//  YourCategoriesViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class YourCategoriesViewController: UIViewController, BtnActionInYourCategories {
    
    var yourCategoriesNames = [String]()
    let emptyCollectionMessage = "Your Categories are empty, \nadd category and back here"
    @IBOutlet var setView: YourCategoriesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView.delegate = self
        let nibCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        setView.yourCategoriesCollectionView.register(nibCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        takeCategoriesNames()
        setView.yourCategoriesCollectionView.reloadData()
    }
    
    private func takeCategoriesNames(){
        let parser = OperationInMemory()
        yourCategoriesNames = parser.loadNamesArray()
        
    }
    
    func addNewCategoryBtn() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
}
