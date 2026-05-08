import SwiftUI

struct NameFieldView: View {

    //==== Properties =============================================

    @Binding var text: String

    //==== Body =============================================

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "pencil")
                .foregroundStyle(Theme.nudgeTextMuted)
            TextField("", text: $text, prompt:
                Text(String(localized: "habits_name_placeholder"))
                    .foregroundStyle(Theme.nudgeTextMuted)
            )
            .foregroundStyle(Theme.nudgeTextPrimary)
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
