// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class ModuleBuilder {
    static func makeMovieListModule(coordinator: MovieListCoordinator) -> UIViewController {
        let viewController = MovieListViewController()
        return viewController
    }
}
