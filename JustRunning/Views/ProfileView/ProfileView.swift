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
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    var body: some View {
        NavigationView{
            ZStack{
                Color.background.edgesIgnoringSafeArea(.all)
                //            Image("背景")
                //                .resizable()
                //                .scaledToFit()
                //                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center){
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
                            //                            Text("\(vm.name ?? "用户名未设置") ")
                            //                Text("current失败")
                                .font(.title2)
                                .bold()
                            Text("\(vm.currentUser.email ?? "邮箱未设置")")
                            //                            Text("\(vm.email ?? "邮箱未设置")")
                            //                Text("current失败")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(vm.currentUser.location ?? "暂未获取地址")")
                            //                            Text("\(vm.location ?? "暂未获取地址")")
                            //                Text("current失败")
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.bottom)
                    Divider()
                    Buttons(vm: vm)
                    Spacer()
                    //MapView
                    VStack{
                        HStack{
                            Text("JustRunning")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .font(.largeTitle)
                                .padding(.leading, 10)
                        }
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    
                    Image("Run")
                        .resizable()
                        .frame(width: 350, height: 200)
                        .cornerRadius(30)
                        .padding(.bottom,50)
                    
                }
            }.background(Color.secondaryBackground)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
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
                    //                Text("\(vm.currentUser.name ?? "用户名未设置") ")
                    Text("\(vm.name ?? "用户名未设置") ")
                    //                Text("current失败")
                        .font(.title2)
                        .bold()
                    //                Text("\(vm.currentUser.email ?? "邮箱未设置")")
                    Text("\(vm.email ?? "邮箱未设置")")
                    //                Text("current失败")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    //                Text("\(vm.currentUser.location ?? "暂未获取地址")")
                    Text("\(vm.location ?? "暂未获取地址")")
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
            NavigationLink(
                destination:AnalysisView(),
                label: {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                        Text("查看运动记录")
                        
                    }.font(.headline)
                        .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(12)
                        .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
                           })
            NavigationLink(
                destination: UserInfoView(),
                label: {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("编辑信息")
                    }.font(.headline)
                        .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(12)
                        .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
                })
            
            
            
            NavigationLink(destination: ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("这里是设置界面")
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
}
