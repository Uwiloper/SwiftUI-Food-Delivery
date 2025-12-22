//
//  RegisterView.swift
//  EaToo
//
//  Created by Alumno on 13/10/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var fullName = ""
    @State private var emailOrPhone = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            BackgroundFade()
            
            NavigationStack {
                VStack(spacing: 24) {
                    
                    // Logo
                    Image("logo_eatoo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 40)
                    
                    Text("Crea tu cuenta")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    // 🔹 Full Name
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Nombre completo")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            TextField("Ingresa tu nombre", text: $fullName)
                                .autocapitalization(.words)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // 🔹 Email or Phone
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email o teléfono")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.gray)
                            TextField("Ingresa tu Numero de Telefono", text: $emailOrPhone)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // 🔹 Password
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contraseña")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                            SecureField("enterPassword", text: $password)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // 🔹 Register Button
                    NavigationLink("register", destination: LoginView())
                        .pillButtonPrimary()
                        .padding(.top, 12)
                    
                    // 🔹 Divider con OR
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.4))
                        Text("OR")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.4))
                    }
                    .padding(.vertical, 10)
                    
                    // 🔹 Social Media Icons
                    HStack(spacing: 24) {
                        Image("Facebook_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("Google_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("Tiktok_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.bottom, 20)
                    
                    // 🔹 Login Link
                    HStack {
                        Text("¿Ya tienes cuenta?")
                            .foregroundColor(.gray)
                        NavigationLink("login", destination: LoginView())
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                    }
                    
                }
                .padding(.horizontal, 24)
            }
            .navigationBarBackButtonHidden(true)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RegisterView()
}
