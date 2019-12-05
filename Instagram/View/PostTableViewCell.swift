//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 26/11/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImage.makeRound(borderWidth: 0, size: 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
}

extension UIImageView{
    func makeRound(borderWidth :CGFloat, size : CGFloat){
        self.frame.size.height = size
        self.frame.size.width = size
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }
}
