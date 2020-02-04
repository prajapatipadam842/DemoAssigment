//
//  UIImageView+Extension.swift
//  DemoAssignment
//
//  Created by Padam on 04/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import Foundation
import Kingfisher
extension UIImageView {
    func setImageFromURL(strURL:String){
        let url = URL(string: strURL)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
