//
//  Airing.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 4/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Airing {
    public private(set) var time: String
    public private(set) var countdown: Int
    public private(set) var nextEP: Int
    
    init(airingJSON: JSON) {
        self.time = airingJSON["time"].stringValue
        self.countdown = airingJSON["countdown"].intValue
        self.nextEP = airingJSON["next_episode"].intValue
    }
    
    func getNextEPandTime() -> String {
        return nextEP != 0 ? "EP \(nextEP) Airing in \(countdown / 3600)h" : "N/A"
    }
}
