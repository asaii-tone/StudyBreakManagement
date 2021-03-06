//
//  SwButtonView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/29.
//

import SwiftUI

struct SwButtonsView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    var body: some View {
        HStack {
            //リセットボタン
            Button(action: {
                //タイマーステータスが.stopped以外の場合
                if timeManager.timerStatus != .stopped {
                    //swMainViewに行くときのみ動作する
                    UserDefaults.standard.set(false, forKey: "foreFlag")
                    UserDefaults.standard.set(false, forKey: "backFlag")
                    self.timeManager.setTimer()
                    self.timeManager.reset()
                    self.timeManager.changeMode()
                }
                

            }) {
                VStack{
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)//前面のカラーを指定
                    Text("休憩")
                        .foregroundColor(.black)//前面のカラーを指定
                    Text("する")
                        .foregroundColor(.black)//前面のカラーを指定
                }
            }
                .font(.title)
                .frame(width: 100, height: 150)
                //ボタンの左側とスクリーンの端にスペースを取る
                .background(Color(red: 255/255, green: 153/255, blue: 51/255))//背景のUI部品を指定
                .cornerRadius(30)
                .padding(.leading)
                //タイマーステータスが終了なら透明度を0.1に、そうでなければ不透明に
                .opacity(self.timeManager.timerStatus == .stopped ? 0.1 : 1)
            
            Spacer()
            //終了ボタン
            Button(action: {
                if timeManager.timerStatus != .stopped {
                    self.timeManager.endTimer()
                }
            }) {
                VStack{
                    Image(systemName: "stop.circle.fill")
                    Text("終了")
                }
            }
                .foregroundColor(.black)//前面のカラーを指定
                .font(.title)
                .frame(width: 100, height: 75)
                //ボタンの左側とスクリーンの端にスペースを取る
                .background(Color(red: 255/255, green: 255/255, blue: 51/255))//背景のUI部品を指定
                .cornerRadius(30)
                .padding(.horizontal)
                //タイマーステータスが終了なら透明度を0.1に、そうでなければ不透明に
                .opacity(self.timeManager.timerStatus == .stopped ? 0.1 : 1)
            
            Spacer()
                
        //running: 一時停止ボタン/pause or stopped: スタートボタン
            Button(action: {
                //タイマーステータスが.running以外の場合
                if timeManager.timerStatus != .running {
                    self.timeManager.start()
                //タイマーステータスがrunningのとき
                }else if timeManager.timerStatus == .running {
                    self.timeManager.pause()
                }

            }){
                Text(self.timeManager.timerStatus == .running ? "停止" : "開始")
                Image(systemName: self.timeManager.timerStatus == .running ? "pause.circle.fill" : "play.circle.fill")
            }
            .font(.title)
                .frame(width: 150, height: 75)
                .foregroundColor(.black)//前面のカラーを指定
            .background(self.timeManager.timerStatus == .running ? Color(red: 0/255, green: 255/255, blue: 102/255) : Color(red: 51/255, green: 255/255, blue: 255/255))//背景のUI部品を指定
                .cornerRadius(30)
                //ボタンの右側とスクリーンの端にスペースを取る
                .padding(.trailing)
                //Pickerの時間、分、秒がいずれも0だったらボタンの透明度を0.1に、そうでなければ1(不透明)に
                .opacity(self.timeManager.hourSelection == 0 && self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 ? 0.1 : 1)
        }
    }
}

struct SwButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SwButtonsView().environmentObject(TimeManager())
    }
}
