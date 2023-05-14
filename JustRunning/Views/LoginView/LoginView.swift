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
    
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
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
                            LoginTextView(name: $username,isValid: $vm.isValidable)
                            if let valid = vm.isValidable{
                                if valid {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .padding(8)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                        .padding(8)
                                }
                            }
                        }
                        
                        HStack{
                            PasswordTextView(name: $password, isValid: $vm.isValidable, showPassword: $showPassword)
                            if let valid = vm.isValidable{
                                if valid {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .padding(8)
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.red)
                                        .padding(8)
                                }
                            }
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
                                    Text("该设备上的所有账号")
                                        .bold()
                                    ForEach(vm.users){ user in
                                        if user.username != ""{
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
                            }
                            Spacer()
                                
                        }
                        Button(action: {withAnimation{
                            vm.login(username: username, password: password, users: vm.users)
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
                            vm.addUserInCoreData(username: username, password: password, users: vm.users)
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
    @Binding var isValid: Bool?
    var body: some View {
        HStack {
            TextField("请输入",text: $name)
                .padding()
                .background(Color.background)
                .cornerRadius(16)
                .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }

}
struct PasswordTextView: View{
    @EnvironmentObject var vm: UserViewmodel
    @Binding var name: String
    @Binding var isValid: Bool?
    @Binding var showPassword: Bool
    var body: some View {
        if !showPassword{
            HStack{
                SecureField("请输入",text: $name)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(16)
                    .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
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
                LoginTextView(name: $name,isValid: $vm.isValidable)
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
