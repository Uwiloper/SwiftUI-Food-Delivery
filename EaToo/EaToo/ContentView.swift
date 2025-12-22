import SwiftUI

struct ContentView: View {
    
    // Estado para el índice actual del tip (0, 1, 2)
        @State private var currentTip = 0
        
        // Datos para los tips FALTA
        let images = ["tip1", "tip2", "tip3"]
        let titles = ["titulo1", "titulo2", "titulo3"]
        let phrases = ["frase1", "frase2", "frase3"]
       
    var body: some View {
        
        
        ZStack {
            
            //BackgroundFade()  // Fondo degradado
            
            NavigationStack {
                VStack {
                    // Foto importada
                    Image("tip1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                    
                    PageIndicator(total: 3, current: 0)
                }
                
                VStack {
                    Text("titulo1")
                        //.appFont(.largeTitle)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .frame(width: 4000)
                    
                    Text("frase1")
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                }
                
                VStack {
                    // Botón con flecha
                    NavigationLink("→",
                                   destination: IntroductionView())
                        .pillButtonPrimary()
                    
                    // Texto Skipear/Saltar
                    Text("saltar")
                }
                .padding()
            }
        }
        .ignoresSafeArea() // que el fondo cubra toda la pantalla
    }
}

#Preview {
    ContentView()
}
