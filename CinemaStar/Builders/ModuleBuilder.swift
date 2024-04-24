// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class ModuleBuilder {
    static func makeMovieListModule(coordinator: MovieListCoordinator) -> UIViewController {
        let viewController = MovieListViewController(coordinator: coordinator)
        viewController.viewModel = MovieListViewModel(coordinator: coordinator)
        return viewController
    }

    static func makeDedtailMovieModule(coordinator: MovieListCoordinator, movieInfo: Doc) -> UIViewController {
        let viewController = DetailMovieViewController()
        viewController.viewModel = DetailMovieViewModel(movieInfo: movieInfo)
        return viewController
    }
}
