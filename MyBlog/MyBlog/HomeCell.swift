//
//  HomeCell.swift
//  MyBlog
//
//  Created by Liyao Jiang on 5/13/19.
//  Copyright © 2019 Liyao Jiang. All rights reserved.
//

import UIKit
import Parse



class HomeCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    
    var myPost: PFObject!{
        didSet{
            username.text = (myPost["author"] as! PFUser).username! as String
            caption.text = myPost["caption"] as? String
            postImage.file = myPost["media"] as? PFFileObject
            postImage.loadInBackground()
            if let pastDate = (myPost.createdAt){
                time.text = pastDate.timeDisplay()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
