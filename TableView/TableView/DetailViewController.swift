//
//  DetailViewController.swift
//  Swift-TableView-Example
//
//
//  Created by Mahi Velu on 12/26/2017.
//

import Foundation
import UIKit

class DetailViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTime: UILabel?
    @IBOutlet var user: UILabel?
    @IBOutlet var date: UILabel?
    
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func AssignUser(sender: UIButton) {
        print("val"+myLabel.text!)
        if (myLabel.text == " Choose User ") {
        print("val"+myLabel.text!)
        let alert = UIAlertController(title: "Alert", message: "Choose User to Assign", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        else {
        
        let sql = "Update MobileLog set Username='"+myLabel.text!+"',userassigneddate=current_date , available='N' where IMEI ='"+recipe!.IMEI+"'"
        
        LocalDatabase.sharedInstance.methodToInsertUpdateDeleteData(sql, completion: { (completed) in
            if completed
            {
                print("Data updated successfully")
            }
            else
            {
                print("Fail while data updation")
            }
        })
            user?.text = "Assigned User: "+myLabel.text!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
    
            date?.text = "Assigned Date: "+formatter.string(from: Date())
            
            
            let alert = UIAlertController(title: "Alert", message: "User Assigned Successfully", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
           }
    @IBAction func ReturnDevice(sender: UIButton) {
        let sql = "Update MobileLog set Username=null,userassigneddate=null,available='Y' where IMEI ='"+recipe!.IMEI + "'"
        
        LocalDatabase.sharedInstance.methodToInsertUpdateDeleteData(sql, completion: { (completed) in
            if completed
            {
                print("Data updated successfully")
            }
            else
            {
                print("Fail while data updation")
            }
        })
        
        user?.text = "Assigned User: None"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        date?.text = "Assigned Date: None"
        
        
        let alert = UIAlertController(title: "Alert", message: "Device Returned Successfully", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    let pickerData = ["Mahi","Kumar","Vidhyuth","Harish","Mano","Charan","Vishnu"]
    
    var recipe: Mobile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPicker.dataSource = self
        myPicker.delegate = self
        
        navigationItem.title = recipe?.mobileType
        //imageView?.image = UIImage(named: recipe!.thumbnails)
        nameLabel?.text = recipe!.mobileName
        prepTime?.text = "" + recipe!.IMEI
        user?.text = recipe!.userName
        date?.text = recipe!.assigneddate
        
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = " "+pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    

}


