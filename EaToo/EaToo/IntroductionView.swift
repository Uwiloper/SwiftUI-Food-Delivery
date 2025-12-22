import SwiftUI

struct IntroductionView: View {
    var body: some View {
        ZStack {
            BackgroundFade()  // Fondo degradado abajo
            
            NavigationStack {
                VStack(spacing: 15) {
                    Spacer() // empuja hacia abajo
                    
                    Image("logo_eatoo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                    
                    Text("slogan")
                    
                    Spacer() // empuja hacia arriba
                }
                
                Spacer() // empuja hacia abajo
                
                HStack(spacing: 30) {
                    // Botón de Registrarse
                    NavigationLink("signUp",
                                   destination: RegisterView())
                        .pillButtonSecondary()
                    
                    // Botón de Ingresar
                    NavigationLink("login",
                                   destination: LoginView())
                        .pillButtonPrimary()
                }
                
                HStack {
                    NavigationLink("modoAdministrador",
                                   destination: AdminMenuView())
                        
                }
                .padding()
            }
        }.navigationBarBackButtonHidden(true)
        .ignoresSafeArea() // para que el fondo llegue a toda la pantalla
    }
}

#Preview {
    IntroductionView()
}
