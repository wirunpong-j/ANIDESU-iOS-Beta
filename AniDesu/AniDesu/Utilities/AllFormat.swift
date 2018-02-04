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
    
    func getDateTime(date: Int?) -> String {
        var newDate = "N/A"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if date != 0 {
            let formateDate = dateFormatter.date(from: "\(date!)")
            dateFormatter.dateFormat = "dd MMM yyyy"
            newDate = dateFormatter.string(from: formateDate!)
        }
        
        return newDate
    }
}
