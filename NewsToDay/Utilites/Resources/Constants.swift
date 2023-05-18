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

enum Web {
    enum Region: String {
        case uae = "ae"
        case argentina = "ar"
        case austria = "at"
        case australia = "au"
        case belgium = "be"
        case country = "bg"
        case bulgaria = "br"
        case canada = "ca"
        case switzerland = "ch"
        case china = "cn"
        case colombia = "co"
        case cuba = "cu"
        case czechia = "cz"
        case germany = "de"
        case egypt = "eg"
        case france = "fr"
        case britain = "gb"
        case greece = "gr"
        case hongKong = "hk"
        case hungary = "hu"
        case indonesia = "id"
        case ireland = "ie"
        case israel = "il"
        case india = "in"
        case italy = "it"
        case japan = "jp"
        case southKorea = "kr"
        case lithuania = "lt"
        case latvia = "lv"
        case morocco = "ma"
        case mexico = "mx"
        case malaysia = "my"
        case nigeria = "ng"
        case netherlands = "nl"
        case norway = "no"
        case newZealand = "nz"
        case philippines = "ph"
        case poland = "pl"
        case portugal = "pt"
        case romania = "ro"
        case serbia = "rs"
        case russia = "ru"
        case saudiArabia = "sa"
        case sweden = "se"
        case singapore = "sg"
        case slovenia = "si"
        case slovakia = "sk"
        case togo = "th"
        case turkiye = "tr"
        case taiwan = "tw"
        case ukraine = "ua"
        case unitedStates = "us"
        case venezuela = "ve"
        case southAfrica = "za"
    }
    
    enum sortBy {
        
        // Default - publishedAt
        
        /// articles more closely related to q come first
        static let relevancy = "relevancy"
        /// articles from popular sources and publishers come first
        static let popularity = "popularity"
        /// newest articles come first
        static let publishedAt = "publishedAt"
        
    }
    
    enum Endpoint: String {
        case topHeadlines = "top-headlines"
        case everything
    }

    
    // pageSize - maximum 100
    // page - from 1
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
