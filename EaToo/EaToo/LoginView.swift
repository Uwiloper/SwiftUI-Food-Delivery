//
//  LoginView.swift
//  EaToo
//
//  Created by Alumno on 22/09/25.
//

import SwiftUI

struct LoginView: View {
    @State private var fullName = ""
    @State private var emailOrPhone = ""
    @State private var password = ""
    
    var body: some View {
        ZStack{
            BackgroundFade()
            NavigationStack {
                VStack(spacing: 24) {
                    
                    
                    // Logo
                    Image("logo_eatoo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 40)
                    
                    Text("slogan")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    //  sFull Name
                    VStack(alignment: .leading, spacing: 6) {
                        Text("fullName")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            TextField("enterName", text: $fullName)
                                .autocapitalization(.words)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // Email or Phone
                    VStack(alignment: .leading, spacing: 6) {
                        Text("phoneNumber")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.gray)
                            TextField("enterPhone", text: $emailOrPhone)
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
                        Text("password")
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
                    
                    // Login Button
                    NavigationLink("Ingresar", destination: MainContainerView())
                        .pillButtonPrimary()
                        .padding(.top, 12)
                    
                    // Divider con OR
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
                    
                    // Social Media Icons
                    HStack(spacing: 24) {
                        Image("Facebook_icon")   // asegúrate de poner los iconos en Assets
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
                    
                    // Registrarse Link
                    HStack {
                        Text("DontHAccount")
                            .foregroundColor(.gray)
                        NavigationLink("signUp", destination: RegisterView())
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                    }
                    
                
                }
                .padding(.horizontal, 24)
            }.navigationBarBackButtonHidden(true)
               
        } .ignoresSafeArea() // para que el fondo llegue a toda la pantalla
    }
}

#Preview {
    LoginView()
}

