//
//  Constants.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

enum Colors {
    // Purple
    static let purpleDark    = "PurpleDark"
    static let purpleLight   = "PurpleLight"
    static let purpleLighter = "PurpleLighter"
    static let purplePrimary = "PurplePrimary"
    
    // Black
    static let blackDark     = "BlackDark"
    static let blackLight    = "BlackLight"
    static let blackLighter  = "BlackLighter"
    static let blackPrimary  = "BlackPrimary"
    
    // Grey
    static let greyDark      = "GreyDark"
    static let greyLight     = "GreyLight"
    static let greyLighter   = "GreyLighter"
    static let greyPrimary   = "GreyPrimary"
}

enum Categories {
    static let business = "business"
    static let entertainment = "entertainment"
    static let general = "general"
    static let health = "health"
    static let science = "science"
    static let sports = "sports"
    static let technology = "technology"
}

enum Constants {
    enum Font {
        static let interSemiBold = "Inter-SemiBold"
        static let interRegular = "Inter-Regular"
        static let interMedium = "Inter-Medium"
        static let interBold = "Inter-Bold"
    }
    
    
    enum String {
        static let ok = "Ok"
        static let eight = 8
        static let name = "Name"
        static let signIn = "Sign In"
        static let signUp = "Sign Up"
        static let info = "Information"
        static let password = "Password"
        static let email = "Email Adress"
        static let repeatPas = "Repeat password"
        static let welcome = "Welcome Back 👋"
        static let google = "Sign in with Google"
        static let errorPassword = "Incorrect password"
        static let welcomeToNews = "Welcome to NewsToDay"
        static let dontAc = "Don't have an account? Sign Up"
        static let haveAnAcc = "Already have an account? Sign In"
        static let hello = """
Hello, I guess you are new around here. You
can start using the application after sign up.
"""
        static let iAm = """
I am happy to see you again. You can
continue where you left off by logging in
"""
    }
    
    enum Images {
        static let envelope = "envelope"
        static let lock = "lock"
        static let person = "person"
        static let eye = "eye"
        static let google = "google"
    }
}
