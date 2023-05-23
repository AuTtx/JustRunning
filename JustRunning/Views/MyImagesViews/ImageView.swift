//
//  ImageView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/23.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField:Bool
    var body: some View {
        NavigationView {
            VStack {
                if !vm.isEditing {
                    imageScroll
                }
                selectedImage
                VStack {
                    if vm.image != nil {
                       editGroup
                    }
                    if !vm.isEditing {
                        pickerButtons
                    }
                }
                .padding()
                Spacer()
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vm.loadMyImagesJSONFile()
                }
            }
            .sheet(isPresented: $vm.showPicker) {
                ImagePickerRunning(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
            }
            .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            nameField = false
                        } label : {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
            .environmentObject(ViewModel())
    }
}
