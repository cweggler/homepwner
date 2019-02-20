//
//  Item.swift
//  Homepwner
//
//  Created by Cara on 2/20/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    
    init(name: String, serialNumber: String?, valueInDollars: Int){
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollars = valueInDollars
        self.dateCreated = Date()
        
        super .init()
    }
}
