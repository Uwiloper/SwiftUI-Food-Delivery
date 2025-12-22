//
//  EaTooApp.swift
//  EaToo
//
//  Created by Alumno on 8/09/25.
//

import SwiftUI
import GoogleMaps
import Foundation

enum AppFont {
    case largeTitle
    case headline
    case body
}

// 2. Define una única clave de entorno para todas las fuentes personalizadas
private struct AppFontKey: EnvironmentKey {
    static let defaultValue: [AppFont: Font] = [:]
}

extension EnvironmentValues {
    var appFonts: [AppFont: Font] {
        get { self[AppFontKey.self] }
        set { self[AppFontKey.self] = newValue }
    }
}

// 3. Aplica los estilos en la vista principal
@main
struct Sistema_UnoApp: App {
    // Conecta el AppDelegate a la aplicación
        @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        
        // Gestores de datos (Mantienes los tuyos)
        @StateObject var apiManager = UsuariosApiManager()
        @StateObject var restaurantesApi = RestaurantesApiManager()
        
        // Nota: El gestor de restaurantes que usa la HomeView (GestorDatosRestaurantes)
        // probablemente debería ser compartido como EnvironmentObject si se usa en otras partes.

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(apiManager)
                    .environmentObject(restaurantesApi)
                    
                    // Configuración de fuentes (Mantienes la tuya)
                    .environment(\.appFonts, [
                        // Por revisar las fuentes
                        .body: .custom("Inter_18pt-Regular", size: 16),
                        .headline: .custom("Inter_18pt-Light", size: 32),
                        .largeTitle: .custom("Inter_18pt-Bold", size: 40),
                    ])
                    .font(.custom("Inter_18pt-Regular", size: 16))
            }
        }
    }

// Necesitas la clave de API de Google Maps. Usamos la clave que proporcionaste.
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any ]?) -> Bool {
        // Inicialización del SDK de Google Maps
        // NOTA: Asegúrate de que esta clave sea válida y secreta en tu proyecto real.
        GMSServices.provideAPIKey("AIzaSyB6OL3ExVPUzp9ZTfaGbXgQ7BepbmdYcYw")
        return true
    }
}

// 4. En un solo modificador para aplicar cualquier estilo de fuente
struct AppFontModifier: ViewModifier {
    @Environment(\.appFonts) var appFonts
    let style: AppFont
    
    func body(content: Content) -> some View {
        if let font = appFonts[style] {
            content.font(font)
        } else {
            content
        }
    }
}

extension View {
    func appFont(_ style: AppFont) -> some View {
        self.modifier(AppFontModifier(style: style))
    }
}


//Boton principal
struct PillButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, AppDimensions.padding_large)      // Espaciado horizontal
            .padding(.vertical, AppDimensions.padding_medium)       // Espaciado vertical
            .background(Color("PrimaryColor"))                      // Color de fondo
            .foregroundColor(Color("SecondaryColor"))               // Color del texto
            .clipShape(Capsule())                                   // Forma de píldora
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 3) //sombra
    }
}

extension View {
    func pillButtonPrimary() -> some View {
        self.modifier(PillButtonModifier())
    }
}


//Boton Secundario
struct PillButtonSecondaryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, AppDimensions.padding_large)
            .padding(.vertical, AppDimensions.padding_medium)
            .background(Color("SecondaryColor"))                    // Invertido
            .foregroundColor(Color.black)                 // Texto en color primario
            .clipShape(Capsule())
            
            .shadow(color: Color.primary.opacity(0.2), radius: 4, x: 0, y: 3) //sombra
    }
}


extension View {
    func pillButtonSecondary() -> some View {
        self.modifier(PillButtonSecondaryModifier())
    }
}
