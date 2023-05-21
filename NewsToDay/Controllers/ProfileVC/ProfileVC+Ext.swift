//
//  ProfileVC+Ext.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

// MARK: - imagePickerController
extension ProfileExt: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

class ProfileExt: UIViewController {
    
    // MARK: - Properties
    var nameUserLabel               = UILabel()
    var emailUserLabel              = UILabel()
    let signOutButton               = ProfileUIButton(labelText: NSLocalizedString("PROFILE_SIGN_OUT_BUTTON", comment: ""), tintColor: .greyDark, image: UIImage(systemName: "rectangle.portrait.and.arrow.right"))
    let termsAndConditionsButton    = ProfileUIButton(labelText: NSLocalizedString("PROFILE_TERMS_AND_CONDITIONS_BUTTON", comment: ""), tintColor: .greyDark, image: UIImage(systemName: "chevron.right"))
    let languageButton              = ProfileUIButton(labelText: NSLocalizedString("PROFILE_LANGUAGE_BUTTON", comment: ""), tintColor: .greyDark, image: UIImage(systemName: "chevron.right"))
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "greyLighter")
        imageView.image = UIImage(named: "bigDick")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 36
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    

    
    func addSubviews() {
        view.addSubviews(nameUserLabel, emailUserLabel, languageButton, profileImageView, termsAndConditionsButton, signOutButton)
    }
    
    // MARK: - Functions
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    
    func setupProfileImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    func setNameUser(){
        
        nameUserLabel.text = ["Александр",
                              "Екатерина",
                              "Михаил",
                              "Анна",
                              "Иван",
                              "Ольга",
                              "Дмитрий",
                              "Наталья",
                              "Сергей",
                              "Мария"].randomElement()!
        
        if let customFont = UIFont(name: "Inter-Medium", size: 16) {
            nameUserLabel.font = customFont
        }
        //        else{
        //            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        //        }
        nameUserLabel.textColor = UIColor(named: "BlackPrimary")
        
    }
    func setEmailUser(){
        
        emailUserLabel.text = "email@icloud.com"
        
        if let customFont = UIFont(name: "Inter-Medium", size: 14) {
            emailUserLabel.font = customFont
        }
        //        else{
        //            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        //        }
        emailUserLabel.textColor = UIColor(named: "GreyPrimary")
        
    }
    
    func addTargetForButtons(){
        termsAndConditionsButton.addTarget(self, action: #selector(termsAndConditionsButtonTapped), for: .touchUpInside)
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
    }
    
    func makeConstrains(){
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.equalToSuperview().inset(20)
        }
        
        languageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(148)
            make.height.equalTo(56)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-112)
            make.height.equalTo(56)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
            make.height.equalTo(56)

        }
        
        nameUserLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
            make.left.equalToSuperview().inset(116)
        }
        
        emailUserLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(68)
            make.left.equalToSuperview().inset(116)
        }
        
    }
    
    // MARK: - ObjC functions
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func termsAndConditionsButtonTapped() {
            let termsAndConditionsViewController = TermsConditionsVC()
            navigationController?.pushViewController(termsAndConditionsViewController, animated: true)
        }
    @objc func languageButtonTapped(){
        let languageViewController = Language()
        navigationController?.pushViewController(languageViewController, animated: true)
    }
}
