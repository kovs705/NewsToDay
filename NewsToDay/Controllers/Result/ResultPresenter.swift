//
//  ResultPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import Foundation

protocol ResultViewProtocol: AnyObject {
    
}

protocol ResultPresenterProtocol: AnyObject {
    init(view: ResultViewProtocol)
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?
    
    required init(view: ResultViewProtocol) {
        self.view = view
    }
}
