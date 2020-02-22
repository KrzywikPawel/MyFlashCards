//
//  TakeCategoriesNames.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 22/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import FirebaseFirestore

class TakeCategoriesNames{
    var names = [String]()
    
    func takeData(completion:@escaping([String]) -> ()){
        let database = Firestore.firestore()
        _ = database.collection("CategoriesName").getDocuments { (document, error) in
            if let err = error{
                print("error in TakeCategoriesNames \(err)")
            } else {
                for singleName in document!.documents {
                    let name = singleName["name"] as! String
                    self.names.append(name)
                }
                completion(self.names)
            }
        }
    }
}
