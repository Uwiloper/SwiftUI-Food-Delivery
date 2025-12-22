//
//  AdminMenuView.swift
//  EaToo
//
//  Created by Alumno on 27/10/25.
//

import SwiftUI

struct AdminMenuView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundFade()
                
                VStack(spacing: 30) {
                    
                    // Encabezado
                    VStack(spacing: 8) {
                        Image("logo_eatoo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                        
                        Text("Panel de Administración")
                            .font(.title2).bold()
                            .foregroundColor(.orange)
                        
                        Text("Gestione los datos del sistema")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    
                    // Tarjetas
                    VStack(spacing: 22) {
                        
                        NavigationLink(destination: UsuarioView()) {
                            AdminCardView(
                                title: "Usuarios",
                                subtitle: "Gestionar cuentas de usuario",
                                iconName: "person.3.fill",
                                color: .blue
                            )
                        }

                        NavigationLink(destination: RestauranteView()) {
                            AdminCardView(
                                title: "Restaurantes",
                                subtitle: "Administrar restaurantes registrados",
                                iconName: "fork.knife.circle.fill",
                                color: .green
                            )
                        }


                        NavigationLink(destination: ProductosView()) {
                            AdminCardView(
                                title: "Productos",
                                subtitle: "Controlar catálogo de productos",
                                iconName: "cart.fill",
                                color: .orange
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Volver
                    NavigationLink(destination: IntroductionView()) {
                        HStack {
                            Image(systemName: "arrow.backward.circle.fill")
                            Text("Volver al Inicio")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AdminMenuView()
}
