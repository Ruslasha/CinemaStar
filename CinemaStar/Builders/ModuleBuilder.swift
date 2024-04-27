// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class ModuleBuilder {
    var queryBuilder = QueryBuilder()
    private lazy var networkService = NetworkService(queryBuilder: queryBuilder)

    func makeMovieListModule(coordinator: MovieListCoordinator) -> UIViewController {
        let viewModel = MovieListViewModel(networkService: networkService, coordinator: coordinator)
        let viewController = MovieListViewController(viewModel: viewModel, coordinator: coordinator)
        return viewController
    }

    func makeDedtailMovieModule(coordinator: MovieListCoordinator, id: Int) -> UIViewController {
        let viewModel = DetailMovieViewModel(networkService: networkService)
        let viewController = DetailMovieViewController(id: id, viewModel: viewModel)
        return viewController
    }
}
