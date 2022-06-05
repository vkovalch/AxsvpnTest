//
//  MediaLayer.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import Foundation
import Alamofire

protocol MediaLayerDelegate {
    func getMediaLibrary(_ callback: @escaping MediaResponseCallback)
}

extension API: MediaLayerDelegate {
    
    func getMediaLibrary(_ callback: @escaping MediaResponseCallback) {
        
        let url = "\(baseUrl)/media-library/free?resetCache=false"
        
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let code = response.response?.statusCode
                    switch code {

                    case 200:
                        guard let data = response.data else {
                            callback(nil, ErrorModel("No data") )
                            return
                        }
                        do {
                            let mrd = try JSONDecoder().decode(MediaResponse.self, from: data)
                            callback(mrd, nil)
                        } catch {
                            callback(nil, ErrorModel("Error due parse response") )
                        }
                    default:
                        callback(nil, ErrorModel("Unknown code  response") )
                    }
                case .failure(let err):
                    callback(nil, ErrorModel(err.localizedDescription))
                }
            }
    }
    
}
