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
    //    var username: String = ""
    //    var password: String = ""
    //    var name: String = ""
    //    var gender: String = ""
    //    var email: String = ""
    //    var location: String = ""
    //    var phoneNubmer: String = ""
    @State private var showPassword: Bool = false
    
    let manager = CoreDataManager.instance
    @Published var users: [UserEntity] = []
    //    @Published var currentUser: UserEntity
    
    init(){
        //        currentUser = UserEntity(context: manager.context)
        //        currentUser.username = ""
        //        currentUser.password = ""
        getUsers()
    }
    
    func getUsers(){
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        //        let sort = NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)
        //        request.sortDescriptors = [sort]
        //
        //        let filter = NSPredicate(format: "name == %@", "Autt")
        //        request.predicate = filter
        
        do{
            users = try manager.context.fetch(request)
            print("成功更新users")
        }catch let error {
            print("Error fetching. \(error.localizedDescription)")
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
            newUser.validable = false
            save()
        }
        
    }
    
    
    
    func editUser(){
        
    }
    
    func save(){
        manager.save()
        getUsers()
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
//    func getSpecifiedUser(with username: String, users: [UserEntity]) -> UserEntity?{
//        print("当前查找的账号是：\(username)")
//        print("查找的账号个数为\(users.count)")
//        for item in users{
//            print("账号是\(item.username)")
//            print("密码是\(item.password)")
//            if item.username == username{
//                print("找到的账号为\(String(describing: item.username))")
//                return item
//            }else{
//                print("找不到\(username)")
//                return nil
//            }
//        }
//        return nil
//    }
    
    
    
    
    //MARK: - Intent(s) -LoginView
    
    func login(username: String, password: String, users: [UserEntity]){
        print("当前登陆的账号为\(username)密码为\(password)")
        if let theLogginUser = getSpecifiedUser(with: username,users: users){
            if username == theLogginUser.username && password == theLogginUser.password{
                authenticated = true
                theLogginUser.validable = true
//                currentUser = theLogginUser
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
//            currentUser = UserEntity()
        }
        print("退出登陆")
    }

    func forgetPassword(){
//忘记密码
    }
    
}
