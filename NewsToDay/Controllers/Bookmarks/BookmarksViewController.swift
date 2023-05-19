//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 19.05.2023.
//

import UIKit

class BookmarksViewController: UIViewController {

    //MARK: - Property
    
    var presenter: BookmarksPresenterProtocol!
    
    //MARK: - UI Elements
    
    private var tableView = UITableView()
    private var emptyView = UIView()
    private var emptyLabel = UILabel()
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getBookmarks()
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
        tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "BookmarksViewController")
        view.addSubview(tableView)
    }
    
    private func setupEmptyView() {
        let book = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        book.center = emptyView.center
        book.image = UIImage(systemName: "book.closed.fill")
        book.image = book.image?.withTintColor(UIColor(named: Colors.purplePrimary.rawValue) ?? .black)
        emptyView.addSubview(book)
        emptyView.layer.cornerRadius = 72 / 2
        emptyView.backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
    }
    
    //MARK: - Layout
    
    private func setConstraints() {
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        let views: [UIView] = [emptyView, emptyLabel]
        views.forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func makeConstraints() {
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(72)
        }
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(60)
        }
    }
}

extension BookmarksViewController: BookmarksViewProtocol {
    func failure() {
        
    }
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultViewController", for: indexPath) as! BookmarksTableViewCell
        guard let currentArticle = presenter.news?[indexPath.row] else { return cell }
        cell.setupCell(news: currentArticle)
        cell.setupImage(news: currentArticle)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension BookmarksViewController: UITableViewDelegate {
        
}
