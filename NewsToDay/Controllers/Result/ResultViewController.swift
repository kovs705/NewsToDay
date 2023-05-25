//
//  ResultViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {

    //MARK: - Property
    
    var presenter: ResultPresenterProtocol!
    var coordinator: BuilderProtocol?
    
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
    
    private func spinnerViewSetup() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension ResultViewController: ResultViewProtocol {
    func failure(error: Error) {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentArticle = presenter.news[indexPath.row]
        let destVC = coordinator?.getDetailVCModule(news: currentArticle)
        
        navigationController?.pushViewController(destVC!, animated: true)
    }
}

//MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        // print(position, "we need -", (tableView.contentSize.height - 100 - scrollView.frame.size.height))
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if !presenter.isFetchig {
                presenter.isFetchig = true
                // print("fetching")
                self.tableView.tableFooterView = spinnerViewSetup()
                // print("current page = ")
                self.presenter.fetchHeadlines()
            }
        }
    }
}
