//
//  AuthViewModel.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation
import FirebaseAuth

@Observable
class AuthViewModel {

    //==== State =============================================

    var currentUser: User?
    var errorMessage: String?
    var isLoading: Bool = false

    private let authService = FirebaseService()
    private var authListener: AuthStateDidChangeListenerHandle?

    //==== Init ===========================================

   init() {
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
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
            _ = try await authService.signUp(email: email, password: password)
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
}
