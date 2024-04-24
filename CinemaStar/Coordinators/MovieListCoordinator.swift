// MovieListCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана со списком фильмов
final class MovieListCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController?

    override func start() {
        guard let movieListModuleView = ModuleBuilder.makeMovieListModule(coordinator: self) as? MovieListViewController
        else { return }
        navigationController = UINavigationController(rootViewController: movieListModuleView)
        if let navigationController = navigationController {
            setAsRoot(navigationController)
        }
    }

    func showMovie(movieInfo: Doc) {
        guard let detailMovieModule = ModuleBuilder.makeDedtailMovieModule(
            coordinator: self,
            movieInfo: movieInfo
        ) as? DetailMovieViewController
        else { return }
        navigationController?.pushViewController(detailMovieModule, animated: true)
    }

    func closeMovie() {
        guard (navigationController?.viewControllers.last as? DetailMovieViewController) != nil else {
            return
        }
        navigationController?.popViewController(animated: true)
    }
}
