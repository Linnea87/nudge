import SwiftUI

struct PrimaryCardView<Content: View>: View {

    //==== Properties =============================================

    @ViewBuilder let content: () -> Content

    //==== Body =============================================

    var body: some View {
        content()
            .padding(Spacing.lg)
            .background(Theme.nudgeCard)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
