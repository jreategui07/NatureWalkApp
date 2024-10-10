//
//  LoginScreen.swift
//  Group05_Nature-Walk
//
//  Created by Jonathan Reátegui on 2024-10-09.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var presentSessionsListScreen: Bool = false
    
    @ObservedObject var loginManager: LoginManager
    @State var email = ""
    @State var password = ""
    @State var rememberMe = false
    @State var loginFailed = false

    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        Image("banner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())

                    Section {
                        TextField("Email", text: $email)
                            .keyboardType(.default)
                            .padding()
                        
                        SecureField("Password", text: $password)
                            .keyboardType(.default)
                            .padding()

                        Toggle("Remember Me", isOn: $rememberMe)
                            .padding()
                    }

                    Section {
                        Button {
                            login()
                        } label: {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .cornerRadius(10)
                        }
                        .disabled(email.isEmpty || password.isEmpty)
                        .alert(isPresented: $loginFailed) {
                            Alert(
                                title: Text("Sign In Failed"),
                                message: Text("Invalid email or password"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(0)
            .navigationTitle("Welcome to Nature Walk")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $presentSessionsListScreen) {
                SessionsListScreen(loginManager: loginManager, isLoggedIn: true)
            }
            .onAppear {   
                loadSavedCredentials()
            }
        }
    }

    private func login() {
        if loginManager.validateCredentials(email: email, password: password) {
            if rememberMe {
                loginManager.saveCredentials(email: email, password: password)
            } else {
                loginManager.clearCredentials()
            }
            loginManager.currentUser = User(email: email, password: password)
            presentSessionsListScreen = true
        } else {
            loginFailed = true
        }
    }

    private func loadSavedCredentials() {
        if let savedCredentials = loginManager.loadCredentials() {
            email = savedCredentials.email
            password = savedCredentials.password
            rememberMe = true
        }
    }
}

#Preview {
    let loginManager = LoginManager()
    // simulating saved user credentials
    UserDefaults.standard.set("test@gmail.com", forKey: "savedEmail")
    UserDefaults.standard.set("test123", forKey: "savedPassword")
    UserDefaults.standard.set(true, forKey: "rememberMe")
    return LoginScreen(loginManager: loginManager)
}

#Preview {
    let loginManager = LoginManager()
    // simulating saved user credentials
    UserDefaults.standard.set("admin@gmail.com", forKey: "savedEmail")
    UserDefaults.standard.set("admin123", forKey: "savedPassword")
    UserDefaults.standard.set(true, forKey: "rememberMe")
    return LoginScreen(loginManager: loginManager)
}

#Preview {
    let loginManager = LoginManager()
    // simulating unsaved user credentials
    UserDefaults.standard.removeObject(forKey: "savedEmail")
    UserDefaults.standard.removeObject(forKey: "savedPassword")
    UserDefaults.standard.set(false, forKey: "rememberMe")
    return LoginScreen(loginManager: loginManager)
}
