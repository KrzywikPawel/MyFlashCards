//
//  YourCategoriesViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class YourCategoriesViewController: UIViewController {
    var yourCategoriesNames = [String]()
    @IBOutlet var setView: YourCategoriesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        takeCategoriesNames()
        let nibCell = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        setView.yourCategoriesCollectionView.register(nibCell, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        setView.addNewCategoryBtn.addTarget(self, action: #selector(addCategory(_:)), for: .touchUpInside)
        
    }
    
    private func takeCategoriesNames(){
        let parser = OperationInMemory()
        yourCategoriesNames = parser.loadNamesArray()
    }
    
    
    @objc private func addCategory(_ sender:UIButton){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pushVC = mainStoryboard.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
}
