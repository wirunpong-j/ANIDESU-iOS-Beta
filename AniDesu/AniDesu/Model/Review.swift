//
//  Review.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 31/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

struct Review {
    public private(set) var message: String
}

extension Review {
    static var testData: [Review] {
        return [
            Review(message: "Danganronpa V3"),
            Review(message: "Date A Live 2"),
            Review(message: "Monokumaaaaaa")
        ]
    }
}
