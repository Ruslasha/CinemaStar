// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol DetailMovieViewModelProtocol {
    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetail, Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

/// Вью модель экрана деталей
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    private var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetail, Error>) -> ()) {
        networkService.getDetailMovie(by: id, completion: completion)
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        networkService.loadImage(by: urlString, completion: completion)
    }
}
