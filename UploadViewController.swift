//
//  UploadViewController.swift
//  BasicInstaClone
//
//  Created by Ali Ayçiçek on 13.07.2024.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
class UploadViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentTextBar: UITextField!
    
    
    @IBOutlet weak var uploadButton1: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true , completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // ALLERT FUNC
    
    func makeAlert(titleInput: String, massageInput: String ) {
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel )
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
        
    @IBAction func uploadButton(_ sender: Any) {
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data,metadata: nil) { metadata, error in
                if error  != nil {
                    self.makeAlert(titleInput: "Error!", massageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                           
                            
                            
                            // DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReferance : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentTextBar.text!, "date" : "date" , "likes" : 0 ]           as [String : Any]
                            
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: {
                                (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", massageInput: error?.localizedDescription ?? "Error")
                                }
                        })
                    }
                }
            }
        }
        
        
        
    }
    
    
    
}
                            }
