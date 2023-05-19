//
//  ResultViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {

    //MARK: - Property
    
    var presenter: ResultPresenterProtocol!
    
    //MARK: - UI Elements
    
    private var tableView = UITableView()
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.fetchHeadlines()
    }
    
    //MARK: - Setup UI
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "ResultViewController")
        view.addSubview(tableView)
    }
    
}

extension ResultViewController: ResultViewProtocol {
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultViewController", for: indexPath) as! BookmarksTableViewCell
        let currentArticle = presenter.news[indexPath.row]
        cell.setupCell(news: currentArticle)
        cell.setupImage(news: currentArticle)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    
}
