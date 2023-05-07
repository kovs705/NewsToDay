//
//  NewsError.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

// MARK: - LIST OF ERRORS: https://newsapi.org/docs/errors

enum NewsError: String, Error {
    case apiKeyDisabled = "Your API key has been disabled."
    case apiKeyExhausted = "Your API key has no more requests available."
    case apiKeyInvalid = "Your API key hasn't been entered correctly. Double check it and try again."
    case apiKeyMissing = "Your API key is missing from the request."
    case parameterInvalid = "You've included a parameter in your request which is currently not supported."
    case parametersMissing = "Required parameters are missing from the request and it cannot be completed."
    case rateLimited = "You have been rate limited. Back off for a while before trying the request again."
    case sourcesTooMany = "You have requested too many sources in a single request. Try splitting the request into 2 smaller requests."
    case sourceDoesNotExist = "You have requested a source which does not exist."
    case unexpectedError = "This shouldn't happen, and if it does then it's our fault, not yours. Try the request again shortly."
    
// MARK: -  My custom cases
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
