// ActorsCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции с актерами
final class ActorsCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        static let imageRatio = 73.0 / 46.0
    }

    static let reuseId = String(describing: ActorsCollectionViewCell.self)

    // MARK: - Visual Components

    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .verdana(ofSize: 8)
        label.textColor = .white
        return label
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

//    private let networkService = NetworkService(requestCreator: RequestCreator())

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setConstraint()
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    func setupCell(with actorName: String?) {
        guard let actorName else { return }
        nameLabel.text = actorName
        actorImageView.image = UIImage(named: "Verona")
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
    }

    private func setConstraint() {
        actorImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.heightAnchor.constraint(equalToConstant: 72),
            actorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            actorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),

            nameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11)
        ])
    }
}
