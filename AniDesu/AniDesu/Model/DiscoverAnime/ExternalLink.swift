//
//  ExternalLink.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 4/2/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ExternalLink {
    public private(set) var id: Int
    public private(set) var url: String
    public private(set) var site: String
    
    init(exLink: JSON) {
        self.id = exLink["id"].intValue
        self.url = exLink["url"].stringValue
        self.site = exLink["site"].stringValue
    }
}
