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
    @State private var habitViewModel: HabitViewModel


    init() {
        FirebaseApp.configure()
        _authViewModel = State(initialValue: AuthViewModel())
        _habitViewModel = State(initialValue: HabitViewModel(habitService: HabitService()))

    }

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.currentUser != nil {
                    ProfileView()
                } else {
                    NavigationStack {
                        SignInView()
                    }
                }
            }
            .environment(authViewModel)
            .environment(habitViewModel)
            .task {
                authViewModel.bootstrap()
            }
        }
    }
}
