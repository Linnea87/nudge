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
    
    @State private var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Group {
                    if authViewModel.currentUser != nil {
                        // Placeholder until main views are implemented
                        Text(String(localized: "app_name"))
                    } else {
                        SignInView()
                    }
                }
            }
            .environment(authViewModel)
        }
    }
}