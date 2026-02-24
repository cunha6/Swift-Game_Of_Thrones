import Foundation

struct Character: Codable {
    let id: Int
    let firstName, lastName, fullName, title: String
    let family, image: String
    let imageURL: String
    let rate: Int?
    
    
     
    enum CodingKeys: String, CodingKey{
        case id, firstName, lastName, fullName, title, family, image, rate
        case imageURL = "imageUrl"
    }
}

typealias Characters = [Character]
	
