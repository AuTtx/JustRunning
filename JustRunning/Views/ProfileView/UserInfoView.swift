//
//  UserInfoView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/11.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var vm: UserViewmodel
    
    @State private var name = ""
    @State private var birthday = Date()
    @State private var gender = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var location = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("简介")){
                    TextField("名字", text: $name)
                    TextField("个人签名", text: $description)
                }
                
                Section(header: Text("个人信息")){
                    TextField("性别", text: $gender)
                    DatePicker("出生日期",selection: $birthday, displayedComponents: .date)
                    TextField("所在地", text: $location)
                }
                Section(header: Text("联系方式")){
                    TextField("电话号码", text: $phoneNumber)
                    TextField("邮箱", text: $email)
                }
                Section{
                    Button(action: { vm.editUser()})
                    {
                        Text("保存")
                            .font(.headline)
                            .frame(width: 350, height: 40, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .cornerRadius(10)
                    }
                }
            }.navigationTitle("编辑资料")
            
        }
        
        
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
