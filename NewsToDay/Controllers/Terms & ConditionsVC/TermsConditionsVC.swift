//
//  termsConditionsVC.swift
//  NewsToDay
//
//  Created by Admin on 08.05.2023.
//

import UIKit
import SwiftUI
import SnapKit

class TermsConditionsVC: UIViewController{
    
    let textView = UITextView()
    let label=UILabel()
    let backButton = UIButton(type: .system)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setBackground()
        setTitle()
        setTextView()
        setBackButton()
    }
    
    func setTitle(){
        view.addSubview(label)
        label.text="Terms & Conditions"
        if let customFont = UIFont(name: "Inter-SemiBold", size: 24) {
            label.font = customFont
        }
//        else{
//            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
//        }

        label.textColor = UIColor(named: "BlackPrimary")
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(68)
            
        }
    }
    
    func setTextView(){
        view.addSubview(textView)
        
        textView.text = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.
"""
        if let customFont = UIFont(name: "Inter-Regular", size: 19) {
            textView.font = customFont
        }
//        else{
//            textView.font = UIFont.systemFont(ofSize: 21, weight: .regular)
//        }
        textView.textColor = UIColor(named: "GreyLight")
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isSelectable = false
        textView.backgroundColor = .clear
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.top.equalToSuperview().inset(120)
        }
    }
    
    func setBackButton(){
        view.addSubview(backButton)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = UIColor(named: "GreyPrimary")
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(68)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
            
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
    }
    
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

struct ContentTermsConditionsVC: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = TermsConditionsVC
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return TermsConditionsVC()
    }
    
    func updateUIViewController(_ uiViewController: TermsConditionsVC, context: Context) {}
}
struct ContentMainViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentTermsConditionsVC()
            .previewInterfaceOrientation(.portrait)
            .edgesIgnoringSafeArea(.all)
    }
}
