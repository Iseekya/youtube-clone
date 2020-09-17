//
//  CacheManager.swift
//  youtube-clone
//
//  Created by Stefan Hitrov on 17.09.20.
//  Copyright © 2020 Stefan Hitrov. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url:String, _ data:Data?) {
        
        // Store the iamge data and use the url as the key
        cache[url] = data
        
    }
    
    static func getVideoCache(_ url:String) -> Data? {
        
        // Try to get the data for the specified url
        return cache[url]
        
    }
    
}
