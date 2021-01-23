//
//  StopWatchView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/26.
//

import SwiftUI

struct StopWatchView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        Text(self.timeManager.displayStopWatch())
            //文字サイズをスクリーンサイズ＊０．１５に指定
            .font(.system(size: self.screenWidth * 0.15, weight: .thin, design: .monospaced))
//                念の為、行数を１行に指定
            .lineLimit(1)
            //デフォルトの余白を追加
            .padding()
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
