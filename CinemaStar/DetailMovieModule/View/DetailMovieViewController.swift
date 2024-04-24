// DetailMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
class DetailMovieViewController: UIViewController {
    var movie: Doc?
    var viewModel: DetailMovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
}
