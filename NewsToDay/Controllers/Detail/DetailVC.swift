//
//  DetailVC.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    var label = UILabel(textColor: <#T##Colors#>, textSize: <#T##CGFloat#>, font: <#T##Font#>, numberOfLines: <#T##Int#>)
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setNews()
    }
    
    
}

extension DetailVC: DetailViewProtocol {
    func setNews(news: News?) {
        // UI code here
    }
    
    
}
