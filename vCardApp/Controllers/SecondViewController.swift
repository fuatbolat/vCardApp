//
//  SecondViewController.swift
//  vCardApp
//
//  Created by Fuat Bolat on 25.10.2024.
//
import UIKit
import CoreImage

class SecondViewController: UIViewController {
    
  
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var qrImage: UIImage?
    
    let name = UserDefaults.standard.string(forKey: "userName") ?? "İsim bulunamadı"
    let number = UserDefaults.standard.string(forKey: "userNumber") ?? "Numara bulunamadı"
    let email = UserDefaults.standard.string(forKey: "userEmail") ?? "Email bulunamadı"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        if let imageData = UserDefaults.standard.data(forKey: "userPhoto"){
            let image = UIImage(data: imageData)
            secondImageView.image = image
        }
        nameLabel.text=name
        emailLabel.text=email
        phoneNumberLabel.text=number
        
        
    }
    
    @IBAction func qrButtonPressed(_ sender: Any) {
       
       /* let name = UserDefaults.standard.string(forKey: "userName") ?? "İsim bulunamadı"
        let number = UserDefaults.standard.string(forKey: "userNumber") ?? "Numara bulunamadı"
        let email = UserDefaults.standard.string(forKey: "userEmail") ?? "Email bulunamadı"
        */
        if nameLabel.text!.isEmpty || emailLabel.text!.isEmpty || phoneNumberLabel.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Missing user information", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        
        // QR kodunu oluştur ve qrImageview'a ata
        let qrData = """
        BEGIN:VCARD
        VERSION:3.0
        FN:\(name)
        TEL:\(number)
        EMAIL:\(email)
        END:VCARD
        """
        // QR kodu
        func generateQRCode(from string: String) -> UIImage? {
            let data = string.data(using: .utf8)
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                filter.setValue("M", forKey: "inputCorrectionLevel")
                
                if let output = filter.outputImage {
                    let transformed = output.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
                    return UIImage(ciImage: transformed)
                }
            }
            return nil
        }
        
        
        if let  qrImage = generateQRCode(from: qrData){
            if let qrImageData = qrImage.pngData() {
                           UserDefaults.standard.set(qrImageData, forKey: "qrImage")
                       }
                       performSegue(withIdentifier: "showQRCodeSegue", sender: self)
        }else{print("errorqrcodeshow")}
        
        
                
                 
                
        
       
        
    }
}
