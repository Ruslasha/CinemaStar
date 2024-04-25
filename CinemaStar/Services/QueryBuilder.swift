// QueryBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол посторителя запроса
protocol QueryBuilderProtocol {
    func createMoviesURLRequest() -> URLRequest?
    func createDetailMovieURLRequest(id: Int) -> URLRequest?
}

/// Построитель запроса
final class QueryBuilder: QueryBuilderProtocol {
    // MARK: - Constants

    private enum Constants {
        static let sheme = "https"
        static let host = "api.kinopoisk.dev"
        static let path = "/v1.4/movie"
    }

    // MARK: - Private Methods

    private func makeMoviesQueryItems(
        searchText: String = "История",
        pages: Int = 1,
        limit: Int = 10
    ) -> [URLQueryItem] {
        let pageQuery = URLQueryItem(name: "page", value: "\(pages)")
        let limitQuery = URLQueryItem(name: "limit", value: "\(limit)")
        let searchQuery = URLQueryItem(name: "query", value: searchText)

        let queries = [pageQuery, limitQuery, searchQuery]
        return queries
    }

    func createDetailMovieURLRequest(id: Int) -> URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.sheme
        components.host = Constants.host
        components.path = Constants.path + "/" + "\(id)"
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forHTTPHeaderField: "X-API-KEY")
        return request
    }

    func createMoviesURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.sheme
        components.host = Constants.host
        components.path = Constants.path
        components.queryItems = makeMoviesQueryItems()
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
