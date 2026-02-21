//
//  OnboardingView.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingView: View {
    
    public enum Strings {
        static let next = "다음"
        static let start = "시작하기"
    }
    
    @State private var currentPage: Int = 0
    private let totalPages = 4
    
    private var isLastPage: Bool {
        currentPage == totalPages - 1
    }

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

            VStack(spacing: 30) {
                OnboardingPageControl(
                    currentPage: currentPage,
                    totalPages: totalPages
                )

                CTAButton(title: isLastPage ? Strings.start : Strings.next) {
                    if isLastPage {
                        
                    } else {
                        currentPage += 1
                    }
                }
                .padding([.horizontal, .top], 20)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    OnboardingView()
}
