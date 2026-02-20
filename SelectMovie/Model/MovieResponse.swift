//
//  MovieResponse.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 20/02/26.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title, originalTitle, overview, posterPath: String
    let mediaType: MediaType
    let originalLanguage: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}
