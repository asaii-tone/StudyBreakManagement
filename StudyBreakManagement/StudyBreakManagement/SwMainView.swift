//
//  SwMainView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/28.
//

import SwiftUI
import AudioToolbox
import UserNotifications

struct SwMainView: View {
    @EnvironmentObject var timeManager: TimeManager
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            if (timeManager.timerStatus == .stopped && timeManager.studyTime[0] != 0) {
                VStack {
                    Group {
                        Text("\nお疲れさまでした。")
                        Text("\(timeManager.displaySumResultTime())")
                        Text("活動しました。")
                    }
                    .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                    Spacer()
                }
            }
            if (timeManager.studyBreakStatus == .tm) {
                TmMainView()
            }else {
                StopWatchView()
            }
            VStack {
                Spacer()
                if (timeManager.timerStatus != .stopped && timeManager.studyBreakStatus == .sw) {
                    if (timeManager.timerStatus == .running) {
                        Text("活動中")
                            .font(.title)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    else {
                        Text("終了ボタン")
                            .font(.title)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("で活動が記録されます")
                            .font(.title)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                ZStack {
                    SwButtonsView()
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
            if timeManager.isBackgroundActionOn == true {
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
                    if timeManager.studyBreakStatus == .sw {
                        timeManager.Interval = timeManager.dateInfo[1].timeIntervalSince(timeManager.dateInfo[0])
                        timeManager.nowStudyTime += timeManager.Interval
                    }
                    UserDefaults.standard.set(false, forKey: "foreFlag")
                    UserDefaults.standard.set(false, forKey: "backFlag")
                }
            }
                //時間をプラス0.1する
            self.timeManager.nowStudyTime += 0.1
            //残り時間が0以下の場合
        }
    }
}

struct SwMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwMainView().environmentObject(TimeManager())
        }
    }
}
