//
//  Registration.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import Foundation

struct Registration {
    
    // MARK: - Properties
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren:Int
    
    var roomType: RoomType
    var wifi: Bool
}
