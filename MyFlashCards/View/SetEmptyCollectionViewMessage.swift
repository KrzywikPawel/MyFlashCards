//
//  SetEmptyCollectionViewMessage.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 27/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class SetEmptyCollectionViewMessage {
    func collectionViewEmptyMessage(_ collectionView: UICollectionView, _ message: String){
        collectionView.setEmptyMessage(message)
    }
}
