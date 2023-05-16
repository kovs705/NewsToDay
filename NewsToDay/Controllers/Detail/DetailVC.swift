//
//  DetailVC.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // things to come ˆ_ˆ
    }
    
    
}

extension DetailVC: DetailViewProtocol {
    func setNews(news: News?) {
        // UI code here
    }
    
    
}
