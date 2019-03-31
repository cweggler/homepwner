//
//  ImageStore.swift
//  Homepwner
//
//  Created by Cara on 3/31/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class ImageStore {
    
    // helps with the caching of the image's memory
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
