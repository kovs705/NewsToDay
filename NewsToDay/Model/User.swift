//
//  User.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

struct User {
    let id: String
    let uid: String
    let categories: [Category]?
    let region: Region?
}

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
