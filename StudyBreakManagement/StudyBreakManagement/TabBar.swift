//
//  TabBar.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/29.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var timeManager: TimeManager
    var body: some View {
        HStack(spacing: 15) {
            HStack {
                Image(systemName: "timer").resizable().frame(width: 35, height: 30)
                Text(timeManager.tabNum == 0 ? "Do\nWork": "").fontWeight(.light).font(.system(size: 14))
            }
            .padding()
            .background(timeManager.tabNum == 0 ? Color.red.opacity(0.5): Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                timeManager.tabNum = 0
            }
            HStack {
                Image(systemName: "person.fill").resizable().frame(width: 30, height: 30)
                Text(timeManager.tabNum == 1 ? "User\nLog": "").fontWeight(.light).font(.system(size: 14))
            }
            .padding()
            .background(timeManager.tabNum == 1 ? Color.blue.opacity(0.5): Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                timeManager.tabNum = 1
            }
            HStack {
                Image(systemName: "questionmark").resizable().frame(width: 30, height: 30)
                Text(timeManager.tabNum == 2 ? "User\nGuide": "").fontWeight(.light).font(.system(size: 14))
            }
            .padding()
            .background(timeManager.tabNum == 2 ? Color.yellow.opacity(0.5): Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                timeManager.tabNum = 2
            }
            HStack {
                Image(systemName: "gearshape.fill").resizable().frame(width: 35, height: 30)
                Text(timeManager.tabNum == 3 ? "User\nSetup": "").fontWeight(.light).font(.system(size: 14))
            }
            .padding()
            .background(timeManager.tabNum == 3 ? Color.green.opacity(0.5): Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                if timeManager.duration == 0 {
                    self.timeManager.setTimer()
                }
                timeManager.tabNum = 3
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.orange)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(TimeManager())
    }
}
