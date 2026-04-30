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

    @State private var authViewModel: AuthViewModel

    init() {
        FirebaseApp.configure()
        _authViewModel = State(initialValue: AuthViewModel())
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.currentUser != nil {
                    Text(String(localized: "app_name"))
                } else {
                    NavigationStack {
                        SignInView()
                    }
                }
            }
            .environment(authViewModel)
            .task {
                authViewModel.bootstrap()
            }
        }
    }
}