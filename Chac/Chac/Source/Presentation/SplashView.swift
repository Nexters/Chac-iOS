//
//  SplashView.swift
//  Chac
//
//  Created by 이원빈 on 2/7/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            ColorPalette.splash
                .ignoresSafeArea()
            VStack(spacing: 22.05) {
                Image("splash_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160.95)
                Text("Chac")
                    .chacFont(.splash_name)
                    .foregroundStyle(ColorPalette.text_btn_01)
                
            }
            .padding(.bottom, 70) // FIXME: 중앙기준 35만큼 위로 올라감. 추후 계산식 활용해서 정확한 값 적용필요
        }
    }
}

#Preview {
    SplashView()
}
