//
//  YourCategoriesViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class YourCategoriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
    }
    
    private func setBackground(){
        let backgroundImg = UIImage(named: "yourCategoriesBackground")
        let backgroundView = UIImageView.init(frame: view.frame)
        backgroundView.image = backgroundImg
        backgroundView.contentMode = .scaleAspectFit
        view.insertSubview(backgroundView, at: 0)
        
    }
}
