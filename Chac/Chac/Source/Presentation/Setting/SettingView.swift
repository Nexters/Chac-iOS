//
//  SettingView.swift
//  Chac
//
//  Created by 이원빈 on 2/21/26.
//

import SwiftUI

struct SettingView: View {
    
    private enum Strings {
        static let navigationTitle = "설정"
        static let showOpenSourceLibrary = "오픈소스 라이브러리"
        static let showOnboardingAgain = "온보딩 다시보기"
        static let showPrivacyPolicy = "개인정보처리방침"
        static let privacyPolicyURL = "https://ojh102.notion.site/2ed107af0aeb80608ec3c5550dca41eb"
    }
    
    private enum Metric {
        static let listItemHorizontalPadding: CGFloat = 20
        static let listItemHorizontalMargin: CGFloat = 20
        static let listItemVerticalPadding: CGFloat = 10
    }
    
    @AppStorage(AppStorageKey.hasLaunched) private var hasLaunched = false
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @State private var isPresentPrivacyPolicy = false
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                listItem(title: Strings.showOpenSourceLibrary) {
                    // TODO: 추후 오픈소스 라이센스 표출 시 사용
                }
                .disabled(true)
                listItem(title: Strings.showOnboardingAgain) {
                    coordinator.popToRoot()
                    hasLaunched = false
                }
                listItem(title: Strings.showPrivacyPolicy) {
                    isPresentPrivacyPolicy = true
                }
            }
            .padding(.vertical, 10)
            .background(ColorPalette.white_5)
            .cornerRadius(16)
            .padding(.horizontal, Metric.listItemHorizontalMargin)
            .padding(.top, 20)
            
            Spacer()
        }
        .background(ColorPalette.background)
        .navigationTitle(Strings.navigationTitle)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isPresentPrivacyPolicy) {
            SafariView(url: URL(string: Strings.privacyPolicyURL)!)
        }
    }
    
    @ViewBuilder
    private func listItem(title: String, onTap: @escaping () -> Void) -> some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(title)
                    .chacFont(.body)
                    .foregroundStyle(ColorPalette.text_02)
                
                Spacer()
                
                Image("chevron_right_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 9, height: 19)
                    .foregroundStyle(ColorPalette.text_02)
            }
            .padding(.horizontal, Metric.listItemHorizontalPadding)
            .padding(.vertical, Metric.listItemVerticalPadding)
        }
    }
}

#Preview {
    SettingView()
}
