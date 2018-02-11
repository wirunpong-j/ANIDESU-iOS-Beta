import Foundation
import Alamofire
import SwiftyJSON
import Firebase

class ReviewService {
    static let instance = ReviewService()
    
    func fetchAllReview(completion: @escaping ([Review]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("series").observeSingleEvent(of: .value, with: { (snapshot) in
            let allValue = snapshot.value as? [String: Any]
            
            var allReview = [Review]()
            if allValue != nil {
                self.fetchCountReview { count in
                    for anime in allValue! {
                        let animeID = anime.key
                        let animeValue = anime.value as? [String: Any]
                        let allUserReview = animeValue!["review"] as? [String: Any]
                        
                        for userReview in allUserReview! {
                            let uid = userReview.key
                            let reviewInfo = userReview.value as? [String: Any]
                            let rating = reviewInfo!["rating"] as? Double ?? 0.0
                            let reviewDate = reviewInfo!["review_date"] as? String ?? ""
                            let text = reviewInfo!["text"] as? String ?? ""
                            
                            PostService.instance.fetchUserInfo(uid: uid) { (user) in
                                if user != nil {
                                    AniListService.instance.fetchAnimePage(animeID: Int(animeID)!) { (anime) in
                                        if anime != nil {
                                            var review = Review(rating: rating, reviewDate: reviewDate, text: text, anime: anime!)
                                            review.user = user
                                            
                                            allReview.append(review)
                                            if allReview.count >= count! {
                                                allReview = allReview.sorted(by: { $0.reviewDate > $1.reviewDate })
                                                completion(allReview)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                completion([Review]())
            }
        }) { (error) in
            print(error.localizedDescription)
            print("fetchReview ERROR")
            
            completion(nil)
        }
    }
    
    func fetchThisReview(anime: Anime, completion: @escaping (Review?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("series").child("\(anime.id)").child("review").child(UserDataService.instance.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let allValue = snapshot.value as? [String: Any]
            
            if allValue != nil {
                let rating = allValue!["rating"] as? Double ?? 0.0
                let reviewDate = allValue!["review_date"] as? String ?? ""
                let text = allValue!["text"] as? String ?? ""
                var currentReview = Review(rating: rating, reviewDate: reviewDate, text: text, anime: anime)
                currentReview.isReview = true
                
                completion(currentReview)
            } else {
                var newReview = Review(rating: 0.0, reviewDate: "", text: "", anime: anime)
                newReview.isReview = false
                
                completion(newReview)
            }
        }) { (error) in
            print(error.localizedDescription)
            print("fetchReview ERROR")
            
            completion(nil)
        }
    }
    
    func fetchCountReview(completion: @escaping (Int?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("series").observeSingleEvent(of: .value, with: { (snapshot) in
            let allValue = snapshot.value as? [String: Any]
            
            var count = 0
            if allValue != nil {
                for anime in allValue! {
                    let animeValue = anime.value as? [String: Any]
                    let allUserReview = animeValue!["review"] as? [String: Any]
                    count += (allUserReview?.count)!
                }
                
                completion(count)
            } else {
                completion(0)
            }
        }) { (error) in
            print(error.localizedDescription)
            print("fetchReview ERROR")
            
            completion(0)
        }
    }
    
    func saveReview(review: Review, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let reviewInfo: [String: Any] = [
            "rating": review.rating,
            "review_date": review.reviewDate,
            "text": review.text
        ]
        ref.child("ios").child("series").child("\(review.anime.id)").child("review").child(UserDataService.instance.uid).setValue(reviewInfo)
        
        completion(true)
    }
    
    func updateReview(review: Review, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let reviewInfo: [String: Any] = [
            "rating": review.rating,
            "review_date": review.reviewDate,
            "text": review.text
        ]
        ref.child("ios").child("series").child("\(review.anime.id)").child("review").child(UserDataService.instance.uid).updateChildValues(reviewInfo)
        
        completion(true)
    }
    
    func removeReview(animeID: Int, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        ref.child("ios").child("series").child("\(animeID)").child("review").child(UserDataService.instance.uid).removeValue() { (error, _) in
            print(error)
            completion(false)
        }
        completion(true)
    }
}
