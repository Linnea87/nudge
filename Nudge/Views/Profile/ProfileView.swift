import SwiftUI

struct ProfileView: View {

    //==== Properties =============================================

    @Binding var selectedTab: Tab

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                HeroView(
                    userInitial: authVM.userInitial,
                    displayName: authVM.displayName,
                    memberSince: authVM.memberSince,
                    onSignOut: { authVM.signOut() }
                )
                .padding(Spacing.lg)

                PrimaryHeaderView(
                    title: authVM.greetingMessage,
                    subtitle: habitVM.motivationMessage
                )
                .padding(.horizontal, Spacing.lg)

                CategoryListView(
                    habitsByCategory: habitVM.habitsByCategory,
                    onCheckIn: { habit in Task { await habitVM.checkIn(habit) } }
                )

                TabBarView(selectedTab: $selectedTab)
            }
        }
        .task {
            guard let userId = authVM.userId else { return }
            await habitVM.fetchHabits(for: userId)
        }
        .alert(
            String(localized: "error_title"),
            isPresented: Binding(
                get: { habitVM.errorMessage != nil },
                set: { if !$0 { habitVM.errorMessage = nil } }
            ),
            presenting: habitVM.errorMessage
        ) { _ in
            Button(String(localized: "error_ok"), role: .cancel) { }
        } message: { errorMessage in
            Text(errorMessage)
        }
    }
}
