//
//  Style.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 24/9/2025.
//

import Foundation
import SwiftUI

extension View {
    func borderWithRadius(
        _ cornerRadius: CGFloat,
        _ borderColor: Color,
        _ lineWidth: CGFloat,
        _ padding: CGFloat,
        _ backgroundColor: Color) -> some View {
            self
                .padding(padding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(backgroundColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: lineWidth)
                )
        }
}
