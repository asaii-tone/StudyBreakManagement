//
//  ResultView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/30.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var timeManager: TimeManager
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            HStack {
                Text("活動履歴")
                    .font(.system(size: self.screenWidth * 0.10, weight: .thin, design: .monospaced))
                    .foregroundColor(.orange)
                    .padding()
            }
            HStack {
                Text("トータル実行時間: ")
                .font(.title)
                    .padding(.horizontal)
                
            }
            HStack {
                Group {
                    Text("\(timeManager.displayTotalResultTime())")
                }
                .font(.system(size: self.screenWidth * 0.15, weight: .thin, design: .monospaced))
                .padding()
            }
            HStack {
                Text("前回実行時間: ")
                    .font(.title)
                    .padding(.horizontal)
            }
            HStack {
                Group {
                    Text("\(timeManager.displaySumResultTime())")
                }
                .font(.system(size: self.screenWidth * 0.10, weight: .thin, design: .monospaced))
                .padding()
            }
            Spacer()
            ResultButtonView()
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView().environmentObject(TimeManager())
    }
}
