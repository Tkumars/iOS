//
//  MobileTableViewController.swift
//  Swift-TableView-Example
//
//  Created by Mahi Velu on 12/26/2017.
//


import UIKit


struct Mobile {
    let mobileType: String
    let IMEI: String
    let mobileName: String
    let userName: String
    let available: String
    let assigneddate: String
}

class RecipesTableViewController: UITableViewController {
    var mobile = [Mobile]()
    let identifier: String = "tableCell"
    var sql: String = ""
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "Mobile Log"
        sql = "SELECT mobileType,imei,mobilename,username,available,userassigneddate  FROM MobileLog";
        refreshtable()
        
        
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            sql = "SELECT mobileType,imei,mobilename,username,available,userassigneddate  FROM MobileLog";
            refreshtable()
        case 1:
            sql = "SELECT mobileType,imei,mobilename,username,available,userassigneddate  FROM MobileLog where available = 'N'";
            refreshtable()
        case 2:
             sql = "SELECT mobileType,imei,mobilename,username,available,userassigneddate  FROM MobileLog where available = 'Y'";
            refreshtable()
        default:
            break
        }
    }
    
    func refreshtable() {
        
        mobile.removeAll()
        
        
        
        LocalDatabase.sharedInstance.methodToSelectData(sql, completion: { (dataReturned) in
            
            
            for dbdata in dataReturned {
                var available = "N"
                var IMEI = ""
                var MobileName = ""
                var MobileType = ""
                var UserAssignedDate = "Assigned Date : None"
                var UserName = "Assigned User : None"
                if let jsonDict = dbdata as? NSDictionary {
                    if let vavailable = jsonDict["Available"] as? String {
                        available = vavailable
                    }
                    if let vIMEI = jsonDict["IMEI"] as? String {
                        IMEI = vIMEI
                    }
                    if let vMobileName = jsonDict["MobileName"] as? String {
                        MobileName = vMobileName
                    }
                    if let vMobileType = jsonDict["MobileType"] as? String {
                        MobileType = vMobileType
                    }
                    if let vUserAssignedDate = jsonDict["UserAssignedDate"] as? String {
                        UserAssignedDate = "Assigned Date : "+vUserAssignedDate
                    }
                    if let vUserName = jsonDict["UserName"] as? String {
                        UserName = "Assigned User : "+vUserName
                    }
                    if IMEI != "" {
                    self.mobile.append(Mobile(mobileType: MobileType,IMEI: IMEI,mobileName: MobileName,userName: UserName,available: available,assigneddate: UserAssignedDate))
                    }
                }
                
                print("In Loop......");
                
            }
            
            
            
            
        })
        
        
        self.tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        refreshtable()
        print("view called.......")
    }

    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableCell
        cell.configurateTheCell(mobile[indexPath.row])
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count :"+String(mobile.count))
        return mobile.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            mobile.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: DetailViewController = segue.destination as! DetailViewController
            destinationViewController.recipe = mobile[indexPath!.row]
        }
    }
}
