import UIKit

final class CategoryCell: UICollectionViewCell {
    static let id = "CategoryCell"
    
    private let titleLabel = UILabel()
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                contentView.backgroundColor = Theme.purple
//                titleLabel.textColor = .white
//                titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
//            } else {
//                contentView.backgroundColor = .clear
//                contentView.layer.borderColor = UIColor.lightGray.cgColor
//                titleLabel.textColor = Theme.darkGreyToWhite
//
//                titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
//            }
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: String) {
        titleLabel.text = category
    }
    
    private func setupView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        setupTitleLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = frame.height / 2
    }
}

extension CategoryCell {
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "Yes"
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
