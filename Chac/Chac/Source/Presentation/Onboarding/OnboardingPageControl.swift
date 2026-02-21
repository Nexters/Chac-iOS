//
//  OnboardingPageControl.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingPageControl: View {
    let currentPage: Int
    let totalPages: Int

    private let dotSize: CGFloat = 8
    private let spacing: CGFloat = 8

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(
                        index == currentPage
                            ? ColorPalette.primary
                            : ColorPalette.white_10
                    )
                    .frame(
                        width: index == currentPage ? dotSize * 2 : dotSize,
                        height: dotSize
                    )
                    .animation(.easeInOut(duration: 0.25), value: currentPage)
            }
        }
    }
}

