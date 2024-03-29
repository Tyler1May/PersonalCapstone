//
//  AuthController.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/12/24.
//

import SwiftUI
import FirebaseAuth
import Firebase
import CodableFirebase

class AuthController: ObservableObject {
    
    typealias Completion = (Bool, String) -> Void
    
    @Published var userSession: FirebaseAuth.User?
    @Published var email: String = ""
    
    
    private let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        if let email = self.userSession?.email {
            self.email = email
        }
        print("DEBUG: User session is \(String(describing: self.userSession))")
    }
    
    func login(email: String, password: String, _ comp: @escaping Completion) {
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to log in with error \(error.localizedDescription)")
                comp(false, error.localizedDescription)
                return
            }
            
            guard let user = result?.user else {
                print("DEBUG: Failed to get logged in user")
                comp(false, "Server Error")
                return
            }
            
            self.userSession = user
            self.email = email
            print("DEBUG: Logged in sucessfully")
            print("DEBUG: user is \(String(describing: self.userSession))")
        }
    }
    
    func register(email: String, password: String, _ comp: @escaping Completion) {
        Auth.auth().createUser(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                comp(false, error.localizedDescription)
                return
            }
            
            guard let user = result?.user else {
                print("DEBUG: Failed to get registered user")
                comp(false, "Server Error")
                return
            }
            
            self.userSession = user
            self.email = email
            print("DEBUG: Created user successfully")
            print("DEBUG: user is \(String(describing: self.userSession))")
            comp(true, "")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        userSession = nil
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
            } else {
                print("Password reset email sent successfully to \(email)")
            }
        }
    }
}
