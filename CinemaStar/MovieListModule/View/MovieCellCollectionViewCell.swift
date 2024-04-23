// MovieCellCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
class MovieCell: UICollectionViewCell {
    // MARK: - Types

    private var loadImageService: LoadImageServiceProtocol?

    // MARK: - Constants

    static let reuseID = "MovieCellCollectionViewCell"

    // MARK: - Visual Components

    private let titleImageView = UIImageView()

    private let filmTitle: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public methods

    func setupCell(movie: Doc) {
        filmTitle.text = movie.name
        ratingLabel.text = String(movie.rating.imdb)
//        titleImageView.image = movie.poster.url
    }

    func setImage(_ imageData: Data) {
//        DispatchQueue.main.async {
//            self.titleImageView.image = UIImage(data: imageData)
//        }
    }

    // MARK: - Private methods

    private func setViews() {
        backgroundColor = .clear
        setTitleImageViewConstaints()
        setFilmTitleConstaints()
        setRatingLabelConstaints()
        contentView.clipsToBounds = true
    }

    private func setTitleImageViewConstaints() {
        contentView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func setFilmTitleConstaints() {
        contentView.addSubview(filmTitle)
        NSLayoutConstraint.activate([
            filmTitle.heightAnchor.constraint(equalToConstant: 20),
            filmTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            filmTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            filmTitle.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    private func setRatingLabelConstaints() {
        contentView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}