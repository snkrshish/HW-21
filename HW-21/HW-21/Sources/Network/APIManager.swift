import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    private func createURL() -> URL? {
        let publicName = "e93ea0c2443eb860960961f770358c8c"
        let privateName = "c2ad235cd913e96ab415fc4c174f8793b4a32bd1"
        let ts = "1"
        let hash = "\(ts)\(privateName)\(publicName)".mb5()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters"
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicName),
            URLQueryItem(name: "hash", value: hash)
        ]
        return urlComponents.url
    }
    
    func fetchCharacters(completion: @escaping ([FinalResult]?) -> Void) {
        let request = AF.request(self.createURL() ?? "")
        request.responseDecodable(of: Welcome.self) { (response) in
            switch response.result {
            case .success(let data):
                completion(data.data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadImage(from url: URL, into imageView: UIImageView) {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            imageView.image = image
        } else {
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let imageData):
                    if let image = UIImage(data: imageData),
                       let httpResponse = response.response {
                        let cachedData = CachedURLResponse(response: httpResponse, data: imageData)
                        URLCache.shared.storeCachedResponse(cachedData, for: URLRequest(url: url))
                        
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                case .failure(let error):
                    print("Error fetching image: \(error)")
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "square-image")
                    }
                }
            }
        }
    }
}
