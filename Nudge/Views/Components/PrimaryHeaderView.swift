import SwiftUI

struct PrimaryHeaderView: View {

    //==== Properties =============================================

    let title: String
    let subtitle: String
    var subtitleIcon: String = "heart"
    var onDismiss: (() -> Void)? = nil
    var onAdd: (() -> Void)? = nil
    var trailingText: String? = nil
    var trailingColor: Color = Theme.nudgeTextMuted

    //==== Body =============================================

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)

                HStack(spacing: Spacing.xs) {
                    Text(subtitle)
                        .font(.system(size: FontSize.md))
                        .foregroundStyle(Theme.nudgeAccentSoft)
                    Image(systemName: subtitleIcon)
                        .font(.system(size: IconSize.xs))
                        .foregroundStyle(Theme.nudgeAccentSoft)
                }
            }

            Spacer()

            if let trailingText {
                Text(trailingText)
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(trailingColor)
            }

            if let onAdd {
                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: IconSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }

            if let onDismiss {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: IconSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
