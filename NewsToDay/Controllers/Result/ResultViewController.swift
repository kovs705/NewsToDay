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
}

extension ResultViewController: ResultViewProtocol {
    
}

//MARK: - UITableViewDataSource

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultViewController", for: indexPath) as! BookmarksTableViewCell
        cell.setupCell(image: UIImage(systemName: "trash.fill")!,
                       title: "Very very loooong title of this news", category: "Category")
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ResultViewController: UITableViewDelegate {
    
}
