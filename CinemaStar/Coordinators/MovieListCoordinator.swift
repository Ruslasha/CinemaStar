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
}
