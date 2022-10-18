//
//  AddRegistrationTableViewController.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate{


    // MARK: - UI ELEMENTS
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch : UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    
    
    
    // MARK: - Properties
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2
                                                   , section: 1)
    
    var isCheckInDatePickerShow : Bool = false {
        
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShow
        }
    }
    var isCheckOutDatePickerShow : Bool = false {
        
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShow
        }
    }
    
    var roomType: RoomType?
    
    var registration : Registration?  {
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
        
    }
    
    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CheckIn tarihini bugünün gecesi olarak ayarlar
        // NOT: Date() -> O anın tarihini verir. (Saat Bilgisi dahil)
        let midnightToday = Calendar.current.startOfDay(for: Date())
        
        // seçilebilecek en küçük tarihi ayarlar
        checkInDatePicker.minimumDate = midnightToday
        
        // seçili olan tarihi ayarlar
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        
        updateNumberOfGuests()
        
        updateRoomType()
    }

    // MARK: - Functions
    func updateDateViews(){
        // 21/03/1996 -> .short -> 3:30 PM
        // 21/03/1996 -> .medium -> March 21, 1996
        
        // Otelde minimum 1 gce konaklama yapılması gerekir
        // checkoutDatePicker'ın minimumDate i o an seçilir olan checkin tarihinden 24 saat sonrası olarak ayarlanmalıdır
        
        // addingTimeInterval: Var olan bir date nesnesinin üzerine belirtilen miktarda saniye ekler
        let oneDay:Double  = 24 * 60 * 60 // 24 saatin saniye karşılığı
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    func updateNumberOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
            
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShow{
                return 155
            }else {
                return 0
            }
            
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShow{
                return 155
            }else {
                return 0
            }
        default:
            return 44
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // seçili olan hücrenin seçili olma durumunu sonlandırır
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShow {
                isCheckInDatePickerShow = false
            } else if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
                isCheckInDatePickerShow = true
            }else {
                isCheckInDatePickerShow = true
            }
            
            // değişkenlerdeki değişim ile heightForRow fonksiyonu tekrardan çalıştırılır. Fakat yükseklik değişimleri animasyon ile sağlanır
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
            } else if isCheckInDatePickerShow {
                isCheckOutDatePickerShow = true
                isCheckInDatePickerShow = false
            }else {
                isCheckOutDatePickerShow = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func updateRoomType () {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoomType" {
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoomType = roomType
        }
    }
    
    // MARK: - Actions
    


    @IBAction func datePickerValueChanged(_ picker: UIDatePicker) {
        updateDateViews()
    }
   
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func cancelBarButtonTapped (_ button: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
