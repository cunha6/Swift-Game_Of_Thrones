

import Foundation
class GOTService {
    
    static let API_URL = "https://game-of-thrones1.p.rapidapi.com"
    static let API_KEY = "cd0340e0a4msha3f7aaf2528600ep171ba8jsnff89d7bb2e04"
    
    static func fetch(completionHandler: @escaping (Result<Characters, Error>) -> Void){
        
        let urlString = API_URL + "/Characters"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NSError(domain: "GOTService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(API_KEY, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "GOTService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do{
                let characters =  try JSONDecoder().decode(Characters.self, from: data)
                completionHandler(.success(characters))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}

