//
//  PopularMoviesViewController.swift
//  villou_ios
//
//  Created by Carlos Villanueva Ousset on 5/18/18.
//  Copyright © 2018 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class PopularMoviesViewController: UIViewController, BindableType {

    fileprivate struct CellReuseId {
        static let movie = "MovieCell"
    }

    fileprivate struct Geometry {
        static let movieRowEstimatedHeight: CGFloat = 100
    }

    @IBOutlet fileprivate weak var tableView: UITableView!

    var viewModel: PopularMoviesViewModel!
    fileprivate let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        loadNextPageData()
    }

    // MARK: - Setup

    fileprivate func initialSetup() {
        let movieCellNib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(movieCellNib, forCellReuseIdentifier: CellReuseId.movie)
        tableView.estimatedRowHeight = Geometry.movieRowEstimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func bindViewModel() {
        viewModel.movies
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CellReuseId.movie, cellType: MovieTableViewCell.self)) { row, movie, cell in
                cell.configure(with: movie)
            }
            .disposed(by: disposeBag)

        tableView.rx.contentOffset
            .filter { [weak self] _ in self?.tableView.isNearBottom() ?? false }
            .subscribe(onNext: { [weak self] _ in
                self?.loadNextPageData()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Update

    fileprivate func loadNextPageData() {
        viewModel.loadNextPage()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
