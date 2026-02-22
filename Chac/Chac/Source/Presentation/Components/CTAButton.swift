//
//  CTAButton.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct CTAButton: View {
    
    let title: String
    var disabled: Bool = false
    let action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .chacFont(.btn)
                .foregroundStyle(disabled ? ColorPalette.text_btn_03 : ColorPalette.text_btn_01)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(RoundedRectangle(cornerRadius: 12).fill(disabled ? ColorPalette.disable : ColorPalette.primary))
        }
    }
}
