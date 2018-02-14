import Foundation

struct Review {
    public private(set) var rating: Double
    public private(set) var reviewDate: String
    public private(set) var text: String
    public private(set) var anime: Anime

    var user: User?
    var isReview: Bool?
    
    init(rating: Double, reviewDate: String, text: String, anime: Anime) {
        self.rating = rating
        self.reviewDate = reviewDate
        self.text = text
        self.anime = anime
    }

}
