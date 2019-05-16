//
//  HomeViewController.swift
//  MyBlog
//
//  Created by Liyao Jiang on 5/13/19.
//  Copyright © 2019 Liyao Jiang. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var posts: [PFObject] = []
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = 420
        tableView.dataSource = self
        tableView.delegate = self
        fetchPost()
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logoutAction(_ sender: Any) {
        // set user is logout
        PFUser.logOut()
        print("Loged out Success!")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
    }
    
    
    @IBAction func newPictureAction(_ sender: Any) {
        let newPostPage = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController")
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = newPostPage
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        cell.myPost = posts[indexPath.row]
        return cell
    }
    
    func fetchPost(){
        let query = PostImage.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let posts = posts {
                self.posts = posts
                
            }
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl){
        fetchPost()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let postImageViewController = segue.destination as! PostImageViewController
            postImageViewController.post = post
        }
        
    }
    
    

    

}
