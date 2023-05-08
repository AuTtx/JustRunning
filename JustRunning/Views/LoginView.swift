//
//  LoginView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.

//
//AppStorage 完成了。 logout 退不出去；动画不显示问题；输入错误的提示；数据库连接？；Apple ID/qq登陆？
//

import SwiftUI
import CoreData

struct LoginView: View {
    @EnvironmentObject var vm: UserViewmodel
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var users: FetchedResults<User>
    
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    
    func createAnAccount(username: String, password: String, context: NSManagedObjectContext){
            //在数据库中创建账户
        DataController().signUpAccountInCoreData(username: username, password: password, context: context)
//        if let matchedUserIndex = users.firstIndex(where: { $0.username == username }){
//           print("创建成功")
//        }
    }
    func matchUserInCoreData(username: String) -> User?{
        for item in users{
            if username == item.username{
                return item
            }else{
                return nil
            }
        }
        return nil
    }
    func login(username: String, password: String, context: NSManagedObjectContext){
        print("\(username)")
        print("\(password)")
        if let theLogginUser = matchUserInCoreData(username: username){
            if username == theLogginUser.username && password == theLogginUser.password{
                vm.authenticated = true
                theLogginUser.validable = true
                vm.currentUser = theLogginUser.transformFromUser(user: theLogginUser)
            }else{
                print("用户名或密码错误")
            }
        }else{
            print("账号不存在，请创建账号")
        }
    }
    func logOut(){
        withAnimation{
            vm.authenticated = false
            vm.currentUser.validable = false
        }
        print("退出登陆")
    }
    var body: some View {
        if vm.authenticated{
            MainView()
        }else{
            ZStack{
                Color.background.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center,spacing: 0){
                    Text("login")
                        .font(.title3)
                        .bold()
                    RunningAnimation()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    VStack{
                        HStack{
                            LoginTextView(name: $vm.username)
                        }
                        HStack{
                            PasswordTextView(name: $vm.password, showPassword: $showPassword)
                        }
                        HStack{
                            Button(action:{withAnimation{
                                showSheet.toggle()
                            }}){
                                Text("忘记密码 ?")
                                    .font(.subheadline).bold()
                            }
                            .padding(8)
                            .sheet(isPresented: $showSheet){
                                ScrollView{
                                    ForEach(users){ user in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(user.username!)
                                                    .bold()
                                                Text(user.password!)
                                                    .bold()
                                                Divider().bold()
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                                
                        }
                        Button(action: {withAnimation{
                            login(username: vm.username, password: vm.password, context: managedObjContext)
                        }}){
                                Text("Sign In")
                                    .foregroundColor(.darkText)
                                    .font(.headline)
                                    .padding()
                                    .background(Color.secondaryBackground)
                                    .cornerRadius(16)
                                    .shadow(color: .darkText.opacity(0.2), radius: 2, x: 1.0, y: 2)
                        }
                        Button(action:{withAnimation{
                           //创建账号界面
                            createAnAccount(username: vm.username, password: vm.password, context: managedObjContext)
                        }}){
                            Text("没有账号？点此创建").font(.headline)
                                .foregroundColor(.darkText)
                                .shadow(color: .darkText.opacity(0.1), radius: 2, x: 1, y: 2)
                        }
                    }
                    .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                        Spacer()
                }.padding()
                    .sheet(isPresented: $showSheet){
                        Text("Create an account or forgot password")
                    }
            }.transition(.offset(x: 0,y: 850))
        }
        
    }
}




struct LoginTextView: View{
    @EnvironmentObject var vm: UserViewmodel
    @Binding var name: String
//    @Binding var isAuthenticated: Bool?
    var body: some View {
        HStack {
            TextField("请输入",text: $name)
                .padding()
                .background(Color.background)
                .cornerRadius(16)
                .shadow(color: .borderColor(condition: vm.authenticated), radius: 2, x: 0.0, y: 0.0)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }

}
struct PasswordTextView: View{
    @EnvironmentObject var vm: UserViewmodel
    @Binding var name: String
//    @Binding var isAuthenticated: Bool?
    @Binding var showPassword: Bool
    var body: some View {
        if !showPassword{
            HStack{
                SecureField("请输入",text: $name)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(16)
                    .shadow(color: .borderColor(condition: vm.authenticated), radius: 2, x: 0.0, y: 0.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                Button(action:{
                    withAnimation{
                        showPassword.toggle()
                    }
                }){
                    Image(systemName: "eye")
                        .imageScale(.large)
                }
            }
        } else {
            HStack {
                LoginTextView(name: $name)
                Button(action:{showPassword.toggle()}){
                    Image(systemName: "eye.slash")
                        .imageScale(.large)
                }
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView().environmentObject(UserViewmodel())
    }
}
