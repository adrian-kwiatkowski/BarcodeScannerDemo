//
//  ResultsViewController.swift
//  BarcodeScannerDemo
//
//  Created by Adrian Kwiatkowski on 08/01/2019.
//  Copyright © 2019 Adrian Kwiatkowski. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var codeLabel: UILabel! {
        didSet {
            codeLabel.text = codeToDisplay
        }
    }
    
    var codeToDisplay = ""
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
