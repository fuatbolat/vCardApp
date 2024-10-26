//
//  QRViewController.swift
//  vCardApp
//
//  Created by Fuat Bolat on 26.10.2024.
//

import UIKit

class QRViewController: UIViewController {
    @IBOutlet weak var qrView: UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageData = UserDefaults.standard.data(forKey: "qrImage") {
            let image = UIImage(data: imageData)
            qrView.image = image
        }
        
       
    }
    


}
