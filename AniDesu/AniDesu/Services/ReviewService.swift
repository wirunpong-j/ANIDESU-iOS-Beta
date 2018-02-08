import Foundation
import Alamofire
import SwiftyJSON
import Firebase

class ReviewService {
    static let instance = ReviewService()
    
    func fetchAllReview(completion: @escaping ([Review]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("series").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            var allReview = [Review]()
            for allItem in (value?.allValues)! {
                let item = (allItem as? NSDictionary)
                
                for review in (item?.allValues)! {
                    let reviewKey = review as? NSDictionary
                    
                    for key in (reviewKey?.allKeys)! {
                        let userID = key as? String ?? ""
                        let reviewInfo = reviewKey![userID] as? NSDictionary
                        let animeId = reviewInfo!["anime_id"] as? String ?? ""
                        let rating = reviewInfo!["rating"] as? Double ?? 0
                        let reviewDate = reviewInfo!["review_date"] as? String ?? "-"
                        let text = reviewInfo!["text"] as? String ?? "-"
                        
                        PostService.instance.fetchUserInfo(uid: userID) { (user) in
                            if user != nil {
                                AniListService.instance.fetchAnimePage(animeID: Int(animeId)!) { (anime) in
                                    if anime != nil {
                                        let review = Review(rating: rating, reviewDate: reviewDate, text: text, anime: anime!, user: user!)
                                        
                                        allReview.append(review)
                                        if allReview.count >= (reviewKey?.count)! {
                                            completion(allReview)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
            print("fetchReview ERROR")
            
            completion(nil)
        }
    }
}
