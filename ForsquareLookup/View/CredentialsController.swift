//
//  CredentialsController.swift
//  ForsquareLookup
//
//  Created by Patryk Winowski on 17/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import Foundation
import UIKit

class CredentialsController: UIViewController {
    
    @IBOutlet var UserIdTextField: UITextField!
    @IBOutlet var secretTestField: UITextField!
    
    var onSubmit: ((String, String) -> Void)?
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let user = UserIdTextField.text ?? ""
        let secret = secretTestField.text ?? ""
        dismiss(animated: true) {
            self.onSubmit?(user, secret)
        }
    }
    
}
