//
//  User.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import Foundation
import SwiftUI

struct User{
    var validable:Bool = false
    var gender: String
    var name: String
    var login: Login
    var email: String
    var phonenumber: String
    var portrait: Picture
    var location: Location
    
    
    
    init(gender: String, name: String, login: Login, email: String, phonenumber: String, portrait: Picture, location: Location) {
        self.gender = gender
        self.name = name
        self.login = login
        self.email = email
        self.phonenumber = phonenumber
        self.portrait = portrait
        self.location = location
    }
    
}
struct Login{
    var uid: String
    @AppStorage("USER_KEY") var username = "username"
    var password = "password"
    
    init(uid: String, username: String, password: String) {
        self.uid = uid
        self.username = username
        self.password = password
    }
}
struct Picture{
    //pick from the phone
    var imagename: String
    
    init(imagename: String) {
        self.imagename = imagename
    }
}

struct Location{
    var province: String
    var city: String
    var district: String
 
    init(province: String, city: String, district: String) {
        self.province = province
        self.city = city
        self.district = district
    }

}
