//
//  CircleCollectionDataStruct.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 22/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
class CircleCollectionDataStruct{
    let name: String
    let img: UIImage
    
    init(_ nameFromDatabase: String, _ imageFromDatabase: UIImage) {
        name = nameFromDatabase
        img = imageFromDatabase
    }
}
