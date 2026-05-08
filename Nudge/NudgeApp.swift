import FirebaseCore
import SwiftUI

@main
struct NudgeApp: App {

    //==== State =============================================

    @State private var authViewModel: AuthViewModel
    @State private var habitViewModel: HabitViewModel
    @State private var statsViewModel = StatsViewModel()

    //==== Init =============================================

    init() {
        FirebaseApp.configure()
        _authViewModel = State(initialValue: AuthViewModel())
        _habitViewModel = State(initialValue: HabitViewModel(habitService: HabitService()))
    }

    //==== Body =============================================

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
