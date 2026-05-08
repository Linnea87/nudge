import FirebaseAuth
import Foundation

final class AuthService: AuthServiceProtocol {

    //==== Sign In =============================================

    func signIn(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }

    //==== Sign Up =============================================

    func signUp(email: String, password: String, name: String) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        return Auth.auth().currentUser ?? result.user
    }

    //==== Sign Out =============================================

    func signOut() throws {
        try Auth.auth().signOut()
    }

    //==== Listener =============================================

    func addStateDidChangeListener(_ listener: @escaping (User?) -> Void) -> AuthStateDidChangeListenerHandle {
        Auth.auth().addStateDidChangeListener { _, user in
            listener(user)
        }
    }
}
