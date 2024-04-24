// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol DetailMovieViewModelProtocol {
    var updateViewData: ((MovieListData) -> ())? { get set }
//    func startFetch()
//    func loadImage(url: URL?, completion: @escaping (Data) -> ())
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    var updateViewData: ((MovieListData) -> ())?
    var movieInfo: Doc?

    init(movieInfo: Doc? = nil) {
        self.movieInfo = movieInfo
    }

//    func startFetch() {
//        <#code#>
//    }
//
//    func loadImage(url: URL?, completion: @escaping (Data) -> ()) {
//        <#code#>
//    }
}
