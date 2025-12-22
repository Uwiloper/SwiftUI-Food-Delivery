//
//  CustomNavBar.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import SwiftUI

// Definimos los Tabs (Pestañas) disponibles en la app
enum Tab: String, CaseIterable {
    case home = "house.fill"
    case favoritos = "heart.fill"
    case carrito = "cart.fill"      // Botón central
    case carta = "storefront.fill"  // Tiendita / Restaurantes
    case perfil = "person.fill"
}

struct CustomNavBar: View {
    @Binding var selectedTab: Tab
    
    // CORREGIDO: Usamos 'let' en lugar de 'private var' para evitar el error de acceso
    let brandColor: Color = Color("PrimaryColor") // Asegúrate de tener este color en Assets, o usa .red
    
    var body: some View {
        HStack(spacing: 0) {
            // --- Lado Izquierdo ---
            TabBarButton(tab: .home, selectedTab: $selectedTab)
            TabBarButton(tab: .favoritos, selectedTab: $selectedTab)
            
            // --- Espacio central para la curva ---
            Spacer(minLength: 0)
            
            // --- Lado Derecho ---
            TabBarButton(tab: .carta, selectedTab: $selectedTab)
            TabBarButton(tab: .perfil, selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        // Padding inferior para respetar el área segura del iPhone (Home Indicator)
        .padding(.bottom, 34)
        .padding(.top, 10)
        .background(Color.white)
        // Aplicamos la forma curva personalizada
        .clipShape(CurvedShape())
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: -5)
        .overlay(
            // --- Botón Flotante Central (Carrito) ---
            Button(action: {
                withAnimation { selectedTab = .carrito }
            }) {
                Image(systemName: "cart.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .background(brandColor)
                    .clipShape(Circle())
                    .shadow(color: brandColor.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .offset(y: -50) // Lo subimos para que flote
            , alignment: .top
        )
    }
}

// Subvista: Botón individual de la barra
struct TabBarButton: View {
    var tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        GeometryReader { geo in
            if tab == .carrito {
                Color.clear // Espacio invisible, el botón real está en el overlay
            } else {
                Button(action: {
                    withAnimation { selectedTab = tab }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.rawValue)
                            .font(.system(size: 24))
                            // Color: PrimaryColor si está seleccionado, Gris si no
                            .foregroundColor(selectedTab == tab ? Color("PrimaryColor") : .gray)
                        
                        // Opcional: Puntito indicador si está seleccionado
                        if selectedTab == tab {
                            Circle()
                                .fill(Color("PrimaryColor"))
                                .frame(width: 4, height: 4)
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
        .frame(height: 50)
    }
}

// Subvista: La forma matemática de la curva
struct CurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            // 1. Dibujamos el rectángulo base
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // 2. Dibujamos el "mordisco" (cutout) central
            let center = rect.width / 2
            path.move(to: CGPoint(x: 0, y: 0))
            
            path.addLine(to: CGPoint(x: center - 50, y: 0))
            path.addCurve(
                to: CGPoint(x: center + 50, y: 0),
                control1: CGPoint(x: center - 30, y: 35), // Curvatura bajando
                control2: CGPoint(x: center + 30, y: 35)  // Curvatura subiendo
            )
        }
    }
}
