//
//  VideoResponse.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 22/02/26.
//
import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let site: String
    let type: String
}
