//
//  AnimationView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/13.
//

import SwiftUI

struct AnimationView: View {
    @EnvironmentObject var timeManager: TimeManager
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State var costomHueA: Double = 0.5
    @State var costomHueB: Double = 0.3
    @State var clockwise = true
    @State var count: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 20, height: 20)
                .offset(y: -self.screenWidth * 0.38)
                .foregroundColor(Color(hue: self.costomHueA, saturation: 1.0, brightness: 1.0, opacity: 0.5))
                .rotationEffect(.degrees(clockwise ? 0 : 360))
            Circle()
                .frame(width: 20, height: 20)
                .offset(y: -self.screenWidth * 0.38)
                .foregroundColor(Color(hue: self.costomHueB, saturation: 1.0, brightness: 1.0, opacity: 0.5))
                .rotationEffect(.degrees(clockwise ? 360 : 0))
        }
        .onReceive(timeManager.timer) { _ in
            if self.count <= 0 {
                self.clockwise.toggle()
            }
            if self.count < 5.00 {
                self.count += 0.1
            } else {
                self.count = 0
            }
            
            self.costomHueA += 0.005
            if self.costomHueA >= 1.0 {
                self.costomHueA = 0.0
            }
            self.costomHueB += 0.005
            if self.costomHueB >= 1.0 {
                self.costomHueB = 0.0
            }
        }
        .animation(.easeInOut(duration: 5))
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView().environmentObject(TimeManager())
    }
}
