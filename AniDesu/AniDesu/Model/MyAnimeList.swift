import Foundation

struct MyAnimeList {
    public private(set) var animeID: Int
    public private(set) var score: Int
    public private(set) var progress: Int
    public private(set) var note: String
    public private(set) var status: String
    var anime: Anime?
    var isAdded: Bool?
    var key: String?
    
    init(animeID: Int, score: Int, progress: Int, note: String, status: String) {
        self.animeID = animeID
        self.score = score
        self.progress = progress
        self.note = note
        self.status = status
    }
    
}
