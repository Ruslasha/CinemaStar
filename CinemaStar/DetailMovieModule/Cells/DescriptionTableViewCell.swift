// DescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием
final class DescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseId = String(describing: DescriptionTableViewCell.self)

    // MARK: - Visual Components

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setConstraints()
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetail?) {
        guard let movieDetail else { return }
        descriptionLabel.text = movieDetail.description
        let year = movieDetail.year
        let country = movieDetail.country
        let type = movieDetail.type.typeDescription
        detailsLabel.text = "\(year) / \(country) / \(type)"
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(detailsLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            detailsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailsLabel.heightAnchor.constraint(equalToConstant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
