//
//  OnboardingView.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingView: View {
    
    private enum Strings {
        static let next = "다음"
        static let start = "시작하기"
        static let skip = "건너뛰기"
    }
    
    @AppStorage(AppStorageKey.hasLaunched) private var hasLaunched = false
    @State private var currentPage: Int = 0
    private let totalPages = 4
    
    private var isFirstPage: Bool {
        currentPage == 0
    }
    
    private var isLastPage: Bool {
        currentPage == totalPages - 1
    }

    var body: some View {
        ZStack {
            ColorPalette.background
                .ignoresSafeArea()

            // MARK: - Pages
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

            
            VStack {
                // MARK: - Navigation Bar
                HStack {
                    Button {
                        currentPage -= 1
                    } label: {
                        Image("back_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(10)
                            .contentShape(Rectangle())
                    }
                    .opacity(isFirstPage ? 0 : 1)
                    .disabled(isFirstPage)

                    Spacer()

                    Button {
                        hasLaunched = true
                    } label: {
                        Text(Strings.skip)
                            .chacFont(.toast_body)
                            .foregroundStyle(ColorPalette.white_40)
                    }
                }
                .frame(height: 52)
                .padding(.horizontal, 20)

                Spacer()
                
                // MARK: - Bottom Controls
                VStack(spacing: 30) {
                    OnboardingPageControl(
                        currentPage: currentPage,
                        totalPages: totalPages
                    )

                    CTAButton(title: isLastPage ? Strings.start : Strings.next) {
                        if isLastPage {
                            hasLaunched = true
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
}

#Preview {
    OnboardingView()
}
