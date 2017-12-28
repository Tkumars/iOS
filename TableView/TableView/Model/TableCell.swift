//
//  TableCell.swift
//  Swift-TableView-Example
//
//
//  Created by Mahi Velu on 12/26/2017.
//

import Foundation
import UIKit


class TableCell : UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTimeLabel: UILabel?
    @IBOutlet var userLabel: UILabel?
    @IBOutlet var thumbnailImageView: UIImageView?
    
    
    // MARK: Cell Configuration
    func configurateTheCell(_ recipe: Mobile) {
        self.nameLabel?.text = recipe.mobileType
        self.prepTimeLabel?.text = "" + recipe.IMEI
        self.userLabel?.text = recipe.userName
        if recipe.mobileType == "Android" {
        self.thumbnailImageView?.image = UIImage(named: "android.png")
        }
        else
        {
        self.thumbnailImageView?.image = UIImage(named: "apple.png")
        }
    }
}
