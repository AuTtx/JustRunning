
import SwiftUI
import AVFoundation

struct SettingsView: View {
    
    @AppStorage("SelectedSystemSound") private var sound: SystemSounds.ID = 1005
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var model: CountdownModel

    @State private var hours = [Int](0...23)
    @State private var minutes = [Int](0...59)
    @State private var seconds = [Int](0...59)

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("倒计时时间")) {
                    Picker("时", selection: $model.selectedHours.onChange(model.updateTimer)) {
                        ForEach(hours, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }
                    
                    Picker("分", selection: $model.selectedMinutes.onChange(model.updateTimer)) {
                        ForEach(minutes, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    
                    Picker("秒", selection: $model.selectedSeconds.onChange(model.updateTimer)) {
                        ForEach(seconds, id: \.self) { second in
                            Text("\(second)")
                        }
                    }
                }
                
                Section(header: Text("铃声")) {
                    Picker("铃声", selection: $sound.onChange(model.previewAudio)) {
                        ForEach(model.sounds, id: \.id) { audio in
                            Text(audio.title).tag(audio.id)
                        }
                    }
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CountdownModel())
    }
}
