//
//  UseGuydeView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/30.
//

import SwiftUI

struct UseGuydeView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ScrollView {
            VStack {
                Text("\nアプリの使用方法\n")
                    .font(.title)
                HStack {
                    Text(" ◆基本操作\n")
                        .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                    Spacer()
                }
                Text("目的：休憩時間を決めることで、休憩から抜け出してやるべきことをできるようになる。\n\n")
                HStack {
                    Text("手順: ")
                    Spacer()
                }
                HStack {
                    Text("\n1. 休憩時間を決めましょう(初期設定: 10分)\n　※変更は設定タブからできます。\n")
                    Spacer()
                }
                HStack {
                    Text("2. 勉強や活動ができるように準備しましょう。\n\n3. \"Do work\"タブで開始ボタンを押下して、活動を開始しましょう。ストップウォッチが動作してあなたの活動実施時間をカウントします。\n\n4. 休憩する場合は\"休憩する\"ボタンを押下しましょう。設定した休憩時間でタイマーが起動します。\n\n5. タイマーが終わる前に休憩を終える場合は\"活動する\"ボタン、アラームが鳴った場合は\"開始\"ボタンを押下しましょう\n\n6. 手順の3〜5を繰り返して活動や学習をしましょう。\"終了\"ボタン押下で活動を終了します。カウントした活動時間は\"My Log\"タブに表示されます。\n※\"My Log\"タブの説明は下記\"学習履歴の見方\"で説明します。\n")
                    Spacer()
                }
                HStack {
                    Text(" ◆学習履歴の見方\n")
                        .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                    Spacer()
                }
                HStack {
                    Text("\n1. トータル実行時間: リセットボタンを押下してからの活動時間を合算したものが表示されます。 \n\n2. 前回実行時間: 前回の実行時間 (開始ボタンを押してから終了ボタンを押すまで)が表示されます。\n")
                    Spacer()
                }
            }
        }
    }
}

struct UseGuydeView_Previews: PreviewProvider {
    static var previews: some View {
        UseGuydeView()
    }
}
