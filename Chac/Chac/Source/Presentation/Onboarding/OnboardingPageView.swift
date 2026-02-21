//
//  OnboardingPageView.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingPageView: View {
    
    private enum Strings {
        static let titles = [
            "착착 자동 생성되는 앨범",
            "원하는 사진만 쏙",
            "나만의 앨범 생성 완료!"
        ]
        
        static let subtitles = [
            "클러스터링을 활용해\n시간과 위치 기반으로 앨범을 생성해요.",
            "생성된 앨범에서 내가 원하는\n사진만 골라 선택할 수 있어요.",
            "앨범명을 자유롭게 바꾸며\n손쉬운 나만의 앨범을 생성해보세요!"
        ]
    }
    
    let pageIndex: Int

    private var imageName: String {
        "onboarding\(pageIndex)_icon"
    }

    private var title: String {
        Strings.titles[pageIndex - 1]
    }

    private var subtitle: String {
        Strings.subtitles[pageIndex - 1]
    }

    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)

            Text(title)
                .chacFont(.headline_02)
                .foregroundStyle(ColorPalette.text_01)
                .padding(.top, 30)

            Text(subtitle)
                .chacFont(.body)
                .foregroundStyle(ColorPalette.text_03)
                .multilineTextAlignment(.center)
                .padding(.top, 10)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 146)
        .background(ColorPalette.background)
    }
}

#Preview {
    OnboardingPageView(pageIndex: 1)
}
