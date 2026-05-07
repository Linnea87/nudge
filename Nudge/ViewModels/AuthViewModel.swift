//
//  AuthViewModel.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import FirebaseAuth
import Foundation

@Observable
final class AuthViewModel {

    //==== State =============================================

    private(set) var currentUser: User?
    private(set) var isLoading: Bool = false
    var errorMessage: String?

    private let authService: AuthServiceProtocol
    private var authListener: AuthStateDidChangeListenerHandle?

    //==== Init =============================================

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    //==== Bootstrap =============================================

    func bootstrap() {
        authListener = authService.addStateDidChangeListener {
            [weak self] user in
            Task { @MainActor in
                guard let self else { return }
                if user == nil || user?.displayName != nil {
                    self.currentUser = user
                }
            }
        }
    }

    //==== Sign In =============================================

    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            _ = try await authService.signIn(email: email, password: password)
        } catch {
            errorMessage = String(localized: "error_title")
        }

        isLoading = false
    }

    //==== Sign Up =============================================

    func signUp(email: String, password: String, name: String) async {
        isLoading = true
        errorMessage = nil

        do {
            currentUser = try await authService.signUp(
                email: email,
                password: password,
                name: name
            )
        } catch {
            errorMessage = String(localized: "error_save_failed")
        }

        isLoading = false
    }

    //==== Sign Out =============================================

    func signOut() {
        do {
            try authService.signOut()
        } catch {
            errorMessage = String(localized: "error_title")
        }
    }

    //==== User Info =============================================

    var displayName: String {
        currentUser?.displayName ?? ""
    }

    var userInitial: String {
        currentUser?.displayName?.prefix(1).uppercased().description ?? ""
    }

    var userId: String? {
        currentUser?.uid
    }

    var memberSince: String {
        guard let date = currentUser?.metadata.creationDate else { return "" }
        return date.formatted(.dateTime.month(.wide).year())
    }

    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return String(localized: "greeting_morning")
        case 12..<18: return String(localized: "greeting_afternoon")
        default: return String(localized: "greeting_evening")
        }
    }
}
