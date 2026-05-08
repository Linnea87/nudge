import SwiftUI

struct InputFieldView: View {

    //==== Properties =============================================

    let icon: String
    let key: String.LocalizationValue
    @Binding var text: String
    var isSecure: Bool = false

    //==== Body =============================================

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .foregroundStyle(Theme.nudgeTextMuted)

            Group {
                if isSecure {
                    SecureField("", text: $text, prompt: prompt)
                } else {
                    TextField("", text: $text, prompt: prompt)
                }
            }
            .foregroundStyle(Theme.nudgeTextPrimary)
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }

    //==== Private =============================================

    private var prompt: Text {
        Text(String(localized: key))
            .foregroundStyle(Theme.nudgeTextMuted)
    }
}
