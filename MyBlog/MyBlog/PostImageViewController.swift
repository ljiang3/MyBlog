//
//  PostImageViewController.swift
//  MyBlog
//
//  Created by Liyao Jiang on 5/13/19.
//  Copyright © 2019 Liyao Jiang. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController {

    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
    var post : PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MMM-dd"
            let myString = formatter.string(from: post.createdAt!)
            postTime.text = myString
            
            caption.text = post["caption"] as! String?
            postImage.file = post["media"] as? PFFileObject
            postImage.loadInBackground()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
