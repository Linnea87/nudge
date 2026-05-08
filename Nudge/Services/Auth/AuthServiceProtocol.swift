import FirebaseAuth
import Foundation

protocol AuthServiceProtocol {

    //==== Sign In =============================================

    func signIn(email: String, password: String) async throws -> User

    //==== Sign Up =============================================

    func signUp(email: String, password: String, name: String) async throws -> User

    //==== Sign Out =============================================

    func signOut() throws

    //==== Listener =============================================

    func addStateDidChangeListener(_ listener: @escaping (User?) -> Void) -> AuthStateDidChangeListenerHandle
}
