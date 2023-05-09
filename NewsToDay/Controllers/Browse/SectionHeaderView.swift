import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    let button = UIButton(type: .system)
    let arrowImage = UIImage(named: "Arrow")

    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Title"

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(arrowImage, for: .normal)

        let stackView = UIStackView(arrangedSubviews: [title, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8

        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapButton() {
    
    }
}
