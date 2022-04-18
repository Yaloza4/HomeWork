//
//  ViewController.swift
//  14.3
//
//  Created by Satyavrata on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var familyLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var familyTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.familyLabel.text = UserDefault.shared.userName
        self.nameLabel.text = UserDefault.shared.userFamily
    }
    
    @IBAction func addButton(_ sender: Any) {
        UserDefault.shared.userFamily = familyTextField.text!
        UserDefault.shared.userName = nameTextField.text!
        familyLabel.text = UserDefault.shared.userFamily
        nameLabel.text = UserDefault.shared.userName
        familyTextField.text?.removeAll()
        nameTextField.text?.removeAll()
        
    }
    

}
