//
//  ErrorModel.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import Foundation


//MARK: - ErrorModel
struct ErrorModel: Error {
    let error: String?
    let message: String?
    
    init() {
        error = nil
        message = nil
    }
    
    init(error: String, message: String) {
        self.error = error
        self.message = message
    }
    
    init(_ message: String) {
        self.error = nil
        self.message = message
    }
}
