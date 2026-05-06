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
    @State private var statsViewModel = StatsViewModel()
    
    init() {
        FirebaseApp.configure()
        _authViewModel = State(initialValue: AuthViewModel())
        _habitViewModel = State(initialValue: HabitViewModel(habitService: HabitService()))
    }

    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .environment(authViewModel)
                .environment(habitViewModel)
                .environment(statsViewModel)
                .task {
                    authViewModel.bootstrap()
                }
        }
    }
}
