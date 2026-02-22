//
//  PermissionEmptyView.swift
//  Chac
//
//  Created by 이원빈 on 2/5/26.
//

import SwiftUI

struct PermissionEmptyView: View {
    
    private enum Strings {
        static let noPermissionMessage = "앨범을 생성하려면\n사진 접근 권한이 필요해요."
        static let goToSetting = "설정으로 이동"
    }
    
    private enum Metric {
        static let topMargin = ScreenSize.height / 4
    }
    
    @EnvironmentObject private var permissionManager: DefaultPhotoLibraryPermissionManager
    
    var body: some View {
        VStack(spacing: 0) {
            Text(Strings.noPermissionMessage)
                .multilineTextAlignment(.center)
                .chacFont(.body)
                .foregroundStyle(ColorPalette.text_03)
                .padding(.top, Metric.topMargin)
            
            CTAButton(title: Strings.goToSetting) {
                permissionManager.openSettings()
            }
            .frame(width: 156)
            .padding(.top, 40)
            
            Spacer()
        }
    }
    
}

#Preview {
    PermissionEmptyView()
        .environmentObject(DefaultPhotoLibraryPermissionManager())
}
