//
//  EasyUseGuydeView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2021/01/10.
//

import SwiftUI

struct EasyUseGuydeView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("超簡単に説明してみる")
                        .font(.title)
                    Image(systemName: "sparkles")
                        .foregroundColor(.yellow)
                        .font(.title)
                    Text("\n")
                        .font(.title)
                }
                HStack {
                    Text("◆アプリを利用する目的:\n 学習後の休憩を10分に決めて、色々な誘惑に勝ちましょう！！\n1秒でも学習できたらいつでも休憩して良いです。とにかく学習を習慣づけましょう\n")
                }
                
                HStack {
                    Text("◆学習開始:\n学習することを用意したら、\"開始ボタン\"をポチッとしましょう。休憩したいときは\"休憩ボタン\"をポチッとです\n")
                    Spacer()
                }
                HStack {
                    Text("◆学習終了:\n学習を終えるときは\"終了ボタン\"をポチッとしましょう。\"User Log\"タブで学習履歴が見れますよ！\n")
                    Spacer()
                }
                HStack {
                    Text("以上です。自分を磨いて好きになりましょー！！\n")
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
        }
    }
}

struct EasyUseGuydeView_Previews: PreviewProvider {
    static var previews: some View {
        EasyUseGuydeView()
    }
}
