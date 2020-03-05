//
//  AddCategoryView.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 23/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit

protocol AddCategoryBtnAction: class {
    func addWordToCategory()
    func backToYourCategoriesScreen()
}


class AddCategoryView: UIView{
    @IBOutlet weak var categoryNameField: UITextField!
    @IBOutlet weak var angWordField: UITextField!
    @IBOutlet weak var polWordField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    weak var delegate: AddCategoryBtnAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func addBtn(_ sender: UIButton) {
        delegate?.addWordToCategory()
    }
    
    func takeAngTextField() -> String {
        return angWordField.text!
    }
    
    func takePolTextField() -> String {
        return polWordField.text!
    }
    
    func takeCategoryNameTextField() -> String {
        return categoryNameField.text!
    }
    
    func clearWordsTextFields() {
        angWordField.text = ""
        polWordField.text = ""
    }
    
    func setNavigationController(_ navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func createBackBtnItem(_ navigationItem:UINavigationItem) {
        let createBackBtn = CreateBarBackBtn()
        let backBtn = createBackBtn.setBarBackBtn()
        backBtn.addTarget(self, action: #selector(backToYourCategoriesScreen(_:)), for: .touchUpInside)
        let leftBarItem = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc func backToYourCategoriesScreen(_ sender:UIButton) {
        delegate?.backToYourCategoriesScreen()
    }
}
