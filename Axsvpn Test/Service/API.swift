//
//  API.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import Foundation

typealias MediaResponseCallback = (MediaResponse?, Error?) -> Void

class API {
    
    static var shared = API()
    
    let baseUrl: String = "https://api.iawaketechnologies.com/api/v2"
    
}
