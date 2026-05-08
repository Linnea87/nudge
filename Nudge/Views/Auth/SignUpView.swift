import SwiftUI

struct SignUpView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM

    //==== State =============================================

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.xxl) {

                PrimaryHeaderView(
                    title: String(localized: "auth_signup_title"),
                    subtitle: String(localized: "auth_signup_subtitle")
                )

                VStack(spacing: Spacing.sm) {
                    InputFieldView(
                        icon: "person",
                        key: "auth_signup_name",
                        text: $name
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)

                    InputFieldView(
                        icon: "envelope",
                        key: "auth_signin_email",
                        text: $email
                    )
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                    InputFieldView(
                        icon: "lock",
                        key: "auth_signin_password",
                        text: $password,
                        isSecure: true
                    )
                }

                VStack(spacing: Spacing.md) {
                    PrimaryButtonView(
                        label: String(localized: "auth_signup_button"),
                        isLoading: authVM.isLoading
                    ) {
                        Task {
                            await authVM.signUp(email: email, password: password, name: name)
                        }
                    }

                    Text(String(localized: "auth_signup_terms"))
                        .font(.system(size: FontSize.xs))
                        .foregroundStyle(Theme.nudgeTextMuted)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.top, Spacing.lg)
        }
        .alert(
            String(localized: "error_title"),
            isPresented: Binding(
                get: { authVM.errorMessage != nil },
                set: { if !$0 { authVM.errorMessage = nil } }
            ),
            presenting: authVM.errorMessage
        ) { _ in
            Button(String(localized: "error_ok"), role: .cancel) { }
        } message: { message in
            Text(message)
        }
    }
}
