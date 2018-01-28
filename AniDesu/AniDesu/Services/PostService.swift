//
//  PostService.swift
//  AniDesu
//
//  Created by Wirunpong Jaingamlertwong on 25/1/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Firebase

class PostService {
    static let instance = PostService()
    
    func fetchAllPost(completion: @escaping ([Post]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild: "post_date").observeSingleEvent(of: .value, with: { (snapshot) in
            // get all post
            let value = snapshot.value as? NSDictionary
            
            var allPost = [Post]()
            if let allValues = value?.allValues {
                for item in allValues {
                    let postInfo = item as? NSDictionary
                    let likeCount = postInfo!["like_count"] as? Int ?? 0
                    let postDate = postInfo!["post_date"] as? String ?? ""
                    let postKey = postInfo!["post_key"] as? String ?? ""
                    let status = postInfo!["status"] as? String ?? ""
                    let uid = postInfo!["uid"] as? String ?? ""
                    
                    self.fetchUserInfo(uid: uid) { (user) in
                        let post = Post(postID: postKey, uid: uid, status: status, postDate: postDate, likeCount: likeCount, user: user!)
                        allPost.append(post)
                        
                        if allPost.count >= value!.allValues.count {
                            completion(allPost)
                        }
                    }
                }
            }
            completion(nil)
            
        }) { (error) in
            print(error.localizedDescription)
            print("fetchPost ERROR")
            
            completion(nil)
        }
    }
    
    func fetchUserInfo(uid: String, completion: @escaping (User?) -> ()) {
        let ref = Database.database().reference()
        ref.child("users").child(uid).child("profile").observeSingleEvent(of: .value, with: { (snapshot) in
            // get user data
            let value = snapshot.value as? NSDictionary
            
            if value?.allValues != nil {
                let about = value?["about"] as? String ?? ""
                let displayName = value?["display_name"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let imageURL = value?["image_url_profile"] as? String ?? ""
                let user = User(uid: uid, displayName: displayName, email: email, about: about, imageUrlProfile: imageURL)
                
                completion(user)
                
            } else {
                completion(nil)
            }
            
        }) { (error) in
            print(error.localizedDescription)
            print("Not Show Data")
            
            completion(nil)
        }
    }
}
