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
    let id: Int
    let title, overview, posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case overview
        case posterPath = "poster_path"
    }
    
    init(id: Int?, title: String?, overview: String?, posterPath: String?) {
        self.id = id ?? .zero
        self.title = title ?? String()
        self.overview = overview ?? String()
        self.posterPath = posterPath ?? String()
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}
