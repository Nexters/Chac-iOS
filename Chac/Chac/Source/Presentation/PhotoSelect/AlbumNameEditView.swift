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
        static let failToSaveAlert = "앨범 저장에 실패했습니다"
    }
    
    private enum Metric {
        static let topMargin = ScreenSize.height * 0.07
        static let thumbnailSize: CGFloat = 120
        static let thumbnailCornerRadius: CGFloat = 16
    }
    
    @EnvironmentObject private var photoLibraryStore: PhotoLibraryStore
    @State private var showFailedAlert = false
    @State private var showPhotoSaveView = false
    @State private var albumName: String
    @State private var savedCount = 0
    
    private let assets: [PHAsset]
    private let locationText: String
    private let clusterIndex: Int?
    
    init(clusterIndex: Int?, assets: [PHAsset], albumName: String) {
        self.clusterIndex = clusterIndex
        self.assets = assets
        self.locationText = albumName
        self._albumName = State(initialValue: albumName)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            PhotoThumbnailView(
                phAsset: assets.first ?? PHAsset(),
                targetSize: CGSize(width: Metric.thumbnailSize, height: Metric.thumbnailSize),
                cornerRadius: Metric.thumbnailCornerRadius,
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
                        Text(locationText)
                            .chacFont(.sub_title_01)
                            .foregroundStyle(ColorPalette.text_04)
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
                Task { await savePhotos() }
            }
        }
        .padding(.horizontal, 20)
        .background(ColorPalette.background)
        .navigationTitle(Strings.navigationTitle)
        .alert(Strings.failToSaveAlert, isPresented: $showFailedAlert) {
            Button("확인") { showFailedAlert = false }
        }
        .fullScreenCover(isPresented: $showPhotoSaveView) {
            PhotoSaveView(savedCount: $savedCount)
        }
    }
    
    @ViewBuilder
    private func backThumbnailView() -> some View {
        if assets.count > 1 {
            PhotoThumbnailView(
                phAsset: assets[1],
                targetSize: CGSize(width: Metric.thumbnailSize, height: Metric.thumbnailSize),
                cornerRadius: Metric.thumbnailCornerRadius,
                isSelectView: false
            )
            .overlay(ColorPalette.black_60.clipShape(RoundedRectangle(cornerRadius: Metric.thumbnailCornerRadius)))
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
    
    private func savePhotos() async {
        do {
            try await photoLibraryStore.saveToAlbum(
                assets: assets,
                albumName: albumName.isEmpty ? locationText : albumName
            )
            photoLibraryStore.removeSavedAssets(
                at: clusterIndex,
                identifiers: Set(assets.map(\.localIdentifier))
            )
            savedCount = assets.count
            showPhotoSaveView = true
        } catch {
            print("앨범 저장 실패: \(error.localizedDescription)")
            showFailedAlert = true
        }
    }
}

#Preview {
    AlbumNameEditView(clusterIndex: nil, assets: [], albumName: "샘플 앨범")
}
