//
//  ViewController.swift
//  DemoAssignment
//
//  Created by Padam on 04/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class ViewController: UIViewController {
    var position = 1;
    var limit = 10;
    var refreshControl = UIRefreshControl()
    var isLoading:Bool = false
    var offSet:Int = 0
    @IBOutlet weak var tblView: UITableView!
    var userList : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.getPost(offset: position, limit: limit)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.tblView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    
    func getPost(offset:Int,limit:Int) {
        SVProgressHUD.show()
        let url = "http://sd2-hiring.herokuapp.com/api/users?offset=\(position)&limit=\(limit)"
        Alamofire.request(url).responseJSON { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.isLoading = false
                let result = response.result.value as? [String:Any];
                let dictData = result?["data"] as? [String:Any]
                let arrUsers = dictData?["users"] as? [[String:Any]] ?? []
                self.userList = Mapper<User>().mapArray(JSONArray: arrUsers);
                self.tblView.reloadData()
            }
        }
    }

    
    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        self.getPost(offset: position, limit: limit)
    }
}


extension ViewController : UITableViewDataSource,UITableViewDelegate{
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setUserData(userObj: self.userList[indexPath.row])
        configureCell(cell: cell, forRowAt: indexPath)
        //cell.collectionView.backgroundColor = .blue
        return cell
    }
    
    func configureCell(cell: UserTableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let userObj = self.userList[indexPath.row]
        let arrItems = userObj.items ?? []
        let collectionViewHeight = CGFloat(394.0);
        if(arrItems.count % 2 != 0){
          var tableHeight = ((collectionViewHeight/2) * CGFloat(arrItems.count/2))
          tableHeight = tableHeight + collectionViewHeight
          return tableHeight + 80;
        }else{
            let tableHeight = ((collectionViewHeight/2) * CGFloat(arrItems.count/2))
            return tableHeight + 80;
       }
        
       
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((self.tblView.contentOffset.y + self.tblView.frame.size.height) >= self.tblView.contentSize.height)
            {
                if !isLoading{
                    isLoading = true
                    self.position=self.position+1
                    self.limit=self.limit+10
                    self.offSet = self.limit * self.position
                    getPost(offset: self.offSet, limit: self.limit)

                }
            }
    }
}

