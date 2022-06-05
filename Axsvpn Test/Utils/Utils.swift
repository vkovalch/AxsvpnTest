//
//  Utils.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 04.06.2022.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case main = "Main"
}

enum ControllerName: String {
    case program = "programVC"
    case programDetail = "programDetailVC"
    case map = "mapVC"
}

struct Utils {
    
    static func getViewController(_ storyBoard: String, _ id: String) -> UIViewController {
        return UIStoryboard(name: storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: id)
    }
    
    static func getViewController(_ storyBoard: StoryboardName, _ id: ControllerName) -> UIViewController {
        return UIStoryboard(name: storyBoard.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: id.rawValue)
    }
    
}
