//
//  Item.swift
//  Homepwner
//
//  Created by Cara on 2/20/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Int){
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super .init()
    }
    
    convenience init(random: Bool = false) {
        if random {
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork", "Mac"]
        
        var idx = Int.random(in: 0..<adjectives.count)
        let randomAdjective = adjectives[Int(idx)]
        
        idx = Int.random(in: 0..<nouns.count)
        let randomNoun = nouns[Int(idx)]
        
        let randomName = "\(randomAdjective) \(randomNoun)"
        let randomValue = Int.random(in: 0..<100)
        let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
        
        self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        
        super.init()
    }
    
}
