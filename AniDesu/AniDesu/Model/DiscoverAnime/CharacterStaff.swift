import Foundation
import SwiftyJSON

struct CharacterStaff {
    public private(set) var id: Int
    public private(set) var firstName: String
    public private(set) var lastName: String
    public private(set) var image_url_lge: String
    public private(set) var image_url_med: String
    public private(set) var role: String
    
    init(charJSON: JSON) {
        self.id = charJSON["id"].intValue
        self.firstName = charJSON["name_first"].stringValue != "" ? charJSON["name_first"].stringValue : ""
        self.lastName = charJSON["name_last"].stringValue != "" ? charJSON["name_last"].stringValue : ""
        self.role = charJSON["role"].stringValue
        self.image_url_lge = charJSON["image_url_lge"].stringValue
        self.image_url_med = charJSON["image_url_med"].stringValue
    }
    
    func getFullName() -> String {
        if firstName != "" && lastName != "" {
            return "\(firstName) \(lastName)"
        }
        
        return "N/A"
    }

}
