//
//  UserViewMode.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import Foundation
import SwiftUI

class UserViewmodel: ObservableObject{
    @Published var user: User
    
    //    @AppStorage("AUTH_KEY") var authenticated = false
    @AppStorage("AUTH_KEY") var authenticated = false {
        willSet{ objectWillChange.send() }
    }

//    @AppStorage("USER_KEY") var username = "username"
//
//    @Published var password = "password"
//    @Published var invalid: Bool? = false
    @State private var showPassword: Bool = false
    
//    private var sampleUser = "username"
//    private var samplePassword = "password"
    
    init(){
        user = User(gender: "man", name: "许智尧", login: Login(uid: "01", username: "autt", password: "123456"), email: "1932063838@qq.com", phonenumber: "18801510867", portrait: Picture(imagename: "image"), location: Location(province: "江苏", city: "无锡", district: "惠山"))
    }
        //MARK: - Intent(s)
    func login(username: String ,password: String){
        if username == "autt" && password == "123456" {
            authenticated = true
            user.validable = true
        }else{
            print(authenticated)
            print("wrong")
        }
    }
    func logOut(){
        withAnimation{
            authenticated = false
            user.validable = false
        }
        print(authenticated)
        print("logout")
    }

    func createAnAccount(){

    }

    func forgetPassword(){

    }
    
}

