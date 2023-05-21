import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitle()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeaderView {
    private func setupTitle() {
        addSubview(title)
        title.text = "Recommended for you"
        title.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
    }
    
    private func setupButton() {
        addSubview(button)
        button.setTitle("See all", for: .normal)
        button.snp.makeConstraints {
            $0.centerY.equalTo(title)
            $0.right.equalToSuperview()
        }
    }
}
