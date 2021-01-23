//
//  SoundListView.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/09.
//

import SwiftUI
import AudioToolbox

struct SoundListView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    let sounds: [Sound] = [
        Sound(id: 1151, soundName: "Beat"),
        Sound(id: 1304, soundName: "Alert"),
        Sound(id: 1309, soundName: "Glass"),
        Sound(id: 1310, soundName: "Horn"),
        Sound(id: 1313, soundName: "Bell"),
        Sound(id: 1314, soundName: "Electronic"),
        Sound(id: 1320, soundName: "Anticipate"),
        Sound(id: 1327, soundName: "Minuet"),
        Sound(id: 1328, soundName: "News Flash"),
        Sound(id: 1330, soundName: "Sherwood Forest"),
        Sound(id: 1333, soundName: "Telegraph"),
        Sound(id: 1334, soundName: "Tiptoes"),
        Sound(id: 1335, soundName: "Typewriterst"),
        Sound(id: 1336, soundName: "Update")
    ]
    
    var body: some View {
        List {
            ForEach(sounds) {sound in
                HStack {
                    Image(systemName: "speaker.2.fill")
                        .onTapGesture {
                            AudioServicesPlayAlertSoundWithCompletion(sound.id, nil)
                    }
                    //soundNameの値でリストに表示する
                    Text(("\(sound.soundName)"))
                    
                    Spacer()
                    
                    if self.timeManager.soundID == sound.id {
                        Image(systemName: "checkmark")
                    }
                }
                //HSStackを四角いオブジェクトとみなす
                .contentShape(Rectangle())
                //行をタップでサウンド選択(IDと名前をTimeManagerへ反映)
                .onTapGesture {
                    self.timeManager.soundID = sound.id
                    self.timeManager.soundName = sound.soundName
                    UserDefaults.standard.set(timeManager.soundName, forKey: "soundName")
                    UserDefaults.standard.set(timeManager.soundID, forKey: "soundID")
                }
            }
        }
        .navigationBarTitle("Alarm Sound Setting", displayMode: .automatic)
    }
}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        SoundListView()
            .environmentObject(TimeManager())
    }
}
