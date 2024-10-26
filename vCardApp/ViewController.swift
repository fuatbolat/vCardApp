//
//  ViewController.swift
//  vCardApp
//
//  Created by Fuat Bolat on 18.10.2024.
//

import UIKit
import Photos

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    
   
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        
        let name = UserDefaults.standard.string(forKey: "userName") ?? "İsim bulunamadı"
            let number = UserDefaults.standard.string(forKey: "userNumber") ?? "Numara bulunamadı"
            let email = UserDefaults.standard.string(forKey: "userEmail") ?? "Email bulunamadı"
        nameTextField.text=name
        numberTextField.text=number
        emailTextField.text=email
        
        
    }
    //when the perform seque
    override func viewDidDisappear(_ animated: Bool) {
        nameTextField.text = ""
        numberTextField.text = ""
        emailTextField.text = ""
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary // Fotoğraf kütüphanesinden seçim yapacağız.
                imagePicker.allowsEditing = false // Kullanıcının resmi düzenlemesine izin veriyoruz (isteğe bağlı)
                
                present(imagePicker, animated: true, completion: nil)
           
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.originalImage] as? UIImage {
               imageView.image = selectedImage // Seçilen resmi imageView'da gösteriyoruz
           }
           picker.dismiss(animated: true, completion: nil) // Picker'ı kapat
       }
       
       // Kullanıcı resmi seçmeyi iptal ederse
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil) // Picker'ı kapat
       }
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
               let name = nameTextField.text ?? ""
               let number = numberTextField.text ?? ""
               let email = emailTextField.text ?? ""
     
               
               if let image = imageView.image, let imageData = image.jpegData(compressionQuality: 0.8) {
                   UserDefaults.standard.set(imageData, forKey: "userPhoto")
               }
        else{print("noprofilephotoselected")}

               
               UserDefaults.standard.set(name, forKey: "userName")
               UserDefaults.standard.set(number, forKey: "userNumber")
               UserDefaults.standard.set(email, forKey: "userEmail")
       
        
        performSegue(withIdentifier: "goToSecondViewController", sender: self)
        
        
           
    }
    
   
   

    
}


