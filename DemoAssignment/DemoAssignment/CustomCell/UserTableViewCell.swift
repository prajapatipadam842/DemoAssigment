//
//  UserTableViewCell.swift
//  DemoAssignment
//
//  Created by Padam on 04/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import UIKit
import Kingfisher






class UserTableViewCell: UITableViewCell {
    var arrItems : [String] = []
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUserData(userObj:User){
        let imgURL = userObj.image ?? ""
        self.lblUserName.text = userObj.name ?? ""
        self.imgProfile.setImageFromURL(strURL: imgURL)
        self.arrItems = userObj.items ?? []
        self.collectionView.reloadData()
        self.updateConstraintsIfNeeded()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width/2
        
        self.collectionView.layoutIfNeeded()
        
    }
    
}


extension UserTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO:- Required Method
        return arrItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.itemImageView.setImageFromURL(strURL: self.arrItems[indexPath.row])
        configureCell(cell: cell, forItemAt: indexPath)
        
        // TODO:- Required Method
        return cell
    }
    
    func configureCell(cell: ItemCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(self.arrItems.count % 2 == 0){
            return CGSize(width: (collectionView.frame.size.width-10)/2,height: (collectionView.frame.size.width-10)/2)
        }else{
            if(indexPath.row == 0){
                return CGSize(width: (collectionView.frame.size.width),height: (collectionView.frame.size.width))
            }else{
                return CGSize(width: (collectionView.frame.size.width-10)/2,height: (collectionView.frame.size.width-10)/2)
            }
        }
    }
    
}
