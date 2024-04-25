// movieDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальная информация
struct MovieDetailed {
    let posterURL: String
    let name: String
    let rating: Double
    let description: String
    let year: Int
    let country: String
    let type: String
    let actors: [Person]?
    let language: String
    let recommendedMovies: [SimilarMovie?]

    init(dto: MovieDTO) {
        posterURL = dto.poster.url ?? ""
        name = dto.name
        rating = dto.rating.kp
        description = dto.description
        year = dto.year
        country = dto.countries.first?.name ?? ""
        type = dto.type
        actors = dto.persons
        language = dto.spokenLanguages?.first ?? ""
        recommendedMovies = dto.similarMovies ?? []
    }
}
