// MovieListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieListViewModelProtocol {
    var updateViewData: ((MovieListData) -> ())? { get set }
    func startFetch()
    func loadImage(url: URL?, completion: @escaping (Data) -> ())
}

final class MovieListViewModel: MovieListViewModelProtocol {
    private var movieCollection: [Doc] = []
    public var updateViewData: ((MovieListData) -> ())?
    private var loadImageService = LoadImageService()
    var movieCoordinator: MovieListCoordinator?

    func startFetch() {
        loadDataFromAPI { result in
            switch result {
            case let .success(movies):
                self.updateViewData?(.success(Welcome(docs: movies.docs)))
            case let .failure(error):
                break
            }
        }
    }

    func loadImage(url: URL?, completion: @escaping (Data) -> ()) {
        loadImageService.loadImage(url: url) { data, _, _ in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }

    func showDetailMovie(movieInfo: Doc) {
        movieCoordinator?.showMovie(movieInfo: movieInfo)
    }

    init(coordinator: MovieListCoordinator) {
        movieCoordinator = coordinator
        updateViewData?(.initial)
    }
}
