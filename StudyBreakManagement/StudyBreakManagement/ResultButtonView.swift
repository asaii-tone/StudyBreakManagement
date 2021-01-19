//
//  ResultButtonView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/09.
//

import SwiftUI

struct ResultButtonView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    var body: some View {
        //リセットボタン
        Button(action: {
            self.timeManager.studyTime[1] = 0
            UserDefaults.standard.set(timeManager.studyTime, forKey: "studyTime")
        }) {
            VStack{
                Image(systemName: "trash.fill")
                    .foregroundColor(.black)//前面のカラーを指定
                Text("カウンタ")
                    .foregroundColor(.black)//前面のカラーを指定
                Text("リセット")
                    .foregroundColor(.black)//前面のカラーを指定
            }
        }
            .font(.title)
            .frame(width: 200, height: 125)
            //ボタンの左側とスクリーンの端にスペースを取る
            .background(Color(red: 255/255, green: 153/255, blue: 51/255))//背景のUI部品を指定
            .cornerRadius(30)
            .padding()
    }
}

struct SettingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResultButtonView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
