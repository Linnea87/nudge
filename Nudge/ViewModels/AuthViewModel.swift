//
//  AuthViewModel.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation
import FirebaseAuth

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
        authListener = authService.addStateDidChangeListener { [weak self] user in
            Task { @MainActor in
                self?.currentUser = user
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

    func signUp(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            _ = try await authService.signUp(email: email, password: password, name: name)
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
        currentUser?.displayName ?? String(localized: "app_name")
    }

    var userInitial: String {
        currentUser?.displayName?.prefix(1).uppercased().description ?? String(localized: "app_name").prefix(1).uppercased().description
    }
    
    var userId: String? {
        currentUser?.uid
    }
}
