//
//  MyProfile.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2021/01/18.
//

import SwiftUI

struct MyProfile: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ScrollView {
            VStack {
                Text("\n製作者情報\n")
                    .font(.title)
                HStack {
                    Text(" ◆自己紹介\n")
                        .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                    Spacer()
                }
                Text("はじめまして〜、あさいーと言います。愛称のイメージはアサイードリンクです。\n\n")
                HStack {
                    Text("さてさて、ついに出してしまいました。私の初めてのアプリです。完璧にやりたいことができたとは言えないけど、私の学習時のコツを詰め込んだアプリになりました。\nバグとか全然あると思います。探してみてください。この世のすべてを置いてきました(白目)")
                    Spacer()
                }
                HStack {
                    Text("\nバグの報告とか、アドバイスとか、追加してほしいこととかあったら、何かしらで伝えていただければ対応します。あ...Twitterとかフォローしていただけると嬉しいです。(みんなと繋がりたいなぁ)\n")
                    Spacer()
                }
                HStack {
                    Text("\nうちの子をよろしくおねがいします。\n")
                    Spacer()
                }
                HStack {
                    Text("\n")
                    Spacer()
                }
                HStack {
                    Text(" ◆製作者のSNS\n")
                        .font(.system(size: self.screenWidth * 0.08, weight: .thin, design: .monospaced))
                    Spacer()
                }
                HStack {
                    Text("\ntwitter: @asaii_tone\n")
                    Spacer()
                }
                HStack {
                    Text("まだ↑しかないですぅ〜ごぺんなさい...。\nサイトやQiitaなど作成予定なので、よろしくおねがいします。")
                    Spacer()
                }
            }
        }
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile()
    }
}
