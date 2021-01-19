//
//  TimeManager.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/06.
//

import SwiftUI
import AudioToolbox //追加インポート

class TimeManager: ObservableObject {
    //Pickerで設定した"時間"を格納する変数
    @Published var hourSelection: Int = 0
    //Pickerで設定した"分"を格納する変数
    @Published var minSelection: Int = 10
    //Pickerで設定した"秒"を格納する変数
    @Published var secSelection: Int = 0
    //カウントダウン残り時間
    @Published var duration: Double = 0
    
    @Published var displayedTimeFormat: TimeFormat = .min
    //タイマーのステータス
    @Published var timerStatus: TimerStatus = .stopped
    //1秒ごとに発動するTimerクラスのpublishメソッド
    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    //AudioToolboxに格納された音源を利用するためのデータ型でデフォルトのサウンドIDを格納
    @Published var soundID: SystemSoundID = 1151
    //soundIDプロパティの値に対応するサウンド名を格納
    @Published var soundName: String = "Beat"
    //アラーム音オン/オフの設定
    @Published var isAlarmOn: Bool = true
    //バイブレーションON/OFFの設定
    @Published var isVibrationOn: Bool = true
    //プログレスバー表示ON/OFFの設定
    @Published var isProgressBarOn: Bool = true
    //エフェクトアニメーション表示ON/OFFの設定
    @Published var isEffectAnimationOn: Bool = true
    
    //StopWatch or Timer の切り替え
    @Published var studyBreakStatus: StudyBreakStatus = .sw
    //ワーク中の時間
    @Published var nowStudyTime: Double = 0
    //sumStudyTIme: 0, totalStudyTime: 1, maxValu: 2(pickerViewから取る休憩時間)
    @Published var studyTime: [Double] = [0, 0, 0]
    //リセットボタンフラグ
    @Published var resetButton: Bool = false
    //ワーク回数
    @Published var workNum: Int = 0
    //TabBarの状態
    @Published var tabNum: Int = 0
    //日付を獲得する
    @Published var dt: Date = Date()
    //日付を日本に合わせるためのフォーマット
    @Published var dateFormatter = DateFormatter()
    //起動時のフラグ
    @Published var firstOpenFlug: Bool = false
    
//    //一定期間内の学習時間を記憶する配列(0: Total, 1: Day, 2: Week, 3: Month, 4: Year)
//    @Published var StudyTime: [Double] = [0, 0, 0, 0, 0]
//    //現在の日付を格納する配列
//    @Published var DateString: [String] = ["", "", "", ""]
    
    
    
    
    func setTimer() {
        //残り時間をPickerから取得した時間・分・秒の値をすべて秒換算する
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        if duration != 0 {
            studyTime[2] = duration
        }
        
        if duration < 60 {
            displayedTimeFormat = .sec
        } else if duration < 3600 {
            displayedTimeFormat = .min
        } else {
            displayedTimeFormat = .hr
        }
    }
    func settingTimer() {
        //残り時間をPickerから取得した時間・分・秒の値をすべて秒換算する
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        //Pickerで時間を設定した時点を最大時間とする
        studyTime[2] = duration
        
        if duration < 60 {
            displayedTimeFormat = .sec
        } else if duration < 3600 {
            displayedTimeFormat = .min
        } else {
            displayedTimeFormat = .hr
        }
    }
    func displayTimer() -> String {
        let hr = Int(duration) / 3600
        let min = Int(duration) % 3600 / 60
        let sec = Int(duration) % 3600 % 60
        
        switch displayedTimeFormat {
        case .hr:
            return String(format: "%02d:%02d%:02d", hr, min, sec)
        case .min:
            return String(format: "%02d:%02d", min, sec)
        case .sec:
            return String(format: "%02d", sec)
        }
    }
    func restTime() -> String {
        let hr = Int(studyTime[2]) / 3600
        let min = Int(studyTime[2]) % 3600 / 60
        let sec = Int(studyTime[2]) % 3600 % 60
        
        switch displayedTimeFormat {
        case .hr:
            return String(format: "%02d時間%02d分%02d秒", hr, min, sec)
        case .min:
            return String(format: "%02d分%02d秒", min, sec)
        case .sec:
            return String(format: "%02d秒", sec)
        
        }
    }
    func displayStopWatch() -> String {
        let hr = Int(nowStudyTime) / 3600
        let min = Int(nowStudyTime) % 3600 / 60
        let sec = Int(nowStudyTime) % 3600 % 60
        
        return String(format: "%02d:%02d:%02d", hr, min, sec)
    }
    func displaySumResultTime() -> String {
        let hr = Int(studyTime[0]) / 3600
        let min = Int(studyTime[0]) % 3600 / 60
        let sec = Int(studyTime[0]) % 3600 % 60
        
        return String(format: "%02d:%02d:%02d", hr, min, sec)
    }
    func displayTotalResultTime() -> String {
        let hr = Int(studyTime[1]) / 3600
        let min = Int(studyTime[1]) % 3600 / 60
        let sec = Int(studyTime[1]) % 3600 % 60
        
        return String(format: "%02d:%02d:%02d", hr, min, sec)
    }
    //スタートボタンをタップしたときに発動するメソッド
    func start() {
        if timerStatus == .stopped {
            studyTime[0] = 0
            nowStudyTime = 0
        }
        //タイマーステータスを.runnningにする
        timerStatus = .running
    }
    
    //一時停止ボタンを押したときのメソッド
    func pause() {
        //タイマーステータスを.pauseにする
        timerStatus = .pause
    }
    
    //開始・休憩ボタンをタップしたときに発動するメソッド
    func reset() {
        //開始ボタンを押したとき
        if studyBreakStatus == .tm {
            duration = 0
            resetButton = true
        }//休憩ボタンを押したとき
        else {
            studyTime[0] = studyTime[0] + nowStudyTime
            nowStudyTime = 0
            duration = studyTime[2]
        }
    }
    
    func endTimer() {
        studyTime[0] += nowStudyTime
        studyBreakStatus = .sw
        timerStatus = .stopped
        studyTime[1] += studyTime[0]
        nowStudyTime = 0
        UserDefaults.standard.set(self.studyTime, forKey: "studyTime")
    }
    
    //stopWatch or Timer の切り替え
    func changeMode() {
        if studyBreakStatus == .tm {
            studyBreakStatus = .sw
        }
        else {
            studyBreakStatus = .tm
        }
    }
    
//    //日付を獲得する
//    func dateSetting() {
//        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: Locale(identifier: "ja_JA"))
//        if DateString[0] != dateFormatter.string(from: dt) {
//            DateString[0] = dateFormatter.string(from: dt)
//        }
//
//        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "w", options: 0, locale: Locale(identifier: "ja_JA"))
//        if DateString[1] != dateFormatter.string(from: dt) {
//            DateString[1] = dateFormatter.string(from: dt)
//        }
//
//        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M", options: 0, locale: Locale(identifier: "ja_JA"))
//        if DateString[2] != dateFormatter.string(from: dt) {
//            DateString[2] = dateFormatter.string(from: dt)
//        }
//
//        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "y", options: 0, locale: Locale(identifier: "ja_JA"))
//        if DateString[3] != dateFormatter.string(from: dt) {
//            DateString[3] = dateFormatter.string(from: dt)
//        }
//    }
}

