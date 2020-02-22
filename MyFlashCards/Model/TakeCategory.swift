//
//  TakeCategories.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 21/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import FirebaseFirestore

class TakeCategory {
    var words = [WordStruct]()
    
    func parseData(_ name:String, completion:@escaping([WordStruct]) -> ()) {
        let database = Firestore.firestore()
        _ = database.collection(name).getDocuments { (snapshot, error) in
            if let err = error {
                print("error getting document from database: \(err)")
            } else {
                for single in snapshot!.documents{
                    let word = WordStruct(single)
                    self.words.append(word)
                }
                completion(self.words)
            }
        }
    }
}
