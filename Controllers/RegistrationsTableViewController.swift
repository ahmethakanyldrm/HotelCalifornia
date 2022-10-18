//
//  RegistrationsTableViewController.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {

    // MARK: - UI ELEMENTS
    
    
    // MARK: - PROPERTİES
    
    var registrations = [Registration]()
    
    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - FUNCTİONS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")!
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.fullName()
        let checkInDate = dateFormatter.string(from: registration.checkInDate)
        let checkOutDate = dateFormatter.string(from: registration.checkOutDate)
        let roomName = registration.roomType.name
        
        cell.detailTextLabel?.text = "\(checkInDate) - \(checkOutDate) : \(roomName)"
        
        return cell
    }
    
    // MARK: - ACTİONS
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue){
        guard let source = unwindSegue.source as? AddRegistrationTableViewController,
        let registration = source.registration else {return}
        
        registrations.append(registration)
        tableView.reloadData()
    }

    
    
    

}



