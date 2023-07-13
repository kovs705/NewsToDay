import UIKit

final class NewsCell: UICollectionViewCell {
    
    static let id = "NewsCell"
    
    //MARK: - UI Elements
    
    private var newsImageView = UIImageView()
    private var newsTitle = UILabel()
    private var newsSourse = UILabel()
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    let placeholderImg = UIImage(named: "placeholderImage")
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setupViews()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
    }
    
    //MARK: - Public Setup
    
    func setupCell(news: News) {
        guard let title = news.title, let sourse = news.source.name else { return }
        newsTitle.text = title
        newsSourse.text = sourse.uppercased()
    }
    
    func setupImage(news: News) {
        guard let urlToImage = news.urlToImage else {
            newsImageView.image = placeholderImg
            newsImageView.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        ImageClient.shared.setImage(from: urlToImage) { [weak self] image in
            guard let image else { return }
            self?.newsImageView.image = image
            self?.newsImageView.contentMode = .scaleAspectFill
            self?.loadingActivityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Setup UI Elements
    
    private func setupViews() {
        setupNewsImageView()
        backgroundColor = .clear
        loadingActivityIndicator.startAnimating()
        setupNewsTitle()
        setupNewsSourse()
    }
    
    private func setupNewsImageView() {
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 12
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
    }
    
    private func setupGradient() {
        newsImageView.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradient.locations = [0.0, 1.0]
        newsImageView.layer.insertSublayer(gradient, at: 0)
        gradient.frame = newsImageView.bounds
        newsImageView.layoutIfNeeded()
    }
    
    private func setupNewsTitle() {
        newsTitle.numberOfLines = 3
        newsTitle.font = UIFont(name: Font.interSemiBold.rawValue, size: 14)
        newsTitle.textColor = .white
    }
    
    private func setupNewsSourse() {
        newsSourse.numberOfLines = 1
        newsSourse.font = UIFont(name: Font.interRegular.rawValue, size: 11)
        newsSourse.textColor = .white
    }
    
    //MARK: - Layout
    
    private func setLayout() {
        addSubviews()
        makeContraints()
    }
    
    private func addSubviews() {
        [newsImageView, newsTitle,
         newsSourse, loadingActivityIndicator].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func makeContraints() {
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            newsTitle.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor,
                                              constant: -24),
            newsTitle.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor,
                                               constant: 24),
            newsTitle.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor,
                                                constant: -24),
            
            newsSourse.leadingAnchor.constraint(equalTo: newsTitle.leadingAnchor),
            newsSourse.bottomAnchor.constraint(equalTo: newsTitle.topAnchor, constant: -8),
            
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: newsImageView.centerYAnchor),
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            loadingActivityIndicator.widthAnchor.constraint(equalToConstant: 32),
            loadingActivityIndicator.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
}
