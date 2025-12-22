//
//  AdminCardView.swift
//  EaToo
//
//  Created by Alumno on 27/10/25.
//

import SwiftUI

struct AdminCardView: View {
    var title: String
    var subtitle: String
    var iconName: String
    var color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 60, height: 60)
                Image(systemName: iconName)
                    .foregroundColor(color)
                    .font(.system(size: 28))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


