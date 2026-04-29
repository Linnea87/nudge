//
//  NudgeApp.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI
import FirebaseCore

@main
struct NudgeApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
