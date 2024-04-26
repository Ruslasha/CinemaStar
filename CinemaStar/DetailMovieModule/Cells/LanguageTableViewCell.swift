// LanguageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
final class LanguageTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseId = String(describing: LanguageTableViewCell.self)

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
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
        setView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        setConstraints()
    }

    // MARK: - Life Cycle

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetailed?) {
        titleLabel.text = movieDetail?.language
    }

    // MARK: - Private Methods

    private func setView() {
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }

    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
