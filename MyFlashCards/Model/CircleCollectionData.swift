//
//  TakeCategoriesNames.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 22/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
class CircleCollectionData{
    var dataToCircleCollection = [CircleCollectionDataStruct]()
    
    func takeData(completion:@escaping([CircleCollectionDataStruct]) -> ()) {
        let database = Firestore.firestore()
        _ = database.collection("CategoriesName").getDocuments { (document, error) in
            if let err = error {
                print("error in TakeCategoriesNames \(err)")
            } else {
                for singleName in document!.documents {
                    let name = singleName["name"] as! String
                    _ = self.takeCategoryImg(name) { (snapshot) in
                        let createDataStruct = CircleCollectionDataStruct(name, snapshot)
                        self.dataToCircleCollection.append(createDataStruct)
                        completion(self.dataToCircleCollection)
                    }
                }
            }
        }
    }
    
    private func takeCategoryImg(_ name: String, completion:@escaping (UIImage) -> ()) {
        let storage = Storage.storage().reference(withPath: "CategoriesImg/\(name).png")
        var img = UIImage()
        storage.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print("error in takeIMG in takeDataToMainView")
            } else {
                img = UIImage(data: data!)!
            }
            completion(img)
        }
    }
}
