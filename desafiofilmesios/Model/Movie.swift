// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
class Movie: NSObject, Codable {
    let popularity: Double
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title, releaseDate, originalLanguage, originalTitle: String
    let genreIDS: [Int]?
    let genres: [Genre]?
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case popularity, id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title,genres
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
    }

    init(popularity: Double, id: Int, video: Bool, voteCount: Int, voteAverage: Double, title: String, releaseDate: String, originalLanguage: String,
         originalTitle: String, genreIDS: [Int], backdropPath: String?, adult: Bool, overview: String, posterPath: String?, genres: [Genre]) {
        self.popularity = popularity
        self.id = id
        self.video = video
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.title = title
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
        self.posterPath = posterPath
        self.genres = genres
    }
}
