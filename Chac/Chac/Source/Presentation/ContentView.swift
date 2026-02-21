//
//  ContentView.swift
//  ChakChak
//
//  Created by 이원빈 on 1/8/26.
//

import SwiftUI


struct ContentView: View {
    @AppStorage(AppStorageKey.hasLaunched) private var hasLaunched = false
    @StateObject private var coordinator = NavigationCoordinator()
    @StateObject private var permissionManger = DefaultPhotoLibraryPermissionManager()
    @StateObject private var photoLibraryStore = PhotoLibraryStore()
    
    var body: some View {
        if hasLaunched {
            NavigationStack(path: $coordinator.path) {
                MainView()
                    .navigationDestination(for: Route.self) { route in
                        destinationView(for: route)
                    }
            }
            .environmentObject(coordinator)
            .environmentObject(permissionManger)
            .environmentObject(photoLibraryStore)
        } else {
            OnboardingView()
        }
    }
    
    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .main:
            MainView()
        case .photoSelect(let isTotal, let index):
            if isTotal {
                PhotoSelectView(cluster: PhotoCluster(id: UUID(), title: "모든 사진", phAssets: photoLibraryStore.photos))
            } else if let index = index {
                if index < photoLibraryStore.clusters.count {
                    PhotoSelectView(cluster: photoLibraryStore.clusters[index], clusterIndex: index)
                } else {
                    Text("클러스터를 찾을 수 없습니다.")
                }
            }
            
        case .editAlbumName(let clusterIndex, let assets, let albumName):
            AlbumNameEditView(clusterIndex: clusterIndex, assets: assets, albumName: albumName)
        case .setting:
            SettingView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PhotoLibraryStore())
}
