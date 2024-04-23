// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

func loadDataFromAPI(completion: @escaping (Result<Welcome, NetworkError>) -> Void) {
    guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie/search") else {
        completion(.failure(.invalidURL))
        return
    }

    var request = URLRequest(url: url)
    request.setValue("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forHTTPHeaderField: "X-API-KEY")

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }

        guard let data = data else {
            completion(.failure(.noData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let welcome = try decoder.decode(Welcome.self, from: data)
            completion(.success(welcome))
        } catch {
            completion(.failure(.decodingError(error)))
        }
    }

    task.resume()
}
