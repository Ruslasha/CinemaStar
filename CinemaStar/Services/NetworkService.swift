// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Протокол для сети
protocol NetworkServiceProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetailed, Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

/// Сеть
final class NetworkService {
    // MARK: - Private Properties

    private let decoder = JSONDecoder()
    private var requestCreator: QueryBuilderProtocol?

    // MARK: - Initialization

    init(requestCreator: QueryBuilderProtocol?) {
        self.requestCreator = requestCreator
    }

    // MARK: - Private Methods

    private func transToMovies(_ response: Response) -> [Movie] {
        response.docs.map { Movie(dto: $0) }
    }

    private func getData<T: Codable>(
        request: URLRequest?,
        parseProtocol: T.Type,
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        guard let request else { return }
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self else {
                return
            }
            guard let downloadedData = data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let parsedData = try self.decoder.decode(parseProtocol, from: downloadedData)
                completion(.success(parsedData))
            } catch { completion(.failure(error)) }
        }
        task.resume()
    }
}

// MARK: - NetworkService - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        let request = requestCreator?.createMoviesURLRequest()
        getData(request: request, parseProtocol: Response.self) { result in
            switch result {
            case let .success(response):
                let movies = self.transToMovies(response)
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetailed, Error>) -> ()) {
        let request = requestCreator?.createDetailMovieURLRequest(id: id)
        getData(request: request, parseProtocol: MovieDTO.self) { result in
            switch result {
            case let .success(movieDTO):
                completion(.success(MovieDetailed(dto: movieDTO)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return
        }
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
