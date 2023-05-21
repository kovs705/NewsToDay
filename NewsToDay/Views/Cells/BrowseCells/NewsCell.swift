import UIKit

class NewsCell: UICollectionViewCell {
    
    static let id = "NewsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News) {
        // ui code
        contentView.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
    }
    
}
