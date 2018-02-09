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
    
    func getCurrentTime() -> String {
        // 2017-11-30-06-45
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return String(format: "\(year)-%02d-%02d-%02d-%02d", month, day, hour, minutes)
    }
}
