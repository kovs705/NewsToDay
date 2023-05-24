import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let id = "CategoryCell"
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: Colors.greyDark.rawValue)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
                categoryLabel.textColor = .white
                
            } else {
                backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
                categoryLabel.textColor = UIColor(named: Colors.greyDark.rawValue)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupUICell()
    }
    
    func setupUICell() {
        backgroundColor = UIColor(named: Colors.greyLighter.rawValue)
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with category: Category) {
        categoryLabel.text = category.name.capitalized
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(25)
        }
    }
}
