//
//  CreateBarBackBtn.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 27/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit


class CreateBarBackBtn{
    
     func setBarBackBtn() -> UIButton{
        let backBtn = UIButton(type: .custom)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        let sign = UIImage(named: "flashCard")
        backBtn.setBackgroundImage(sign, for: .normal)
        backBtn.setTitle("Back", for: .normal)
        backBtn.setTitleColor(.black, for: .normal)
        backBtn.contentMode = .scaleAspectFit
        return backBtn
    }
}
