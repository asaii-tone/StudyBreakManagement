//
//  PickerView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/06.
//

import SwiftUI

struct PickerView: View {
    //TimerManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    //@ObservedObject var timeManager = TimeManager()
    //デバイススクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイススクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height
    //設定可能な時間単位の数値：0から23までの整数のArray
    var hours = [Int](0..<24)
    //設定可能な分単位の数値：0から59までの整数のArray
    var minutes = [Int](0..<60)
    //設定可能な秒単位の数値：0から59までの整数のArray
    var seconds = [Int](0..<60)
    
    var body: some View {
        //ZstackでPickerとレイヤーで重なるようにボタンを配置
        ZStack{
            VStack {
                Group {
                    if timeManager.timerStatus == .running {
                        Text("タイマーを停止してください")
                            .foregroundColor(.red)
                    }
                    else {
                        Text("休憩時間をセットして")
                            .foregroundColor(.blue)
                        HStack {
                            Text("下部の")
                            Image(systemName: "checkmark.circle.fill")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                            Text("をクリック")
                        }
                    }
                }
                .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                Spacer()
            }
            //時間、分、秒のPickerとそれぞれの単位を示すテキストをHStackで横並びに
            HStack {
    //            時間単位のPicker
                Picker(selection: self.$timeManager.hourSelection, label: Text("hour")){
                    ForEach(0 ..< self.hours.count) { index in
                        Text("\(self.hours[index])").tag(index)
                    }
                }
    //            上下に回転するホイールスタイル
                .pickerStyle(WheelPickerStyle())
    //            ピッカーの幅をすすりーんサイズ * 0.1、高さをスクリーンサイズ * 0.4で指定
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
    //            上のフレームかでクリップして、はみ出す部分は非表示にする
                .clipped()
    //            時間単位を表すテキスト
                Text("hour").font(.headline)
                
    //            分単位のPicker
                Picker(selection: self.$timeManager.minSelection, label: Text("minute")){
                    ForEach(0 ..< self.minutes.count) { index in
                        Text("\(self.minutes[index])").tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                Text("min").font(.headline)
                
    //            秒単位のPicker
                Picker(selection: self.$timeManager.secSelection, label: Text("second")) {
                    ForEach(0 ..< self.seconds.count) { index in
                        Text("\(self.seconds[index])").tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                Text("second").font(.headline)
            }
            
            //タップして設定を確定するチェックマークアイコン
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .offset(y: self.screenWidth * 0.32)
                .opacity(self.timeManager.hourSelection == 0 && self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 ? 0.1 : 1)
                .onTapGesture {
                    if self.timeManager.hourSelection != 0 || self.timeManager.minSelection != 0 || self.timeManager.secSelection != 0 {
                        timeManager.setPickerTimer()
                        UserDefaults.standard.set(timeManager.maxValue, forKey: "maxValue")
                    }
                }
        }
    }
}
struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView().environmentObject(TimeManager())
    }
}
