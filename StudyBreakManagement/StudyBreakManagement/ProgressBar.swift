//
//  ProgressBar.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/10.
//

import SwiftUI

struct ProgressBar: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @State var costomHueA = 0.5
    @State var costomHueB = 0.3
    
    var body: some View {
        ZStack{
            //背景の円
            Circle()
                .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
                .scaledToFit()
                .padding(15)
            
            Circle()
                .trim(from: 0, to: CGFloat(self.timeManager.duration / self.timeManager.maxValue))
                .stroke(self.makeGradientColor(hueA: costomHueA, hueB: costomHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                //輪郭線の開始位置を12時の方向にする
                .rotationEffect(Angle(degrees: -90))
                .padding(15)
        }
        .onReceive(timeManager.timer) { _ in
            if timeManager.timerStatus == .running {
                self.costomHueA += 0.005
                if self.costomHueA >= 1.0 {
                    self.costomHueA = 0.0
                }
                self.costomHueB += 0.005
                if self.costomHueB >= 1.0 {
                    self.costomHueB = 0.0
                }
            }
        }
    }
    func makeGradientColor (hueA: Double, hueB: Double) -> AngularGradient {
        let colorA = Color(hue: hueA, saturation: 0.75, brightness: 0.9)
        let colorB = Color(hue: hueB, saturation: 0.75, brightness: 0.9)
        let gradient = AngularGradient(gradient: .init(colors: [colorA, colorB, colorA]), center: .center, startAngle: .zero, endAngle: .init(degrees: 360))
        return gradient
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
