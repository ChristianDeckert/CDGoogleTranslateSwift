//
//  ViewController.swift
//  CDGoogleTranslateSwift
//
//  Created by Christian on 23.04.18.
//  Copyright © 2018 cda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonAction() {
        guard let text = textField.text, !text.isEmpty else { return }
        
        GTService.shared.translate(text: text, to: .en) { result, error in
            let translation = result?.translation
            //let detectedLanguage = result?.detectedLanguage
            self.label.text = error?.localizedDescription ?? translation
        }
        
    }


}

