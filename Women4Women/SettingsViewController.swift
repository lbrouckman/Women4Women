//
//  SettingsViewController.swift
//  Women4Women
//
//  Created by Leslie Kurt on 5/10/17.
//  Copyright © 2017 cs194w. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var firstNameButton: UIButton!
    @IBOutlet weak var lastNameButton: UIButton!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var homeAddressLabel: UILabel!
    @IBOutlet weak var homeAddressButton: UIButton!
    @IBOutlet weak var homeAddressLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = "Leslie"
        firstNameButton.layer.borderWidth = 1
        firstNameButton.layer.borderColor = UIColor.lightGray.cgColor
        
        lastNameLabel.text = "Kurt"
        lastNameButton.layer.borderWidth = 1
        lastNameButton.layer.borderColor = UIColor.lightGray.cgColor
        
        phoneNumberLabel.text = "3109779751"
        phoneNumberButton.layer.borderWidth = 1
        phoneNumberButton.layer.borderColor = UIColor.lightGray.cgColor
        
        homeAddressLabel.text = "3226 Dianora Drive"
        homeAddressLabel2.text = "Rancho Palos Verdes, CA"
        homeAddressButton.layer.borderWidth = 1
        homeAddressButton.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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