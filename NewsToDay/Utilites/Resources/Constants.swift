//
//  Constants.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

enum Keys {
    static let bookmarks = "bookmarks"
    static let onboarding = "onboarding"
    static let categories = "categories"
}

enum Colors: String {
    // Purple
    case purpleDark = "PurpleDark"
    case purpleLight = "PurpleLight"
    case purpleLighter = "PurpleLighter"
    case purplePrimary = "PurplePrimary"
    
    // Black
    case blackDark = "BlackDark"
    case blackLight = "BlackLight"
    case blackLighter = "BlackLighter"
    case blackPrimary = "BlackPrimary"
    
    // Grey
    case greyDark = "GreyDark"
    case greyLight = "GreyLight"
    case greyLighter = "GreyLighter"
    case greyPrimary = "GreyPrimary"
    case white = "White"
}

enum Categories {
    static let business = NSLocalizedString("CONSTANS_CATEGORIES_BISNESS", comment: "business")
    static let entertainment = NSLocalizedString("CONSTANS_CATEGORIES_ENTERTAINMENT", comment: "entertainment")
    static let general = NSLocalizedString("CONSTANS_CATEGORIES_GENERAL", comment: "general")
    static let health = NSLocalizedString("CONSTANS_CATEGORIES_HEALTH", comment: "health")
    static let science = NSLocalizedString("CONSTANS_CATEGORIES_SCIENCE", comment: "science")
    static let sports = NSLocalizedString("CONSTANS_CATEGORIES_SPORT", comment: "sport")
    static let technology = NSLocalizedString("CONSTANS_CATEGORIES_TECHNOLOGY", comment: "techlogy")
}

enum Web {
    enum Region: String, Codable {
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

    enum APIKey: String {
        case get = "8e4cb38d557a45798ecdfa5b7c61f16e"
    }
    
//    ## 8e4cb38d557a45798ecdfa5b7c61f16e
//    ## 698b732aca97446d853e299ac52ffed1
    // pageSize - maximum 100
    // page - from 1
}

enum Font: String {
    case interSemiBold = "Inter-SemiBold"
    case interRegular = "Inter-Regular"
    case interMedium = "Inter-Medium"
    case interBold = "Inter-Bold"
}

enum Constants {
    enum String {
        static let ok = NSLocalizedString("ALERT_OK", comment: "")
        static let eight = 8
        static let name = NSLocalizedString("AUTHORIZATION_VIEW_NAME", comment: "")
        static let signIn = NSLocalizedString("AUTHORIZATION_VC_FALSE_SIGNIN_BUTTON", comment: "")
        static let signUp = NSLocalizedString("AUTHORIZATION_VC_TRUE_SIGNIN_BUTTON", comment: "")
        static let info = NSLocalizedString("AUTHORIZATION_VIEW_INFORMATION", comment: "")
        static let password = NSLocalizedString("AUTHORIZATION_VIEW_PASSWORD_TEXTFIELD", comment: "")
        static let email = NSLocalizedString("AUTHORIZATION_VIEW_EMAIL_TEXTFIELD", comment: "")
        static let repeatPas = NSLocalizedString("AUTHORIZATION_VIEW_CONFIRM_PASSWORD_TEXTFIELD", comment: "")
        static let welcome = NSLocalizedString("AUTHORIZATION_VC_FALSE_TOP_LABEL", comment: "")
        static let google = NSLocalizedString("AUTHORIZATION_VIEW_THROUGH_GOOGLE", comment: "")
        static let errorPassword = NSLocalizedString("ALERT_ERROR_PASSWORD", comment: "")
        static let welcomeToNews = NSLocalizedString("AUTHORIZATION_VC_TRUE_TOP_LABEL", comment: "")
        static let dontAc = NSLocalizedString("AUTHORIZATION_VC_FALSE_CREATE_ACCOUNT_LABEL", comment: "")
        static let haveAnAcc = NSLocalizedString("AUTHORIZATION_VC_TRUE_CREATE_ACCOUNT_LABEL", comment: "")
        static let hello = NSLocalizedString("AUTHORIZATION_VC_TRUE_GREETING_LABEL", comment: "")
        static let iAm = NSLocalizedString("AUTHORIZATION_VC_FALSE_GREETING_LABEL", comment: "")
    }
    
    enum Images {
        static let envelope = "envelope"
        static let lock = "lock"
        static let person = "person"
        static let eye = "eye"
        static let google = "google"
    }
}

enum Onboarding {
    enum Image {
        case home
        case categories
        case bookmarks
        
        var getImage: UIImage {
            switch self {
            case .home:
                return UIImage(named: "homeOnboarding")!
            case .categories:
                return UIImage(named: "categoriesOnboarding")!
            case .bookmarks:
                return UIImage(named: "bookmarksOnboarding")!
            }
        }
    }
    
    enum Description {
        case home
        case categories
        case bookmarks
        
        var getTitle: String {
            switch self {
            case .home:
                return NSLocalizedString("CONSTANS_DESCRIPRION_HOME", comment: "On the main screen you can see the latest events and recommended news for you.")
            case .categories:
                return NSLocalizedString("CONSTANS_DESCRIPRION_CATEGORIES", comment: "On the category screen you can see the latest news for the selected category")
            case .bookmarks:
                return NSLocalizedString("CONSTANS_DESCRIPRION_BOOKMARKS", comment: "You can also save the news you like and it will remain in your bookmarks.")
            }
        }
    }
    
    enum Title {
        case home
        case categories
        case bookmarks
        
        var getTitle: String {
            switch self {
            case .home:
                return "Home screen"
            case .categories:
                return "Categories"
            case .bookmarks:
                return "Bookmarks"
            }
        }
    }
}
