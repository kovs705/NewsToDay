import UIKit

class NewsCell: UICollectionViewCell {
    
    var liked: Bool = false
    static let identifier = "NewsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "NoImage")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.text = "The latest situation in the presedential election"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var newsSourse: UILabel = {
        let label = UILabel()
        label.text = "Without category"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func favouriteButtonPressed() {
        if liked {
            favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            liked = false
        } else {
            favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            liked = true
        }
    }
    
    func configureCell(_ newsData: News) {
        setupViews()
        setLayout()
        guard let title = newsData.title, let sourse = newsData.source.name else { return }
        newsTitle.text = title
        newsSourse.text = sourse
    }
    
    private func setLayout() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsSourse)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor,constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            newsTitle.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 15),
            newsTitle.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -15),
            newsTitle.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: -24),
            
            newsSourse.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 15),
            newsSourse.bottomAnchor.constraint(equalTo: newsTitle.topAnchor, constant: -5),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 25),
            favouriteButton.widthAnchor.constraint(equalToConstant: 25),
            favouriteButton.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 20),
            favouriteButton.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor,constant: -20)
        ])
    }
}
