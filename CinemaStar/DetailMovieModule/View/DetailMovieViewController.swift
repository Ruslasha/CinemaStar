// DetailMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
final class DetailMovieViewController: UIViewController {
    private enum SectionType {
        case title
        case description
        case actors
        case language
        case recomendations

        var headerTitle: String? {
            switch self {
            case .actors:
                return "Актеры и съемочная группа "
            case .language:
                return "Язык"
            case .recomendations:
                return "Смотрите также"
            default:
                return nil
            }
        }

        var sectionCellType: UITableViewCell {
            switch self {
            case .title:
                return HeaderTableViewCell()
            case .description:
                return DescriptionTableViewCell()
            case .actors:
                return ActorsTableViewCell()
            case .language:
                return UITableViewCell()
            case .recomendations:
                return UITableViewCell()
            }
        }
    }

    var movie: Doc?
    var viewModel: DetailMovieViewModel?

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TitleHeaderView.reuseId)
        return tableView
    }()

    // MARK: - Private Properties

//    private let sections: [SectionType] = [.title, .description, .actors, .language, .recomendations]
    private let sections: [SectionType] = [.title, .description, .actors]

    var viewData: MovieListData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        setView()
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

    private func setView() {
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
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
}

// MARK: - MainViewController + UITableViewDataSource

extension DetailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].sectionCellType
    }
}

// MARK: - MainViewController + UITableViewDelegate

extension DetailMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTitle = sections[section].headerTitle,
              let view = tableView
              .dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.reuseId) as? TitleHeaderView
        else { return nil }
        view.setTitle(text: headerTitle)
        return view
    }
}
