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
            for item in (allValue?.keys)! {
                print(item)
            }
            
//            var allReview = [Review]()
//            for allItem in (value?.allValues)! {
//                let item = (allItem as? NSDictionary)
//
//                for review in (item?.allValues)! {
//                    let reviewKey = review as? NSDictionary
//
//                    for key in (reviewKey?.allKeys)! {
//                        let userID = key as? String ?? ""
//                        let reviewInfo = reviewKey![userID] as? NSDictionary
//                        let animeId = reviewInfo!["anime_id"] as? String ?? ""
//                        let rating = reviewInfo!["rating"] as? Double ?? 0
//                        let reviewDate = reviewInfo!["review_date"] as? String ?? "-"
//                        let text = reviewInfo!["text"] as? String ?? "-"
//
//                        PostService.instance.fetchUserInfo(uid: userID) { (user) in
//                            if user != nil {
//                                AniListService.instance.fetchAnimePage(animeID: Int(animeId)!) { (anime) in
//                                    if anime != nil {
//                                        var review = Review(rating: rating, reviewDate: reviewDate, text: text, anime: anime!)
//                                        review.user = user
//
//                                        allReview.append(review)
//                                        if allReview.count >= (reviewKey?.count)! {
//                                            completion(allReview)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
        }) { (error) in
            print(error.localizedDescription)
            print("fetchReview ERROR")
            
            completion(nil)
        }
    }
    
    func fetchThisReview(animeID: Int, completion: @escaping (Review?) -> ()) {
        
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
}
