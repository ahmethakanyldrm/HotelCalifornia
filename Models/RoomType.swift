//
//  RoomType.swift
//  HotelCalifornia
//
//  Created by AHMET HAKAN YILDIRIM on 17.10.2022.
//

import Foundation

struct RoomType : Equatable{
    // MARK: - Properties
    var id:Int
    var price: Int
    
    var name: String
    var shortName: String

    // MARK: - Functions
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id 
    }
}
