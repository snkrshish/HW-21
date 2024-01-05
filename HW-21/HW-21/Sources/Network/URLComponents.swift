import Foundation
func createURL() -> URL? {
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
    print(urlComponents.url?.absoluteString ?? "")
    return urlComponents.url
}
