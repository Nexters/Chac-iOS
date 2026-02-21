//
//  OnboardingFirstPageView.swift
//  Chac
//
//  Created by 가은 on 2/21/26.
//

import SwiftUI

struct OnboardingFirstPageView: View {
    
    public enum Strings {
        static let title = "사진을 정리해\n앨범을 생성해주는 착"
    }
    
    var body: some View {
        ZStack {
            Image("onboarding_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {

                Image("onboarding_logo_icon")
                
                Image("watermark_icon")
                    .resizable()
                    .frame(width: 64, height: 22)
                    .foregroundStyle(ColorPalette.text_btn_01)
                    .padding(.top, 26)

                Text(Strings.title)
                    .chacFont(.headline_01)
                    .foregroundStyle(ColorPalette.text_01)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                Spacer()
            }
            .padding(.top, 112)
        }
        
    }
}

#Preview {
    OnboardingFirstPageView()
}
