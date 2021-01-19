//
//  Data.swift
//  StudyBreakManagement
//
//  Created by 浅井隆佳 on 2020/12/06.
//

import SwiftUI
import AudioToolbox

enum TimeFormat {
    case hr
    case min
    case sec
}
enum TimerStatus {
    case running
    case pause
    case stopped
}
enum StudyBreakStatus {
    case sw
    case tm
}

struct Sound: Identifiable {
    let id: SystemSoundID
    let soundName: String
}

