import Foundation

struct Comment {
    public private(set) var commentDate: String
    public private(set) var commentStatus: String
    public private(set) var uid: String
    
    var user: User?
    var commentKey: String?
    
    init(uid: String, commentStatus: String, commentDate: String) {
        self.uid = uid
        self.commentStatus = commentStatus
        self.commentDate = commentDate
    }
}
