//
//  APIService.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 20/02/26.
//
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchMovies() async throws -> [Movie] {
        let apiKey = "ed04c9dff960d8f37828f60ece8f353a"
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"

        let response = await AF.request(url)
            .serializingDecodable(MovieResponse.self)
            .response

        return try response.result.get().results
    }
}
