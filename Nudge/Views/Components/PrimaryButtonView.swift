import SwiftUI

struct PrimaryButtonView: View {

    //==== Properties =============================================

    let label: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    //==== Body =============================================

    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView()
                        .tint(Theme.nudgeTextPrimary)
                } else {
                    Text(label)
                        .font(.system(size: FontSize.lg, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: Height.button)
            .background(isDisabled ? Theme.nudgeTextMuted : Theme.nudgeAccent)
            .clipShape(RoundedRectangle(cornerRadius: Radius.full))
        }
        .disabled(isDisabled || isLoading)
    }
}
