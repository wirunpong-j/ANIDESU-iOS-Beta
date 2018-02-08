import Foundation
import Firebase
import Alamofire

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var uid = ""
    public private(set) var displayName = ""
    public private(set) var email = ""
    public private(set) var about = ""
    public private(set) var imageUrlProfile = ""
    
    func setUserData(uid: String, displayName: String, email: String, about: String, imageUrlProfile: String) {
        self.uid = uid
        self.displayName = displayName
        self.email = email
        self.about = about
        self.imageUrlProfile = imageUrlProfile
    }
    
    func fetchMyAnimeList(completion: @escaping ([MyAnimeList]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("users").child(uid).child("list_anime").observeSingleEvent(of: .value, with: { (snapshot) in
            // get my anime list
            let allValue = snapshot.value as? [String: Any]
            
            var allMyAnimeList = [MyAnimeList]()
            if allValue != nil {
                for key in (allValue?.keys)! {
                    let myAnimeList = allValue![key] as? [String: Any]
                    let animeID = myAnimeList!["anime_id"] as? Int ?? 0
                    let progress = myAnimeList!["progress"] as? Int ?? 0
                    let score = myAnimeList!["score"] as? Int ?? 0
                    let note = myAnimeList!["note"] as? String ?? ""
                    let status = myAnimeList!["status"] as? String ?? ""
                    
                    AniListService.instance.fetchAnimePage(animeID: animeID) { (anime) in
                        var myAnimeList = MyAnimeList(animeID: animeID, score: score, progress: progress, note: note, status: status)
                        myAnimeList.anime = anime
                        myAnimeList.isAdded = true
                        myAnimeList.key = key
                        allMyAnimeList.append(myAnimeList)
                        
                        if allMyAnimeList.count >= allValue!.count {
                            completion(allMyAnimeList)
                            return
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
            print("Not Show Data")
            
            completion(nil)
        }
        
    }
    
    func addMyAnimeList(myAnimeList: MyAnimeList, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let myAnime: [String: Any] = [
            "anime_id": myAnimeList.animeID,
            "note": myAnimeList.note,
            "progress": myAnimeList.progress,
            "score": myAnimeList.score,
            "status": myAnimeList.status
        ]
        ref.child("ios").child("users").child(uid).child("list_anime").childByAutoId().setValue(myAnime)
        
        completion(true)
    }
    
    func updateMyAnimeList(myAnimeList: MyAnimeList, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        let myAnime: [String: Any] = [
            "anime_id": myAnimeList.animeID,
            "note": myAnimeList.note,
            "progress": myAnimeList.progress,
            "score": myAnimeList.score,
            "status": myAnimeList.status
        ]
        ref.child("ios").child("users").child(uid).child("list_anime").child(myAnimeList.key!).updateChildValues(myAnime)
        
        completion(true)
    }
    
    func removeAnimeFormMyList(myAnimeList: MyAnimeList, completion: @escaping CompletionHandler) {
        let ref = Database.database().reference()
        ref.child("ios").child("users").child(uid).child("list_anime").child(myAnimeList.key!).removeValue() { (error, _) in
            print(error)
            completion(false)
        }
        completion(true)
    }
    
    func isAnimeInMyList(anime: Anime, completion: @escaping (MyAnimeList?) -> ()) {
        let ref = Database.database().reference()
        ref.child("ios").child("users").child(uid).child("list_anime").observeSingleEvent(of: .value, with: { (snapshot) in
            // get my anime list
            let allValue = snapshot.value as? [String: Any]
            if allValue != nil {
                for key in (allValue?.keys)! {
                    let myAnimeList = allValue![key] as? [String: Any]
                    let id = myAnimeList!["anime_id"] as? Int ?? 0
                    
                    if anime.id == id {
                        let progress = myAnimeList!["progress"] as? Int ?? 0
                        let score = myAnimeList!["score"] as? Int ?? 0
                        let note = myAnimeList!["note"] as? String ?? ""
                        let status = myAnimeList!["status"] as? String ?? ""
                        
                        var currentMyAnimeList = MyAnimeList(animeID: id, score: score, progress: progress, note: note, status: status)
                        currentMyAnimeList.anime = anime
                        currentMyAnimeList.isAdded = true
                        currentMyAnimeList.key = key
                        
                        completion(currentMyAnimeList)
                        return
                    }
                }
            }
            
            var myAnimeList = MyAnimeList(animeID: anime.id, score: 0, progress: 0, note: "", status: StatusType.PLAN_TO_WATCH.rawValue)
            myAnimeList.anime = anime
            myAnimeList.isAdded = false
            
            completion(myAnimeList)
        }) { (error) in
            print(error.localizedDescription)
            print("isAnimeInMyList ERROR!")
            
            completion(nil)
        }
    }
    
    func logoutUser() {
        uid = ""
        displayName = ""
        email = ""
        about = ""
        imageUrlProfile = ""
        
        AuthService.instance.uid = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.anilistToken = ""
    }
    
}
