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
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        return newItem
    }
    
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let archivedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item]
            allItems = archivedItems!
        } catch {
            print ("error unarchiving \(error)") // not a problem if the first time the app runs
        }
    }
    
    func saveChanges() -> Bool {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            print("saved items to \(itemArchiveURL)")
            return true
        } catch {
            return false
        }
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
