//
//  AddRegistrationTableViewController.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    // MARK: - UI ELEMENTS
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    // MARK: - Properties
    
    
    
    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 21/03/1996 -> .short -> 3:30 PM
        // 21/03/1996 -> .medium -> March 21, 1996
    }

    // MARK: - Functions
    func updateDateViews(){
        
    }
    
    // MARK: - Actions
    
    @IBAction func doneBarButtonTapped(_ button:UIBarButtonItem) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        
        print("Done Tapped")
        print("FirstName: \(firstName)")
        print("LastName: \(lastName)")
        print("Email: \(email)")
    }

   

}
