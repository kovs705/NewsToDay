//
//  termsConditionsVC.swift
//  NewsToDay
//
//  Created by Admin on 08.05.2023.
//

import UIKit
import SnapKit

final class TermsConditionsVC: UIViewController{
    
    let textView = UITextView()
    let label=UILabel()
    let backButton = UIButton(type: .system)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        setBackground()
        setTitle()
        setTextView()
    }
    
    func setTitle(){
        view.addSubview(label)
        label.text=NSLocalizedString("TERMS_AND_CONDITIONS_HEADER_LABEL", comment: "")
        if let customFont = UIFont(name: "Inter-SemiBold", size: 23) {
            label.font = customFont
        }
//        else{
//            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
//        }

        label.textColor = UIColor(named: Colors.blackPrimary.rawValue)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            
        }
    }
    
    func setTextView(){
        view.addSubview(textView)
        
        textView.text = NSLocalizedString("TERMS_AND_CONDITIONS_MAIN_TEXT", comment: "")
        if let customFont = UIFont(name: "Inter-Regular", size: 19) {
            textView.font = customFont
        }
        textView.textColor = UIColor(named: Colors.greyLight.rawValue)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.backgroundColor = .clear
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalToSuperview().inset(100)
        }
    }
    
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
}
