//
//  ChatViewController.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 28/11/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var igPosts : [Post] = []
    let db = Firestore.firestore()
    var username = ""
    var email = ""
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        title = Constant.appName
        navigationItem.hidesBackButton = true
        
        //Registering a custom table view cell
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil),
                           forCellReuseIdentifier: Constant.cellIdentifier)
        addButton.roundBorder(borderWidth: 1, borderColor : UIColor.blue.cgColor)
        addButton.titleEdgeInsets =  UIEdgeInsets.init(top: 10,left: 10,bottom: 10,right: 10)
        getUserDetails()
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func loadPosts(){
        db.collection(Constant.FStore.collectionName)
            .order(by: Constant.objectModel.timeStamp)
            .whereField(Constant.objectModel.username, isEqualTo: self.username)
            .addSnapshotListener{(querySnapShot, error) in
            self.igPosts = []
            if let e = error{
                print(e)
            }else{
                var igPost = Post()
                
                if let snapShotDocuments = querySnapShot?.documents{
                    print("Count of documents is \(snapShotDocuments.count)")
                    for doc in snapShotDocuments{
                        let data = doc.data()
                        print("loadPosts(): Loading post")
                        //igPost.email = data[Constant.objectModel.email] as! String
                        igPost.userName = data[Constant.objectModel.username] as! String
                        igPost.imageCaption = data[Constant.objectModel.caption] as! String
                        igPost.likes = data[Constant.objectModel.likes] as! Int
                        self.igPosts.append(igPost)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    func getUserDetails(){
        self.email = Auth.auth().currentUser?.email ?? "none"
        
        db.collection(Constant.FStore.userDetails).whereField(Constant.objectModel.email, isEqualTo: self.email).getDocuments { (querySnapShot, error) in
            if error != nil{
                print(error)
            }
            else{
                if let snapShotDocuments = querySnapShot{
                    let data = snapShotDocuments.documents[0]
                    self.username = data[Constant.objectModel.username] as! String
                    
                    DispatchQueue.main.async {
                        self.loadPosts()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postViewController = segue.destination as? PostViewController{
            if self.username == "" {
                getUserDetails()
            }
            postViewController.username = self.username
        }
    }
    
}


//MARK: - TableView Section

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return igPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath)
            as!  PostTableViewCell
        print("Row is \(indexPath.row)")
        
        cell.userName.text = igPosts[indexPath.row].userName
        cell.postCaption.text = igPosts[indexPath.row].imageCaption
        
        
        return cell
    }
    
}

extension ChatViewController : UITableViewDelegate{
    
}
