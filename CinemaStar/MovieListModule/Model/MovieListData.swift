// MovieListData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// 1
enum MovieListData {
    case initial
    case loading
    case success(Welcome)
    case failure(Welcome)
}

// MARK: - Welcome

/// 1
struct Welcome: Codable {
    let docs: [Doc]
}

// MARK: - Backdrop

/// 1
struct Backdrop: Codable {
    let url, previewURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Doc

/// 1
struct Doc: Codable {
    let name: String
    let poster: Backdrop
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case name
        case poster, rating
    }
}

// MARK: - Name

/// 1
struct Name: Codable {
    let name: String
    let language, type: String?
}

// MARK: - Rating

/// 1
struct Rating: Codable {
    let kp, imdb, filmCritics, russianFilmCritics: Double
    let ratingAwait: Int?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait = "await"
    }
}
