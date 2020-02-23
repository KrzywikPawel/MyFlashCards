//
//  AddCategoryViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    @IBOutlet var setView: AddCategoryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView.setNavigationController(self.navigationController!)
    }

}
