//
//  SignUpView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

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

                //==== Header =============================================

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(String(localized: "auth_signup_title"))
                        .font(.system(size: FontSize.display, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)

                    HStack(spacing: Spacing.xs) {
                        Text(String(localized: "auth_signup_subtitle"))
                            .font(.system(size: FontSize.md))
                            .foregroundStyle(Theme.nudgeTextMuted)

                        Image(systemName: "heart.fill")
                            .font(.system(size: FontSize.md))
                            .foregroundStyle(Theme.nudgeAccentSoft)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                //==== Form =============================================

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

                //==== Create Account Button =============================================

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
