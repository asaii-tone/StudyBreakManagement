//
//  MainView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/06.
//

import SwiftUI
import AudioToolbox
//import UserNotifications

struct MainView: View {
    @EnvironmentObject var timeManager: TimeManager
    var body: some View {
        if timeManager.tabNum == 0 {
            if timeManager.studyBreakStatus == .tm {
                TmMainView()
                    //画面をスリープしないようにする
                    .onAppear() {
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
            }
            else if timeManager.studyBreakStatus == .sw {
                SwMainView()
                    .onAppear() {
                        //スリープ不可
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
            }
        }
        else if timeManager.tabNum == 1 {
            ZStack{
                VStack {
                    ResultView()
                    Spacer()
                    TabBar()
                }
            }
            //画面をスリープするようにする
            .onAppear() {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            //タイマーとストップウォッチをすすめるための処理
            .onReceive(timeManager.timer) { _ in
                //タイマーステータスが.running以外の場合何も実行しない
                guard self.timeManager.timerStatus == .running else { return }
                if (timeManager.studyBreakStatus == .sw) {
                    //時間をプラス0.1する
                    self.timeManager.nowStudyTime += 0.1
                }
                else {
                    //バックグラウンドの時間を収集する処理
                    let foreflag = UserDefaults.standard.bool(forKey: "foreFlag")
                    let backflag = UserDefaults.standard.bool(forKey: "backFlag")
                    if (foreflag == true) && (backflag == true) {
                        guard let backDateInfo = UserDefaults.standard.object(forKey: "backDate") as? Date else {return}
                        guard let foreDateInfo = UserDefaults.standard.object(forKey: "foreDate") as? Date else {return}
                        timeManager.dateInfo[0] = backDateInfo
                        timeManager.dateInfo[1] = foreDateInfo
                        if timeManager.studyBreakStatus == .tm {
                            timeManager.Interval = timeManager.dateInfo[1].timeIntervalSince(timeManager.dateInfo[0])
                            timeManager.duration -= timeManager.Interval
                        }
                        UserDefaults.standard.set(false, forKey: "foreFlag")
                        UserDefaults.standard.set(false, forKey: "backFlag")
                    }
                    if self.timeManager.duration > 0 {
                        //バックグラウンドの通知
                        timeManager.Notify()
                        //残り時間から-0.1する
                        self.timeManager.duration -= 0.1
                    //残り時間が0以下の場合
                    } else {
                        if timeManager.resetButton == true {
                            timeManager.resetButton = false
                        }else {
                            // 通知の削除
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MSG"])
                            //アラーム音を鳴らす
                            if timeManager.isAlarmOn {
                                AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
                            }
                            //バイブレーションを作動させる
                            if timeManager.isVibrationOn {
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            }
                            self.timeManager.studyBreakStatus = .sw
                            //タイマーステータスを.pouseに変更する
                            self.timeManager.timerStatus = .pause
                        }
                    }
                }
    //指定した時間(1秒)ごとに発動するTimerをトリガーにしてクロージャ内のコードを実行
            }
        }
        else if timeManager.tabNum == 2 {
            ZStack{
                VStack {
                    GuydeView()
                    Spacer()
                    TabBar()
                }
            }
            //画面をスリープするようにする
            .onAppear() {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            //タイマーとストップウォッチをすすめるための処理
            .onReceive(timeManager.timer) { _ in
                //タイマーステータスが.running以外の場合何も実行しない
                guard self.timeManager.timerStatus == .running else { return }
                if (timeManager.studyBreakStatus == .sw) {
                    //時間をプラス0.1する
                    self.timeManager.nowStudyTime += 0.1
                }
                else {
                    //バックグラウンドの時間を収集する処理
                    let foreflag = UserDefaults.standard.bool(forKey: "foreFlag")
                    let backflag = UserDefaults.standard.bool(forKey: "backFlag")
                    if (foreflag == true) && (backflag == true) {
                        guard let backDateInfo = UserDefaults.standard.object(forKey: "backDate") as? Date else {return}
                        guard let foreDateInfo = UserDefaults.standard.object(forKey: "foreDate") as? Date else {return}
                        timeManager.dateInfo[0] = backDateInfo
                        timeManager.dateInfo[1] = foreDateInfo
                        if timeManager.studyBreakStatus == .tm {
                            timeManager.Interval = timeManager.dateInfo[1].timeIntervalSince(timeManager.dateInfo[0])
                            timeManager.duration -= timeManager.Interval
                        }
                        UserDefaults.standard.set(false, forKey: "foreFlag")
                        UserDefaults.standard.set(false, forKey: "backFlag")
                    }
                    
                    if self.timeManager.duration > 0 {
                        //バックグラウンドの通知
                        timeManager.Notify()
                        //残り時間から-0.1する
                        self.timeManager.duration -= 0.1
                    //残り時間が0以下の場合
                    } else {
                        if timeManager.resetButton == true {
                            timeManager.resetButton = false
                        }else {
                            // 通知の削除
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MSG"])
                            //アラーム音を鳴らす
                            if timeManager.isAlarmOn {
                                AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
                            }
                            //バイブレーションを作動させる
                            if timeManager.isVibrationOn {
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            }
                            self.timeManager.studyBreakStatus = .sw
                            //タイマーステータスを.pouseに変更する
                            self.timeManager.timerStatus = .pause
                        }
                    }
                }
    //指定した時間(1秒)ごとに発動するTimerをトリガーにしてクロージャ内のコードを実行
            }
        }
        else if timeManager.tabNum == 3 {
            ZStack{
                VStack {
                    SettingView()
                    Spacer()
                    TabBar()
                }
            }
            //画面をスリープするようにする
            .onAppear() {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            //タイマーとストップウォッチをすすめるための処理, 0.1秒間隔
            .onReceive(timeManager.timer) { _ in
                //タイマーステータスが.running以外の場合何も実行しない
                guard self.timeManager.timerStatus == .running else { return }
                if (timeManager.studyBreakStatus == .sw) {
                    //時間をプラス0.1する
                    self.timeManager.nowStudyTime += 0.1
                }
                else {
                    //バックグラウンドの時間を収集する処理
                    let foreflag = UserDefaults.standard.bool(forKey: "foreFlag")
                    let backflag = UserDefaults.standard.bool(forKey: "backFlag")
                    if (foreflag == true) && (backflag == true) {
                        guard let backDateInfo = UserDefaults.standard.object(forKey: "backDate") as? Date else {return}
                        guard let foreDateInfo = UserDefaults.standard.object(forKey: "foreDate") as? Date else {return}
                        timeManager.dateInfo[0] = backDateInfo
                        timeManager.dateInfo[1] = foreDateInfo
                        print(timeManager.dateInfo)
                        if timeManager.studyBreakStatus == .tm {
                            timeManager.Interval = timeManager.dateInfo[1].timeIntervalSince(timeManager.dateInfo[0])
                            timeManager.duration -= timeManager.Interval
                        }
                        UserDefaults.standard.set(false, forKey: "foreFlag")
                        UserDefaults.standard.set(false, forKey: "backFlag")
                    }
                    
                    if self.timeManager.duration > 0 {
                        //バックグラウンドの通知
                        timeManager.Notify()
                        //残り時間から-0.1する
                        self.timeManager.duration -= 0.1
                    //残り時間が0以下の場合
                    } else {
                        if timeManager.resetButton == true {
                            timeManager.resetButton = false
                        }else {
                            // 通知の削除
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MSG"])
                            //アラーム音を鳴らす
                            if timeManager.isAlarmOn {
                                AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
                            }
                            //バイブレーションを作動させる
                            if timeManager.isVibrationOn {
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            }
                            self.timeManager.studyBreakStatus = .sw
                            //タイマーステータスを.pouseに変更する
                            self.timeManager.timerStatus = .pause
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(TimeManager())
        }
    }
}
