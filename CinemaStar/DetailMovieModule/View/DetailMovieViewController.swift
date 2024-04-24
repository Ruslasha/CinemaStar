// DetailMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
class DetailMovieViewController: UIViewController {
    var movie: Doc?
    var viewModel: DetailMovieViewModel?

    var viewData: MovieListData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        switch viewData {
        case .initial:
            viewModel?.startFetch()
        case .loading:
            viewModel?.startFetch()
        case let .success(welcome):
            viewModel?.startFetch()
        case .failure:
            break
        }
    }
}
