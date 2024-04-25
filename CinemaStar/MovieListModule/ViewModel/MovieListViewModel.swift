// MovieListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol MovieListViewModelProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

final class MovieListViewModel: MovieListViewModelProtocol {
//    private var movieCollection: [Doc] = []
//    public var updateViewData: ((MovieListData) -> ())?
//    private var loadImageService = LoadImageService()
    private var networkService: NetworkServiceProtocol
    private var movieCoordinator: MovieListCoordinator

//    func startFetch() {
//        loadDataFromAPI { result in
//            switch result {
//            case let .success(movies):
//                self.updateViewData?(.success(Welcome(docs: movies.docs)))
//            case let .failure(error):
//                break
//            }
//        }
//    }
//
//    func loadImage(url: URL?, completion: @escaping (Data) -> ()) {
//        loadImageService.loadImage(url: url) { data, _, _ in
//            guard let data = data else {
//                return
//            }
//            DispatchQueue.main.async {
//                completion(data)
//            }
//        }
//    }
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        networkService.getMovies(completion: completion)
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        networkService.loadImage(by: urlString, completion: completion)
    }

    func showDetailMovie(id: Int) {
        movieCoordinator.showMovie(id)
    }

    init(networkService: NetworkServiceProtocol, coordinator: MovieListCoordinator) {
        self.networkService = networkService
        movieCoordinator = coordinator
//        updateViewData?(.initial)
    }
}
