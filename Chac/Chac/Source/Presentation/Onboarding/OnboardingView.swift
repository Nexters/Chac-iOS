//
//  OnboardingView.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage: Int = 0
    private let totalPages = 4

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                OnboardingFirstPageView()
                    .tag(0)

                ForEach(1..<totalPages, id: \.self) { index in
                    OnboardingPageView(pageIndex: index)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            OnboardingPageControl(
                currentPage: currentPage,
                totalPages: totalPages
            )
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    OnboardingView()
}
