//
//  SignInView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct SignInView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var vm

    //==== State =============================================

    @State private var email: String = ""
    @State private var password: String = ""

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.xl) {

                //==== Logo =============================================

                VStack(spacing: Spacing.sm) {
                    ZStack {
                        Circle()
                            .fill(Theme.nudgeAccent)
                            .frame(width: IconSize.avatar, height: IconSize.avatar)
                        Image(systemName: "sparkles")
                            .font(.system(size: IconSize.xl))
                            .foregroundStyle(Theme.nudgeTextPrimary)
                    }
                    Text(String(localized: "app_name"))
                        .font(.system(size: FontSize.xxl, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)
                    Text(String(localized: "app_tagline"))
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
                .padding(.top, Spacing.xxl)
                .padding(.bottom, Spacing.xl)

                //==== Form =============================================

                VStack(spacing: Spacing.sm) {
                    InputField(icon: "envelope", key: "auth_signin_email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    InputField(icon: "lock", key: "auth_signin_password", text: $password, isSecure: true)

                    HStack {
                        Spacer()
                        Text(String(localized: "auth_signin_forgot"))
                            .font(.system(size: FontSize.sm))
                            .foregroundStyle(Theme.nudgeAccentLight)
                    }
                }

                //==== Sign In Button =============================================

                Button {
                    Task {
                        await vm.signIn(email: email, password: password)
                    }
                } label: {
                    Group {
                        if vm.isLoading {
                            ProgressView()
                                .tint(Theme.nudgeTextPrimary)
                        } else {
                            Text(String(localized: "auth_signin_title"))
                                .font(.system(size: FontSize.lg, weight: .bold))
                                .foregroundStyle(Theme.nudgeTextPrimary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: Spacing.buttonHeight)
                    .background(Theme.nudgeAccent)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.full))
                }

                Spacer()

                //==== Sign Up Link =============================================

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
                get: { vm.errorMessage != nil },
                set: { if !$0 { vm.errorMessage = nil } }
            ),
            presenting: vm.errorMessage
        ) { _ in
            Button(String(localized: "error_ok"), role: .cancel) { }
        } message: { message in
            Text(message)
        }
    }
}
