// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol DetailMovieViewModelProtocol {
    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetailed, Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    //    var updateViewData: ((MovieListData) -> ())?
    //    var movieInfo: Doc?
    private var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func getDetailedMovie(by id: Int, completion: @escaping (Result<MovieDetailed, Error>) -> ()) {
        networkService.getDetailedMovie(by: id, completion: completion)
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        networkService.loadImage(by: urlString, completion: completion)
    }
}
