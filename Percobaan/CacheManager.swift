//
//  CacheManager.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 27/08/22.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data){
        
        // Save the image data along with the URL
        imageDictionary[url] = imageData
        
    }
    
    static func retrievedData(_ url:String) -> Data?{
        
        // Return the saved image data or nil
        return imageDictionary[url]
        
    }
    
}
