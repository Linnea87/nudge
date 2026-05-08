import SwiftUI

struct AppNavigationView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM

    //==== State =============================================

    @State private var selectedTab: Tab = .profile

    //==== Body =============================================

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
