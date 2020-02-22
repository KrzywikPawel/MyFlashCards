//
//  TakeCategories.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 21/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import FirebaseFirestore
struct WordStruct: Equatable {
    let ang: String
    let pol: String
    
    init(_ snapshot: QueryDocumentSnapshot) {
        ang = snapshot["ang"] as! String
        pol = snapshot["pol"] as! String
    }
    
    static func == (left: WordStruct, right: WordStruct) -> Bool {
        return left.ang == right.ang && left.pol == right.pol
    }
}
