import SwiftUI

struct HeroView: View {

    //==== Properties =============================================

    let userInitial: String
    let displayName: String
    let memberSince: String
    let onSignOut: () -> Void

    //==== Body =============================================

    var body: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(Theme.nudgeAccent)
                    .frame(width: IconSize.profileAvatar, height: IconSize.profileAvatar)
                Text(userInitial)
                    .font(.system(size: FontSize.lg, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
            }

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(displayName)
                    .font(.system(size: FontSize.xl, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)

                Text("\(String(localized: "profile_member_since")) \(memberSince)")
                    .font(.system(size: FontSize.xs))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }

            Spacer()

            Button(action: onSignOut) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
        }
    }
}
