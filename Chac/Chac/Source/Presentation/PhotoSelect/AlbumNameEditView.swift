//
//  AlbumNameEditView.swift
//  Chac
//
//  Created by 가은 on 2/13/26.
//

import SwiftUI
import Photos

struct AlbumNameEditView: View {
    private let assets: [PHAsset]
    @State private var albumName: String
    
    init(assets: [PHAsset], albumName: String) {
        self.assets = assets
        self._albumName = State(initialValue: albumName)
    }
    
    var body: some View {
        VStack {
            
        }
        .background(ColorPalette.background)
        .navigationTitle("앨범명 변경")
    }
}

#Preview {
    AlbumNameEditView(assets: [], albumName: "샘플 앨범")
}
