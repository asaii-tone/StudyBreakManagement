//
//  GuydeView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/30.
//

import SwiftUI

struct GuydeView: View {
    //モーダルシートを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Image(systemName: "person.fill.questionmark")
                    .font(.title)
                Text("アプリの情報です")
                    .font(.title)
                Image(systemName: "mustache.fill")
                    .font(.title)
            }
            .edgesIgnoringSafeArea(.horizontal)
            NavigationView{
                Form {
                    Section(header: Text("使用方法:")){
                        NavigationLink(destination: EasyUseGuydeView()){
                            HStack {
                                //設定項目名
                                Image(systemName: "face.smiling")
                                    .foregroundColor(.blue)//前面のカラーを指定
                                Text("超ざっくりの使用方法")
                                Image(systemName: "face.smiling")
                                    .foregroundColor(.blue)//前面のカラーを指定
                            }
                        }
                        NavigationLink(destination: UseGuydeView()){
                            HStack {
                                //設定項目名
                                Text("アプリの使用方法 (詳細に)")
                            }
                        }
                    }
                    Section(header: Text("コラム:")) {
                        NavigationLink(destination: ColumnView()){
                            HStack {
                                //設定項目名
                                Text("欲に負けないためには?")
                            }
                        }
                    }
                    Section(header: Text("製作者情報:")) {
                        NavigationLink(destination: MyProfile()){
                            HStack {
                                //設定項目名
                                Text("はじめまして、あさいーです。")
                            }
                        }
                    }
                }
                //.navigationBarTitle("アプリ情報", displayMode: .automatic)
                .navigationViewStyle(DefaultNavigationViewStyle())
            }
        }
    }
}

struct GuydeView_Previews: PreviewProvider {
    static var previews: some View {
        GuydeView().environmentObject(TimeManager())
    }
}
