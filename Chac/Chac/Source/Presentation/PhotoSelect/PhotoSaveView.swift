//
//  PhotoSaveView.swift
//  Chac
//
//  Created by 가은 on 1/15/26.
//

import SwiftUI

struct PhotoSaveView: View {
    
    private enum Strings {
        static let completeSave = "저장 완료"
        static let moveToPhotoList = "메인으로"
        static let photoCountFormat = "총 %d장의 사진이 포함된 앨범을 \n갤러리에 저장했어요!"
    }
    
    private enum Metric {
        static let topMargin = ScreenSize.height / 9.75
    }
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var permissionManager: DefaultPhotoLibraryPermissionManager
    
    @Binding var savedCount: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                    coordinator.popToRoot()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(ColorPalette.text_01)
                }
            }
            .padding(.vertical, 14)
            
            Image("save_complete_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .padding(.top, Metric.topMargin)
            
            Text(Strings.completeSave)
                .chacFont(.headline_02)
                .foregroundStyle(ColorPalette.text_01)
                .padding(.top, 26)
            
            Text(String(format: Strings.photoCountFormat, savedCount))
                .multilineTextAlignment(.center)
                .chacFont(.body)
                .foregroundStyle(ColorPalette.text_03)
                .padding(.top, 10)
            
            Spacer()
            Spacer()
            
            CTAButton(title: Strings.moveToPhotoList) {
                dismiss()
                coordinator.popToRoot()
            }
        }
        .padding(.horizontal, 20)
        .background(ColorPalette.background)
    }
    
}

#Preview {
    PhotoSaveView(savedCount: .constant(5))
}
