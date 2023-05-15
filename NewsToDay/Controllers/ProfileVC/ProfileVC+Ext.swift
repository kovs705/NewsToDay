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
        view.addSubviews(profileLabel, nameUserLabel, emailUserLabel, languageButton, rightArrowImageView, termsAndConditionsButton, rightArrowImageView2)
    }
    
    // MARK: - Functions
    public func setBackground() {
        self.view.backgroundColor = .white
    }
    
    func setTitle() {
        
        profileLabel.text = "Profile"
        if let customFont = UIFont(name: "Inter-SemiBold", size: 30) {
            profileLabel.font = customFont
        }
        //        else{
        //            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        //        }
        
        profileLabel.textColor = UIColor(named: "BlackPrimary")
        profileLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(72)
            
        }
        
    }
    
    func setupProfileImageView() {
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(82)
            make.top.equalToSuperview().offset(136)
            make.left.equalToSuperview().offset(20)
        }
        
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
        
        nameUserLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(148)
            make.left.equalToSuperview().inset(120)
        }
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
        
        emailUserLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(172)
            make.left.equalToSuperview().inset(120)
        }
    }
    
    func setButtonLanguage(){
        
        let customFont = UIFont(name: "Inter-Medium", size: 24)
        
        let label1 = UILabel()
        label1.text = "Language"
        label1.textAlignment = .left
        label1.font = customFont
        
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 35
        
        
        languageButton.setTitle("Language", for: .normal)
        languageButton.layer.cornerRadius  = 15
        languageButton.layer.masksToBounds = true
        
        languageButton.setTitleColor(UIColor(named: "GreyDark"), for: .normal)
        languageButton.backgroundColor = UIColor(named: "greyLighter")
        
        languageButton.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(languageButton).inset(24)
        })
        
        languageButton.snp.makeConstraints { make in
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(252)
        }
        
        // создать лэйбл для текста слева
        // создать лэйбл для иконки справа
        // создать stackView с alignment fill (?)
        // дать правому лэйблу с иконкой фиксированную ширину, не трогая левый лэйбл
        // проверить, будет ли занимать левый лэйбл всё пространство
        
        // stackView top - 0, bottom - 0, leading - 20, trailing - 20
        
        
        
        // setImageViewForButton()
    }
    
    func setImageViewForButton(){
        
        rightArrowImageView.image=UIImage(systemName: "chevron.right")
        rightArrowImageView.tintColor=UIColor(named: "GreyDark")
        
        rightArrowImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(20)
            make.top.equalToSuperview().inset(271)
            make.left.equalToSuperview().inset(320)
        }
    }
    
    func setTermsAndConditionsButton(){
        
        termsAndConditionsButton.setTitle("Terms & Conditions", for: .normal)
        termsAndConditionsButton.layer.cornerRadius  = 15
        termsAndConditionsButton.layer.masksToBounds = true
        
        if let customFont = UIFont(name: "Inter-Medium", size: 24) {
            termsAndConditionsButton.titleLabel?.font = customFont
        }
        //        else{
        //            termsAndConditionsButton.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        //        }
        
        termsAndConditionsButton.setTitleColor(UIColor(named: "GreyDark"), for: .normal)
        termsAndConditionsButton.backgroundColor = UIColor(named: "greyLighter")
        
        termsAndConditionsButton.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(termsAndConditionsButton).inset(24)
        })
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(208)
        }
        
        setImageViewForButton2()
    }
    
    func setImageViewForButton2(){
        
        rightArrowImageView2.image=UIImage(systemName: "chevron.right")
        rightArrowImageView2.tintColor=UIColor(named: "GreyDark")
        
        rightArrowImageView2.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(225)
            make.left.equalToSuperview().inset(320)
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
