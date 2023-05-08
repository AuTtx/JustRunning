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
//    @Published var user: User
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var users: FetchedResults<User>
//    @Environment(\.managedObjectContext)  var managedObjContext
    
    //    @AppStorage("AUTH_KEY") var authenticated = false
    @AppStorage("AUTH_KEY") var authenticated = false {
        willSet{ objectWillChange.send() }
    }
    
    
    var currentUser = UserData()
   
//     var temUser = User()
    
    var username: String = ""
    var password: String = ""
    
    init(){
//        currentUser = User(entity: .entity(forEntityName: "User", in: managedObjContext)!, insertInto: managedObjContext)
    }
//    @AppStorage("USER_KEY") var username = "username"
//
//    @Published var password = "password"
//    @Published var invalid: Bool? = false
    @State private var showPassword: Bool = false
    
//    private var sampleUser = "username"
//    private var samplePassword = "password"
    
//    init(){
//        user = User(gender: "man", name: "许智尧", login: Login(uid: "01", username: "autt", password: "123456"), email: "1932063838@qq.com", phonenumber: "18801510867", portrait: Picture(imagename: "image"), location: Location(province: "江苏", city: "无锡", district: "惠山"))
//    }
        //MARK: - Intent(s)
//    func login(username: String ,password: String){
//        if username == "autt" && password == "123456" {
//            authenticated = true
//            user.validable = true
//        }else{
//            print(authenticated)
//            print("wrong")
//        }
//    }
    
    func login(username: String, password: String, context: NSManagedObjectContext){
        print("\(username)")
        print("\(password)")
        if let theLogginUser = matchUserInCoreData(username: username, context: context){
            if username == theLogginUser.username && password == theLogginUser.password{
                authenticated = true
                theLogginUser.validable = true
                currentUser = theLogginUser.transformFromUser(user: theLogginUser)
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
            currentUser.validable = false
        }
        print("退出登陆")
    }



    func createAnAccount(username: String, password: String, context: NSManagedObjectContext){
            //在数据库中创建账户
        DataController().signUpAccountInCoreData(username: username, password: password, context: context)
//        if let matchedUserIndex = users.firstIndex(where: { $0.username == username }){
//           print("创建成功")
//        }
    }

    func forgetPassword(){
//忘记密码
    }




//    func matchUserInCoreData(username: String, context: NSManagedObjectContext) -> User?{
//        if let matchedUserIndex = users.firstIndex(where: { $0.username == username }){
//            return users[matchedUserIndex]
//        }else{
//            return nil
//        }
//    }


    func matchUserInCoreData(username: String, context: NSManagedObjectContext) -> User?{
        for item in users{
            if username == item.username{
                return item
            }else{
                return nil
            }
        }
        return nil
    }
    
}
