//
//  SideBarViewController.swift
//  Women4Women
//
//  Created by Leslie Kurt on 5/17/17.
//  Copyright © 2017 cs194w. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.getFirstName()+" "+UserDefaults.getLastName()
        //logoutButton.
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutUser(_ sender: Any) {
        //UserDefaults.setLoggedIn(on: false);
        
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            UserDefaults.setLoggedIn(on: false);
            self.performSegue(withIdentifier: "logoutSegue", sender: self);
            
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        present(logoutAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
