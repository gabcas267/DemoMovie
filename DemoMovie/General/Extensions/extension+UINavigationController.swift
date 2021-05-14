//
//  extension+UINavigationController.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/13/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    private func showAlert(withTitle title: String, withMessage message : String, withAcceptButton accept: String, withCompletion completion : (() -> Void)?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: accept, style: UIAlertAction.Style.cancel) { (action : UIAlertAction) in
            DispatchQueue.main.async{
                completion?()
            }
        }
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        self.showAlert(withTitle: "DemoMovie", withMessage: message, withAcceptButton: "Aceptar", withCompletion: nil)
    }
    
}
