//
//  TimerView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/06.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        //時間表示形式が時間、分、秒によって、タイマーの文字サイズを条件分岐させる
        if self.timeManager.displayedTimeFormat == .hr {
            Text(self.timeManager.displayTimer())
                //文字サイズをスクリーンサイズ＊０．１５に指定
                .font(.system(size: self.screenWidth * 0.15, weight: .thin, design: .monospaced))
//                念の為、行数を１行に指定
                .lineLimit(1)
                //デフォルトの余白を追加
                .padding()
        }else if self.timeManager.displayedTimeFormat == .min {
            Text(self.timeManager.displayTimer())
                .font(.system(size: self.screenWidth * 0.23, weight: .thin, design: .monospaced))
                .lineLimit(1)
                .padding()
        }else {
            Text(self.timeManager.displayTimer())
                .font(.system(size: self.screenWidth * 0.5, weight: .thin, design: .monospaced))
                .lineLimit(1)
                .padding()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
