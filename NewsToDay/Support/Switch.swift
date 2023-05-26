//
//  Switch.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 26.05.2023.
//

import UIKit

final class Switch {
    let builder: BuilderProtocol!
    var window: UIWindow?
    
    init(builder: BuilderProtocol, window: UIWindow?) {
        self.builder = builder
        self.window = window
    }
    
    func root() {
        let status = UserDefaults.standard.bool(forKey: Keys.onboarding)
        
        if status == true {
            window?.rootViewController = TabBarController(builder: builder)
        } else {
            let onboarding = UINavigationController(rootViewController: builder.getOnboardingModule())
            onboarding.navigationItem.setHidesBackButton(true, animated: true)
            window?.rootViewController = onboarding
        }
    }
}
