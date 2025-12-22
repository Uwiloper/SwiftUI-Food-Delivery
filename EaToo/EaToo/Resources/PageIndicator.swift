//
//  PageIndicator.swift
//  EaToo
//
//  Created by Alumno on 8/09/25.
//

import SwiftUI

struct PageIndicator: View {
    var total: Int                  // Número total de puntos
    var current: Int                // Índice del punto activo
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .fill(index == current ? Color.black : Color.gray.opacity(0.4))
                    .frame(width: 10, height: 10)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PageIndicator(total: 3, current: 0) // 1er punto activo
        PageIndicator(total: 3, current: 1) // 2do punto activo
        PageIndicator(total: 3, current: 2) // 3er punto activo
    }
    .padding()
}
