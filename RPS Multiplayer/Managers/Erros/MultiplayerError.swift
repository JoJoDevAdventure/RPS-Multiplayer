//
//  MultiplayerError.swift
//  RPS Multiplayer
//
//  Created by Youssef Bhl on 19/01/2023.
//

import Foundation

enum MultiplayerErrors: CaseIterable, Error {
    
    case RPSConnectionError
    case RPSLostConnection
    case RPSFetchingDataError
    case RPSConnectingToServerError
    case RPSUnkownError
    
    // Error displayer title
    var title: String {
        switch self {
        case .RPSConnectionError:
            return "Check you internet connection."
        case .RPSLostConnection:
            return "Connection to the server lost."
        case .RPSFetchingDataError:
            return "Error while fetching the data."
        case .RPSConnectingToServerError:
            return "Error while connecting to the server."
        case .RPSUnkownError:
            return "Unknown error."
        }
    }
    
    // Error Description
    var errorDescription: String {
        switch self {
        case .RPSConnectionError:
            return "Connection error, please check you WI-FI or cellular."
        case .RPSLostConnection:
            return "Connection with the server lost, try again later."
        case .RPSFetchingDataError:
            return "We couldn't obtain your informations, please try again later."
        case .RPSConnectingToServerError:
            return "We couldn't connect you to the server, consider trying in few minutes."
        case .RPSUnkownError:
            return "Unknown error, please try again."
        }
    }
    
}
