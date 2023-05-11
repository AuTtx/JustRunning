//
//  ProfileView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/3.
//


//搞地图！！！！！

import SwiftUI
import MapKit

struct ProfileView: View {
    @EnvironmentObject var vm: UserViewmodel
    var body: some View {
        ZStack{
            Color.background.edgesIgnoringSafeArea(.all)
            //            Image("背景")
            //                .resizable()
            //                .scaledToFit()
            //                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
                PersonInfo(vm: vm)
                    .padding(.bottom)
                Divider()
                Buttons(vm: vm)
                Spacer()
                //MapView
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




struct PersonInfo: View{
//    @EnvironmentObject var vm: UserViewmodel
    let vm: UserViewmodel
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    var body: some View{
        HStack{
            VStack{
                Button{
                    isPickerShowing = true
                }label: {
                    ZStack{
                        Circle().fill(Color.secondaryBackground)
                            .frame(width: 90, height: 90)
                        if selectedImage != nil{
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(8)
                        }else{
                            Image("帅照")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(8)
                        }
                    }
                }
            }
            .sheet(isPresented: $isPickerShowing){
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
            .padding()
            VStack(alignment: .leading) {
                Text("\(vm.currentUser.name ?? "用户名未设置") ")
//                Text("current失败")
                    .font(.title2)
                    .bold()
                Text("\(vm.currentUser.email ?? "邮箱未设置")")
//                Text("current失败")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(vm.currentUser.location ?? "暂未获取地址")")
//                Text("current失败")
            }
            Spacer()
        }
        .padding()
    }
}

struct Buttons: View{
//    @EnvironmentObject var vm: UserViewmodel
    let vm: UserViewmodel
    var body: some View{
        NavigationLink(destination: ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            Text("Update Account")
        }){
            HStack {
                Image(systemName: "slider.horizontal.3")
                Text("查看运动记录")
                
            }.font(.headline)
            .padding()
            .background(Color.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
        }
        
        NavigationLink(destination: UserInfoView()){
            HStack {
                Image(systemName: "person.fill")
                Text("个人信息")
            }.font(.headline)
            .padding()
            .background(Color.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
        }
        
        
        NavigationLink(destination: ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            Text("Orders")
        }){
            HStack {
                Image(systemName: "gearshape.fill")
                Text("设置")
            }.font(.headline)
            .padding()
            .background(Color.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
        }
        
        HStack{
            Image(systemName: "rectangle.portrait.and.arrow.right")
            Button("退出登录"){
                vm.logOut()
            }
        }.font(.headline)
            .padding()
            .background(Color.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
    }
}







struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(UserViewmodel())
    }
}
