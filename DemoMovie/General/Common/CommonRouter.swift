//
//  CommonRouter.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/13/21.
//

import Foundation
import UIKit

protocol CommonRouterProtocol {
    
    var navigation: UINavigationController { get set }
    
    func showAlertView(withMessage message: String)
    
}


extension CommonRouterProtocol {
    
    func showAlertView(withMessage message: String) {
        self.navigation.showAlert(message: message)
    }
    
}
