//
//  AppNavigation.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-04.
//

import SwiftUI

struct AppNavigation: View {

    @Environment(AuthViewModel.self) private var authVM
    @State private var selectedTab: Tab = .profile

    var body: some View {
        if authVM.currentUser != nil {
            switch selectedTab {
            case .profile: ProfileView(selectedTab: $selectedTab)
            case .stats:   StatsView(selectedTab: $selectedTab)
            case .habits:  HabitsView(selectedTab: $selectedTab)
            }
        } else {
            NavigationStack {
                SignInView()
            }
        }
    }
}
