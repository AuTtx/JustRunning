//
//  UserViewMode.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//

import Foundation
import SwiftUI
import CoreData

class UserViewmodel: ObservableObject{
    @AppStorage("AUTH_KEY") var authenticated = false {
        willSet{ objectWillChange.send() }
    }
    @AppStorage("AUTH_USERNAME") var authUserName = "" {
        willSet{ objectWillChange.send() }
    }
    @Published var isValidable: Bool? = nil
    //    var username: String = ""
    //    var password: String = ""
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var phoneNubmer: String = ""
    @State private var showPassword: Bool = false
    
    let manager = CoreDataManager.instance
    @Published var users: [UserEntity] = []
    @Published var currentUser: UserEntity
    
    init(){
        currentUser = UserEntity(context: manager.context)
        currentUser.username = ""
        currentUser.password = ""
        getUsers()
        currentUser = enableCurrentUser()
    }
    
    func getUsers(){
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        do{
            users = try manager.context.fetch(request)
            print("成功更新users")
        }catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func editUserInCoredata(){
        currentUser.name = name
        currentUser.gender = gender
        currentUser.email = email
        currentUser.phoneNumber = phoneNubmer
        currentUser.location = location
    }
    
    func editUserInCoredata(name: String, gender: String, email: String, phoneNumber: String, location: String){
        currentUser.name = name
        currentUser.gender = gender
        currentUser.email = email
        currentUser.phoneNumber = phoneNumber
        currentUser.location = location
        
        self.name = name
        self.gender = gender
        self.email = email
        self.phoneNubmer = phoneNumber
        self.location = location
        save()
    }
    
    
    
    func enableCurrentUser() -> UserEntity{
        if let fetchCurrentUser = getSpecifiedUser(with: authUserName, users: users){
            return fetchCurrentUser
        }else{
            print("更新currentUser失败")
            return currentUser
        }
    }
    
    func addUserInCoreData(username: String, password: String, users: [UserEntity]){
        //查找有没有重复的
        if let account = getSpecifiedUser(with: username, users: users){
            print("该账号已存在")
        }else{
            var newUser = UserEntity(context: manager.context)
            newUser.id = UUID()
            newUser.username = username
            newUser.password = password
            newUser.name = "默认用户名"
            newUser.gender = "未设置"
            newUser.phoneNumber = "未设置"
            newUser.portrait = "未设置"
            newUser.email = "未设置"
            newUser.location = "未设置"
//            newUser.validable = false
            save()
        }
        
    }
    
    
    
    func editUser(){
        
    }
    
    func save(){
        manager.save()
        getUsers()
        currentUser = enableCurrentUser()
    }
    
    func getSpecifiedUser(with username: String, users: [UserEntity]) -> UserEntity?{
        print("当前查找的账号是：\(username)")
        print("查找的账号个数为\(users.count)")
        for index in 0..<users.count{
            print("user\(index)的账号是\(users[index].username)")
            print("user\(index)的密码是\(users[index].password)")
            if users[index].username == username{
                print("找到的账号为\(String(describing: users[index].username))")
                return users[index]
            }else{
                print("找不到\(username)")
            }
        }
        return nil
    }
    
    
    //MARK: - Intent(s) -LoginView
    
    func login(username: String, password: String, users: [UserEntity]){
        print("当前登陆的账号为\(username)密码为\(password)")
        if let theLogginUser = getSpecifiedUser(with: username,users: users){
            if username == theLogginUser.username && password == theLogginUser.password{
                theLogginUser.validable = true
                isValidable = true
                currentUser = theLogginUser
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.authenticated = true
                    self.authUserName = username
                }
            }else{
                print("用户名或密码错误")
            }
        }else{
            print("账号不存在，请创建账号")
        }
    }
    func logOut(){
        withAnimation{
            authenticated = false
            isValidable = nil
//            currentUser = UserEntity()
        }
        print("退出登陆")
    }

    func forgetPassword(){
//忘记密码
    }
    
}
