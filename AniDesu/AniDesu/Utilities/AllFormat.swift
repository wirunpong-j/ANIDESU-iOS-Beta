//
//  AllFormat.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 1/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class AllFormat {
    static let instance = AllFormat()
    
    func getURL(stringURL: String) -> URL {
        return URL(string: stringURL)!
    }
}
