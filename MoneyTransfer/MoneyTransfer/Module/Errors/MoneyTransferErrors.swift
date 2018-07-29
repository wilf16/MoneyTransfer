//
//  MoneyTransferErrors.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 28/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

enum MoneyTransferError : Error {
    case noSender
    case noReceiver
    case noAmount
    
    var description: String {
        switch self {
        case .noSender:
            return "Please select an Account"
        case .noReceiver:
            return "Please select a Recipient"
        case .noAmount:
            return "Please input an amount"
        }
    }
}
enum MoneyTransferConversionError : Error {
    case failedSenderStringConversion
    case failedReceiverStringConversion
    case failedAmountStringConversion
    
    var description: String {
        switch self {
        case .failedSenderStringConversion:
            return "Failed processing sender"
        case .failedReceiverStringConversion:
            return "Failed processing recipient"
        case .failedAmountStringConversion:
            return "Failed processing amount"
        }
    }
}
enum MoneyTransferAPIError : Error {
    case invalidURL
    case invalidData
    case failedParsingJSON
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data Received"
        case .failedParsingJSON:
            return "Failed processing data"
        }
    }
}
enum MoneyTranserReportError : Error {
    case failedCreatingReport(reason:String)
    
    var description: String {
        switch self {
        case .failedCreatingReport(reason: let reason):
            return reason
        }
    }
}
