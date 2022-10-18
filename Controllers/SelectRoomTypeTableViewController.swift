//
//  SelectRoomTypeTableViewController.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import UIKit

// sadece class yapıları destekleyebilir structlar destekleyemez

protocol SelectRoomTypeTableViewControllerDelegate: class {
    func didSelect(roomType:RoomType)
}

class SelectRoomTypeTableViewController: UITableViewController {
    
    // MARK: - UI ELEMENTS
    
    // MARK: - PROPERTİES
    // değişkenler hangi sınıfta tanımlandıysa aralarında strong relation kuruyor
    // yani ben memory de kaldığım süre boyunca sende memory de kalmak zorundasın
    var selectedRoomType : RoomType?
    
    // weak kuvvetli bağın önüne geçer
    // delegate bir önceki sayfanın referansı
    // weak mülakatlarda sorulur
    // neden weak kullandın
    // çünkü strong relation kurmak istemiyorum : Çünkü delegate SelectRoomTypeTableViewController tarafından tutulan bir referans değil aksine başka bir viewController ın referansı olduğu için iki controller arasında anlamsız strong ilişki kurmak istemiyorum
   weak var delegate : SelectRoomTypeTableViewControllerDelegate?
    
    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    // MARK: - FUNCTİONS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
        let roomType = RoomType.all[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "₺ \(roomType.price)"
        
        if roomType == selectedRoomType {
            // o an çizilmekte olan oda türü önceden seçilen oda türü mü ?
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: selectedRoomType!)
        tableView.reloadData()
    }
    
    // MARK: -ACTİONS
    
   // delegate design pattern -> İki view controller arasında anlık veri alışverişi yapmayı sağlar
    
}
