// movieDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// 1
struct Response: Codable {
    let docs: [MovieDTO]
}

/// 1
struct MovieDTO: Codable {
    let id: Int
    let poster: Poster
    let name: String
    let rating: RatingKP
    let description: String
    let year: Int
    let countries: [Country]
    let type: MovieType
    let persons: [Person]?
    let spokenLanguages: [String]?
//    let spokenLanguages: [SpokenLanguages]?
    let similarMovies: [SimilarMovie]?
}

/// 1
struct Poster: Codable {
    let url: String?
}

/// 1
struct Country: Codable {
    let name: String
}

/// 1
struct SpokenLanguages: Codable {
    let name: String
}

/// 1
struct RatingKP: Codable {
    let kp: Double
}

/// 1
struct Person: Codable {
    let photo: String
    let name: String?
}

/// 1
struct SimilarMovie: Codable {
    let name: String
    let poster: Poster
}
