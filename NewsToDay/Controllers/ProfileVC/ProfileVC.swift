//
//  ProfileVC.swift
//  NewsToDay
//
//  Created by Admin on 10.05.2023.
//

import UIKit
import SnapKit
import SwiftUI

class ProfileVC: ProfileExt {
    
    var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        
        setBackground()
        setTitle()
        setupProfileImageView()
        setNameUser()
        setEmailUser()
        setButtonLanguage()
        setTermsAndConditionsButton()
    }
    
}

struct ContentProfileVC: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ProfileVC
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return ProfileVC()
    }

    func updateUIViewController(_ uiViewController: ProfileVC, context: Context) {}
}

struct ContentProfileController_Previews: PreviewProvider {
    static var previews: some View {
        ContentProfileVC()
            .previewInterfaceOrientation(.portrait)
            .edgesIgnoringSafeArea(.all)
    }
}