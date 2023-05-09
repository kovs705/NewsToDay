import UIKit

final class NewsCell: UICollectionViewCell, SelfConfiguringCell {
    static let id = "NewsCell"
    let photoView = UIImageView(image: UIImage(named: "Home"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        
    }
}

extension NewsCell {
    private func setupPhotoView() {
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

