//
//  AlbumNameEditView.swift
//  Chac
//
//  Created by 가은 on 2/13/26.
//

import SwiftUI
import Photos

struct AlbumNameEditView: View {
    
    private enum Strings {
        static let navigationTitle = "앨범명 변경"
        static let albumName = "앨범명"
    }
    
    private enum Metric {
        static let topMargin = ScreenSize.height * 0.07
        static let thumbnailSize: CGFloat = 120
    }
    
    private let assets: [PHAsset]
    @State private var albumName: String
    
    init(assets: [PHAsset], albumName: String) {
        self.assets = assets
        self._albumName = State(initialValue: albumName)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            PhotoThumbnailView(
                phAsset: assets.first ?? PHAsset(),
                targetSize: CGSize(width: Metric.thumbnailSize, height: Metric.thumbnailSize),
                isSelectView: false
            )
            .background(backThumbnailView())
            .padding(.top, Metric.topMargin)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.albumName)
                    .chacFont(.sub_title_03)
                    .foregroundStyle(ColorPalette.white_40)
                    .padding(.leading, 12)
                
                HStack(spacing: 10) {
                    TextField(text: $albumName) {
                        
                    }
                    .chacFont(.sub_title_01)
                    .foregroundStyle(ColorPalette.text_01)
                    .tint(ColorPalette.text_01)
                    
                    
                    if !albumName.isEmpty {
                        Button {
                            albumName.removeAll()
                        } label: {
                            Image("xmark_circle_icon")
                        }
                    }
                }
                .padding(18)
                .background(ColorPalette.white_5)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()
            
            moveButton(
                title: "\(assets.count)장의 사진 앨범에 저장",
                titleColor: ColorPalette.text_btn_01,
                backgroundColor: ColorPalette.primary
            ) {
                
            }
        }
        .padding(.horizontal, 20)
        .background(ColorPalette.background)
        .navigationTitle(Strings.navigationTitle)
    }
    
    @ViewBuilder
    private func backThumbnailView() -> some View {
        if assets.count > 1 {
            PhotoThumbnailView(
                phAsset: assets[1],
                targetSize: CGSize(width: Metric.thumbnailSize, height: Metric.thumbnailSize),
                isSelectView: false
            )
            .overlay(ColorPalette.black_60.clipShape(RoundedRectangle(cornerRadius: 12)))
            .rotationEffect(.degrees(10))
        } else {
            Color.clear
        }
    }
    
    @ViewBuilder
    private func moveButton(title: String, titleColor: Color, backgroundColor: Color, action: @escaping () -> Void) -> some View { // TODO: 공통 컴포넌트로 분리
        Button(action: action) {
            Text(title)
                .chacFont(.btn)
                .foregroundStyle(titleColor)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(RoundedRectangle(cornerRadius: 12).fill(backgroundColor))
        }
    }
}

#Preview {
    AlbumNameEditView(assets: [], albumName: "샘플 앨범")
}
