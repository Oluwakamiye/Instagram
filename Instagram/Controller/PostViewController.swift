//
//  PostViewController.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 03/12/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    let db = Firestore.firestore()
    var post = Post()
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        postButton.isEnabled = false
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        if let image = imageView.image, let senderMail = Auth.auth().currentUser?.email{
            post.image = image
            post.email = senderMail
            post.userName = self.username
            post.imageCaption = "\(post.userName): \(textField.text ?? "")"
            post.likes = 0
            db.collection(Constant.FStore.collectionName).addDocument(data: [Constant.objectModel.post: "An image was posted here",
                                                                             Constant.objectModel.caption: post.imageCaption,
                                                                             Constant.objectModel.likes: post.likes,
                                                                             Constant.objectModel.username: post.userName,
                                                                             Constant.objectModel.email: post.email,
                                                                             Constant.objectModel.timeStamp: Date().timeIntervalSince1970                                     
            ]) { (error) in
                if error != nil{
                    print("error is \(error)")
                }
                else{
                    print("Adding post to db successful")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
        }
    }
}

//MARK: - Creating a post
extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBAction func AddImagePressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = selectedImage
            postButton.isEnabled = true
        }else{
            print("Nothing")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
