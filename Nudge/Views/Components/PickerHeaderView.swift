import SwiftUI

struct PickerHeaderView: View {

    //==== Properties =============================================

    let label: String
    let isExpanded: Bool
    var leadingIcon: String? = nil
    let action: () -> Void

    //==== Body =============================================

    var body: some View {
        Button(action: action) {
            PrimaryCardView {
                HStack {
                    if let leadingIcon {
                        Image(systemName: leadingIcon)
                            .font(.system(size: IconSize.md))
                            .foregroundStyle(Theme.nudgeAccentLight)
                    }
                    Text(label)
                        .font(.system(size: FontSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
