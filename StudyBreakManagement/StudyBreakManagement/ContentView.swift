//
//  ContentView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/03.
//

import SwiftUI

struct ContentView: View {
    
    var stopWatchManager = StopWatchManager()
    
    var body: some View {
        VStack {
            Text(String(format:"%.1f",stopWatchManager.sumStadyTime))
                .font(.custom("Futura", size: 50))
                .padding()
            Button(action: {self.stopWatchManager.start()}) {
                ExtractedView(label: "Start", buttonColor: .yellow, textColor: .black)
            }
            //Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    var label:String
    var buttonColor:Color
    var textColor:Color
    
    var body: some View {
        Text(label)
            .foregroundColor(textColor)
            .background(buttonColor)
            .cornerRadius(10)
    }
}
