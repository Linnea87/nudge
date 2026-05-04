import Foundation
import FirebaseAuth

final class AuthService: AuthServiceProtocol {

    func signIn(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }

    func signUp(email: String, password: String, name: String) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        try await result.user.reload()
        return Auth.auth().currentUser ?? result.user
    }   

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func addStateDidChangeListener(_ listener: @escaping (User?) -> Void) -> AuthStateDidChangeListenerHandle {
        Auth.auth().addStateDidChangeListener { _, user in
            listener(user)
        }
    }
}
