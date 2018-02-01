//
//  Review.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 31/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

struct Review {
    public private(set) var rating: Double
    public private(set) var reviewDate: String
    public private(set) var text: String
    public private(set) var anime: Anime
    public private(set) var user: User

}
