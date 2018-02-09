//
//  Post.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

struct Post {
    public private(set) var uid: String
    public private(set) var status: String
    public private(set) var postDate: String
    public private(set) var likeCount: Int
    
    var user: User?
    var postKey: String?
    
    init(uid: String, status: String, postDate: String, likeCount: Int) {
        self.uid = uid
        self.status = status
        self.postDate = postDate
        self.likeCount = likeCount
    }
}
