import SwiftUI

struct SignInView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM

    //==== State =============================================

    @State private var email: String = ""
    @State private var password: String = ""

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.lg) {

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Height.logo)
                    

                VStack(spacing: Spacing.md) {
                    InputFieldView(icon: "envelope", key: "auth_signin_email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    InputFieldView(icon: "lock", key: "auth_signin_password", text: $password, isSecure: true)

                    HStack {
                        Spacer()
                        Text(String(localized: "auth_signin_forgot"))
                            .font(.system(size: FontSize.sm))
                            .foregroundStyle(Theme.nudgeAccentLight)
                    }
                }

                PrimaryButtonView(
                    label: String(localized: "auth_signin_title"),
                    isLoading: authVM.isLoading
                ) {
                    Task {
                        await authVM.signIn(email: email, password: password)
                    }
                }

                Spacer()

                HStack(spacing: Spacing.xs) {
                    Text(String(localized: "auth_signin_no_account"))
                        .foregroundStyle(Theme.nudgeTextMuted)
                    NavigationLink(String(localized: "auth_signin_signup_link")) {
                        SignUpView()
                    }
                    .foregroundStyle(Theme.nudgeAccentLight)
                    .fontWeight(.semibold)
                }
                .font(.system(size: FontSize.sm))
                .padding(.bottom, Spacing.lg)
            }
            .padding(.horizontal, Spacing.lg)
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
