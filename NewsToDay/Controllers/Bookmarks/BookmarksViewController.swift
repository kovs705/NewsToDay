//
//  BookmarksViewController.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 19.05.2023.
//

import UIKit

final class BookmarksViewController: UIViewController {
    
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
        setupEmptyView()
        setupEmptyLabel()
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
        let book = UIImageView()
        book.image = UIImage(systemName: "book.closed.fill")
        book.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        emptyView.addSubview(book)
        book.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        emptyView.layer.cornerRadius = (72 / 2)
        emptyView.backgroundColor = UIColor(named: Colors.purpleLighter.rawValue)
        emptyView.isHidden = true
    }
    
    private func setupEmptyLabel() {
        emptyLabel = UILabel(textColor: .blackPrimary, textSize: 16, font: .interMedium, numberOfLines: 3)
        emptyLabel.textAlignment = .center
        emptyLabel.text = NSLocalizedString("BOOKMARKS_MESSAGE_VIEW", comment: "You haven't saved any articles yet. Start reading and bookmarking them now")
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

//MARK: - BookmarksViewProtocol

extension BookmarksViewController: BookmarksViewProtocol {
    func failure() {
        tableView.isHidden = true
        emptyView.isHidden = false
        emptyLabel.isHidden = false
    }
    
    func success() {
        tableView.isHidden = false
        emptyView.isHidden = true
        emptyLabel.isHidden = true

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarksViewController", for: indexPath) as! BookmarksTableViewCell
        guard let currentArticle = presenter.news?[indexPath.row] else { return cell }
        cell.setupCell(news: currentArticle)
        cell.setupImage(news: currentArticle)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinator = Builder()
        guard let currentArticle = presenter.news?[indexPath.row] else { return }
        
        navigationController?.pushViewController(coordinator.getDetailVCModule(news: currentArticle), animated: true)
    }
}
