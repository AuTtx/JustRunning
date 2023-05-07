//
//  LoginView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.

//
//AppStorage 完成了。 logout 退不出去；动画不显示问题；输入错误的提示；数据库连接？；Apple ID/qq登陆？
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: UserViewmodel
    
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    
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
                            LoginTextView(name: $vm.user.login.username)
                        }
                        HStack{
                            PasswordTextView(name: $vm.user.login.password, showPassword: $showPassword)
                        }
                        Button(action: {withAnimation{
                            vm.login(username: vm.user.login.username, password: vm.user.login.password)
                        }}){
                                Text("Sign In")
                                    .foregroundColor(.darkText)
                                    .font(.headline)
                                    .padding()
                                    .background(Color.secondaryBackground)
                                    .cornerRadius(16)
                                    .shadow(color: .darkText.opacity(0.2), radius: 2, x: 1.0, y: 2)
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
                .shadow(color: .borderColor(condition: vm.user.validable), radius: 2, x: 0.0, y: 0.0)
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
                    .shadow(color: .borderColor(condition: vm.user.validable), radius: 2, x: 0.0, y: 0.0)
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