struct Characters: Decodable {
    let characters: [Character]
}

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let path: String
    let extensions: String
}
