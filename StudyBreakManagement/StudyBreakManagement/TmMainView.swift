//
//  TmMainView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/28.
//

import SwiftUI
import AudioToolbox
import UserNotifications

struct TmMainView: View {
    @EnvironmentObject var timeManager: TimeManager
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("只今の活動時間は")
                    Text("\(timeManager.displaySumResultTime())")
                    Text("おつかれさまです。")
                }
                .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                Spacer()
            }
            if timeManager.isProgressBarOn {
                ProgressBar()
            }
            if timeManager.timerStatus == .stopped {
                
            } else {
                TimerView()
            }
            VStack {
                Spacer()
                ZStack {
                    ButtonsView()
                        .padding(.bottom)
                }
                TabBar()
            }
        }
        //指定した時間(0.1秒)ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
        .onReceive(timeManager.timer) { _ in
            //タイマーステータスが.running以外の場合何も実行しない
            guard self.timeManager.timerStatus == .running else { return }
            //バックグラウンドの時間を収集する処理
            //ポーズ中の時間は更新しない
            if timeManager.pouseFlug == true {
                UserDefaults.standard.set(false, forKey: "foreFlag")
                UserDefaults.standard.set(false, forKey: "backFlag")
                //ポーズフラグをオフにする
                timeManager.pouseFlug = false
            }
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
            //残り時間が0より大きい場合
            if self.timeManager.duration > 0 {
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

struct TmMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TmMainView().environmentObject(TimeManager())
        }
    }
}
