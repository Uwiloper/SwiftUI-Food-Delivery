//
//  MainContainer.swift
//  EaToo
//
//  Created by Alumno on 1/12/25.
//

import SwiftUI

struct MainContainerView: View {
    @State private var currentTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Tus Vistas
            TabView(selection: $currentTab) {
                HomeView().tag(Tab.home)
                FavoritosView().tag(Tab.favoritos)
                CartaView().tag(Tab.carrito)
                RestaurantesView().tag(Tab.carta)
                PerfilView().tag(Tab.perfil)
            }
            
            // Tu Barra Curva
            CustomNavBar(selectedTab: $currentTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        
        // --- AGREGA ESTO AL FINAL: Escuchar la señal "IrAPerfil" ---
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("IrAPerfil"))) { _ in
            self.currentTab = .perfil // ¡Esto cambia la pestaña visualmente!
        }
    }
}
