import Foundation
import Firebase

class PostService {
    static let instance = PostService()
    
    func fetchAllPost(completion: @escaping ([Post]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("posts").queryOrdered(byChild: "post_date").observeSingleEvent(of: .value, with: { (snapshot) in
            // get all post
            let allValue = snapshot.value as? [String: Any]
            
            var posts = [Post]()
            if allValue != nil {
                for key in (allValue?.keys)! {
                    let postInfo = allValue![key] as? [String: Any]
                    let uid = postInfo!["uid"] as? String ?? ""
                    let status = postInfo!["status"] as? String ?? ""
                    let postDate = postInfo!["post_date"] as? String ?? ""
                    let likeCount = postInfo!["like_count"] as? Int ?? 0
                    
                    self.fetchUserInfo(uid: uid) { (user) in
                        var post = Post(uid: uid, status: status, postDate: postDate, likeCount: likeCount)
                        post.postKey = key
                        post.user = user
                        
                        posts.append(post)
                        if posts.count >= (allValue?.count)! {
                            completion(posts)
                        }
                    }
                }
                
            } else {
                completion(posts)
            }
            
        }) { (error) in
            print(error.localizedDescription)
            print("fetchPost ERROR")
            
            completion(nil)
        }
    }
    
    func postStatus(post: Post, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let postInfo: [String: Any] = [
            "uid": post.uid,
            "status": post.status,
            "post_date": post.postDate,
            "like_count": post.likeCount
        ]
        ref.child("ios").child("posts").childByAutoId().setValue(postInfo)
        
        completion(true)
    }
    
    func fetchUserInfo(uid: String, completion: @escaping (User?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("users").child(uid).child("profile").observeSingleEvent(of: .value, with: { (snapshot) in
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
