//
//  ProfileVC+Ext.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit
import SwiftUI

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
    let profileLabel                = UILabel()
    var nameUserLabel               = UILabel()
    var emailUserLabel              = UILabel()
    let languageButton              = UIButton()
    let rightArrowImageView         = UIImageView()
    let termsAndConditionsButton    = UIButton()
    let rightArrowImageView2        = UIImageView()
    let testbutton = ProfileUIButton(labelText: "Language", tintColor: .purplePrimary, image: UIImage(systemName: "chevron.right"))
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor=UIColor(named: "greyLighter")
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 36
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    

    
    func addSubviews() {
        view.addSubviews(profileLabel, nameUserLabel, emailUserLabel, languageButton, profileImageView, rightArrowImageView, termsAndConditionsButton, rightArrowImageView2, testbutton)
    }
    
    // MARK: - Functions
    public func setBackground() {
        self.view.backgroundColor = .white
        testbutton.backgroundColor = UIColor(named: "greyLighter")
    }
    
    
    func setupProfileImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    func setNameUser(){
        
        nameUserLabel.text = "USER_NAME"
        
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
    
    func makeConstrains(){
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.equalToSuperview().inset(20)
        }
        
        testbutton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-400)
            make.height.equalTo(56)
        }
        
        nameUserLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerX).offset(1)
            make.left.equalToSuperview().inset(120)
        }
        
        emailUserLabel.snp.makeConstraints { make in
            
        }
        
    }
    
    

    
    
    // MARK: - ObjC functions
    @objc func changeProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}
