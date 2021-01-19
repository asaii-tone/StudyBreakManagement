//
//  SettingView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/08.
//

import SwiftUI

struct SettingView: View {
    //モーダルシートを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timeManager: TimeManager
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Image(systemName: "music.quarternote.3")
                    .font(.title)
                Text("設定を変えれます")
                    .font(.title)
                Image(systemName: "music.quarternote.3")
                    .font(.title)
            }
            .edgesIgnoringSafeArea(.horizontal)
            NavigationView{
                Form {
                    Section(header: Text("休憩時間設定")){
                        Toggle(isOn: $timeManager.isAlarmOn) {
                            Text("Alerm Sound")
                        }
                        .onTapGesture {
                            //Toggleより早く実行されるため反転させる
                            if timeManager.isAlarmOn == true {
                                UserDefaults.standard.set(false, forKey: "isAlarmOn")
                            }
                            else {
                                UserDefaults.standard.set(true, forKey: "isAlarmOn")
                            }
                        }
                        Toggle(isOn: $timeManager.isVibrationOn) {
                            Text("Vibration")
                        }
                        .onTapGesture() {
                            if timeManager.isVibrationOn == true {
                                UserDefaults.standard.set(false, forKey: "isVibrationOn")
                            }
                            else {
                                UserDefaults.standard.set(true, forKey: "isVibrationOn")
                            }
                        }
                        NavigationLink(destination: SoundListView()){
                            HStack {
                                //設定項目名
                                Text("Sound Selection")
                                Spacer()
                                //現在選択中のアラーム音
                                Text("\(timeManager.soundName)")
                            }
                        }
                        NavigationLink(destination: PickerView()){
                            HStack {
                                //設定項目名
                                Text("Rest Time")
                                Spacer()
                                //現在選択中のアラーム音
                                Text("\(timeManager.restTime())")
                            }
                        }
                    }
                    Section(header: Text("活動時間設定")) {
                        Toggle(isOn: $timeManager.isBackgroundActionOn) {
                            Text("Background Action")
                        }
                        .onTapGesture() {
                            if timeManager.isBackgroundActionOn == true {
                                UserDefaults.standard.set(false, forKey: "isBackgroundActionOn")
                            }
                            else {
                                UserDefaults.standard.set(true, forKey: "isBackgroundActionOn")
                            }
                        }
                    }
                    Section(header: Text("アニメーション設定")) {
                        Toggle(isOn: $timeManager.isProgressBarOn) {
                            Text("Progress Bar")
                        }
                        .onTapGesture() {
                            if timeManager.isProgressBarOn == true {
                                UserDefaults.standard.set(false, forKey: "isProgressBarOn")
                            }
                            else {
                                UserDefaults.standard.set(true, forKey: "isProgressBarOn")
                            }
                        }
                    }
                    
                }
                //.navigationBarTitle("設定", displayMode: .inline)
                .navigationViewStyle(DefaultNavigationViewStyle())
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(TimeManager())
    }
}
