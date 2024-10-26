//
//  DigitalCardViewController.swift
//  vCardApp
//
//  Created by Fuat Bolat on 26.10.2024.
//

import UIKit

class DigitalCardViewController: UIViewController {

    var userName: String?
    var userNumber: String?
    var userEmail: String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = userName
        numberLabel.text = userNumber
        emailLabel.text = userEmail
    }
}
