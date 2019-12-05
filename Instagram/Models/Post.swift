//
//  Post.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 29/11/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit


struct Post{
    var profileImage : String = ""
    var email : String = ""
    var userName : String = ""
    var imageName : String = ""
    var image : UIImage = UIImage()
    var imageCaption : String = ""
    var likes : Int = 0
    var comments : [Comment]? = nil
}

struct Comment{
    var username : String = ""
    var commentString : String = ""
}
