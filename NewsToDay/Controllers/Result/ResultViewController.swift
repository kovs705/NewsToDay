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
    
    private func loadImage(urlString: String?) -> UIImage? {
        var image: UIImage?
        guard let urlString else {return nil}
        presenter.fetch(imageFor: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
        return image
    }
}

extension ResultViewController: ResultViewProtocol {
    func success() {
        self.tableView.reloadData()
    }
    
    func failure() {
        
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
        
        cell.setupCell(image: loadImage(urlString: currentArticle.urlToImage),
                       title: currentArticle.title,
                       category: currentArticle.source.name)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    
}
