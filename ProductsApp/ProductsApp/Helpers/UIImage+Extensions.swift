//
//  UIImage+Extensions.swift
//  ProductsApp
//
//  Created by Jefin on 22/05/22.
//

import UIKit

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }
    
}
