//
//  MovieObject.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 22/02/26.
//
import RealmSwift

class MovieObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterPath: String
    @Persisted var title: String
    @Persisted var overview: String
}

extension MovieObject {
    convenience init(from movie: Movie) {
        self.init()
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
    }
}
