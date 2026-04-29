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

    //==== Init ===========================================

    init() {
        self.currentUser = Auth.auth().currentUser
    }

    //==== Sign In =============================================

    func signIn(email: String, password: String). async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
        } catch  {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
     //==== Sign Up =============================================

     func signUp(email: String, password: String) async {
         isLoading = true
         errorMessage = nil

         do {
             let result = try await Auth.auth().createUser(withEmail: email, password: password)
             currentUser = result.user
         } catch  {
             errorMessage = error.localizedDescription
         }

         isLoading = false
     }

      //==== Sign Out =============================================

      func signOut() {
          do {
              try Auth.auth().signOut()
              currentUser = nil
          } catch {
              errorMessage = error.localizedDescription
          }
      }
}
