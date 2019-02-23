//
//  ItemStore.swift
//  Homepwner
//
//  Created by Cara on 2/22/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        return newItem
    }
}
