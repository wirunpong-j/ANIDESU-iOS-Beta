//
//  PostService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class PostService {
    static let instance = PostService()
    var posts = [Post]()
    
    func findAllPost(completion: @escaping CompletionHandler) {
        var post1 = Post(postID: "1", uid: "test01", status: "Hello, World", postDate: "30 Nov 2018 - 22:33", likeCount: 290)
        var post2 = Post(postID: "1", uid: "test02", status: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", postDate: "1 Dec 2018 - 01:01", likeCount: 909)
        
        self.posts.append(post1)
        self.posts.append(post2)
    }
}
