//
//  AddCategoryView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit

class AddCategoryView: UIView{
    @IBOutlet weak var categoryNameField: UITextField!
    @IBOutlet weak var angWordField: UITextField!
    @IBOutlet weak var polWordField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBackground()
    }
    
    func takeAngTextField() -> String{
        return angWordField.text!
    }
    
    func takePolTextField() -> String{
        return polWordField.text!
    }
    
    func takeCategoryNameTextField() -> String{
        return categoryNameField.text!
    }
    
    private func setBackground(){
        let backgroundImg = UIImage(named: "addCategoryBackground")
        let backgroundView = UIImageView.init(frame: self.frame)
        backgroundView.image = backgroundImg
        backgroundView.contentMode = .scaleAspectFit
        self.insertSubview(backgroundView, at: 0)
    }
    
    func setNavigationController(_ navigationController: UINavigationController){
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
}
