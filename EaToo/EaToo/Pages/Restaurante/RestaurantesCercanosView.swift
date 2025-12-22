//
//  RestaurantesCercanosView.swift
//  EaToo
//
//  Created by Alumno on 24/11/25.
//

import GoogleMaps
import SwiftUI
import CoreLocation

import SwiftUI

// MARK: - RestaurantesCercanosView
struct RestaurantesCercanosView: View {
    // Recibe la lista de restaurantes cargados desde HomeView
    let restaurantes: [Restaurante]
    
    var body: some View {
        VStack {
            if restaurantes.isEmpty {
                ProgressView("Cargando datos de restaurantes...")
            } else {
                // Usar el componente que maneja Google Maps
                GoogleMapsView(restaurantes: restaurantes)
                    .ignoresSafeArea(.all, edges: .bottom)
            }
        }
        .navigationTitle("Ubicaciones de Restaurantes")
    }
}
