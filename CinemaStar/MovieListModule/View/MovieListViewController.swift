// MovieListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
final class MovieListViewController: UIViewController {
    // MARK: - Types

    // MARK: - Constants

    enum Constants {
        static let minimumLineSpacing: CGFloat = 15
        static let minimumInteritemSpacing: CGFloat = 10
        static let title = "Смотри исторические\nфильмы на "
        static let brandName = "CINEMA STAR"
    }

    // MARK: - IBOutlets

    // MARK: - Visual Components

    private var titleMovies: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Public Properties

    var viewData: MovieListData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    // MARK: - Private Properties

    private var movieCollectionView: UICollectionView?
    private var movieCollection: [Doc] = []
    private var moviePostersCollection: [Data] = []
    private var loadImageService = LoadImageService()
    var movieCoordinator: MovieListCoordinator?
    var viewModel: MovieListViewModelProtocol?

    // MARK: - Initializers

    init(coordinator: MovieListCoordinator) {
        super.init(nibName: nil, bundle: nil)
        movieCoordinator = coordinator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
//        viewModel = MovieListViewModel()
        super.viewDidLoad()

        setupView()
        updateView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        switch viewData {
        case .initial:
            viewModel?.startFetch()
        case .loading:
            movieCollectionView?.reloadData()
        case let .success(welcome):
            movieCollection = welcome.docs

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.movieCollectionView?.reloadData()
            }
        case .failure:
            break
        }
    }

    // MARK: - Public Methods

    // MARK: - IBAction

    // MARK: - Private Methods

    private func loadImages(movieCollection: [Doc]) {
        for movieData in movieCollection {
            viewModel?.loadImage(
                url: URL(string: movieData.poster.url),
                completion: { imageData in
                    self.moviePostersCollection.append(imageData)
                }
            )
        }
    }

    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            self?.viewData = viewData
        }
    }

    private func setupView() {
        setTitle()
        setMovieCollection()
    }

    private func setMovieCollection() {
        movieCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeFlowLayout()
        )
        guard let movieCollectionView else { return }
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = .clear
        view.addSubview(movieCollectionView)
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        setupGradient()
        NSLayoutConstraint.activate([
            movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieCollectionView.topAnchor.constraint(equalTo: titleMovies.bottomAnchor, constant: 14),
            movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func makeTitleText() -> NSAttributedString {
        let generalAttributes: [NSAttributedString.Key: UIFont?] = [.font: .verdana(ofSize: 20)]
        let mainTitleText = NSMutableAttributedString(
            string: Constants.title,
            attributes: generalAttributes as [NSAttributedString.Key: Any]
        )

        let boldAttributes: [NSAttributedString.Key: UIFont?] = [.font: .verdanaBold(ofSize: 20)]
        let brandText = NSAttributedString(
            string: Constants.brandName,
            attributes: boldAttributes as [NSAttributedString.Key: Any]
        )

        mainTitleText.append(brandText)
        return mainTitleText
    }

    private func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        return layout
    }

    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(red: 179 / 255, green: 141 / 255, blue: 87 / 255, alpha: 0.51).cgColor,
            UIColor(red: 43 / 255, green: 81 / 255, blue: 74 / 255, alpha: 1).cgColor,
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func setTitle() {
        view.addSubview(titleMovies)
        titleMovies.attributedText = makeTitleText()
        titleMovies.numberOfLines = 0
        NSLayoutConstraint.activate([
            titleMovies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleMovies.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleMovies.widthAnchor.constraint(equalToConstant: 300),
            titleMovies.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - RecipesViewController + UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieCoordinator?.showMovie(movieInfo: movieCollection[indexPath.item])
    }
}

// MARK: - MovieListViewController + UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieCollection.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.reuseID,
            for: indexPath
        ) as? MovieCell else { return UICollectionViewCell() }

        cell.setupCell(movie: movieCollection[indexPath.item])
        return cell
    }
}

// MARK: - MovieListViewController + UICollectionViewDelegateFlowLayout

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: view.bounds.width / 2 - 25,
            height: view.bounds.width / 2 + 25
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
}
