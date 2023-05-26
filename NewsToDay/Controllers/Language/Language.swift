//
//  File.swift
//  NewsToDay
//
//  Created by Admin on 20.05.2023.
//

import Foundation
import UIKit

class Language: UIViewController{
    
    let language = UILabel()
    let englishLanguageButton = ProfileUIButton(labelText: NSLocalizedString("LANGUAGE_ENGLISH_BUTTON", comment: ""), tintColor: .greyDark, image: UIImage(systemName: ""))
    let russianLanguageButton = ProfileUIButton(labelText: NSLocalizedString("LANGUAGE_RUSSIAN_BUTTON", comment: ""), tintColor: .greyDark, image: UIImage(systemName: ""))
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setBackground()
        setSubviews()
        setTitle()
        makeConstrains()
        setTargetsForButtons()
    }
    
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    func localizeChecking(){
        
    }
    
    func setSubviews(){
        view.addSubviews(language, englishLanguageButton, russianLanguageButton)
    }
    
    func setTargetsForButtons(){
        englishLanguageButton.addTarget(self, action: #selector(englishLanguageTupped), for: .touchUpInside)
        russianLanguageButton.addTarget(self, action: #selector(russianLanguageTupped), for: .touchUpInside)
    }
    
    func setTitle(){
        language.text=NSLocalizedString("LANGUAGE_HEADER_LABEL", comment: "")
        if let customFont = UIFont(name: "Inter-SemiBold", size: 23) {
            language.font = customFont
        }
//        else{
//            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
//        }

        language.textColor = UIColor(named: "BlackPrimary")
        language.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            
        }
    }
    
    func makeConstrains(){
        englishLanguageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.height.equalTo(56)
        }
        
        russianLanguageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(englishLanguageButton.snp.bottom).offset(16)
            make.height.equalTo(56)
        }
    }
    
    func setLanguage(_ language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func restartApp() {
            let alertController = UIAlertController(title: NSLocalizedString("LANGUAGE_ALERT_TITLE", comment: "Restart the application"),
                                                    message: NSLocalizedString("LANGUAGE_ALERT_MESSAGE", comment: "Restart the app to change the language?"),
                                                    preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: NSLocalizedString("LANGUAGE_ALERT_CANCEL_ACTION", comment: "Cancel"),
                                             style: .cancel,
                                             handler: nil)
            let okAction = UIAlertAction(title: NSLocalizedString("LANGUAGE_ALERT_OK_ACTION", comment: "Yes"),
                                         style: .default) { (_) in
               fatalError()
                
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    @objc func englishLanguageTupped(){
        setLanguage("en")
        print("tupped eng")
        print()
        restartApp()
    }
    
    @objc func russianLanguageTupped(){
        setLanguage("ru")
        print("tupped ru")
        restartApp()
    }
}
