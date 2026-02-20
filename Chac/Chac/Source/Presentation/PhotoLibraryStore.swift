import Foundation
import Photos
import UIKit
import SwiftUI

@MainActor
final class PhotoLibraryStore: ObservableObject {
    @Published private(set) var photos: [PHAsset] = []
    @Published private(set) var clusters: [PhotoCluster] = []
    @Published var isLoading: Bool = false
    
    private var isFirstLoad = true
    private let libraryService: PhotoLibraryService
    private let clusterService: PhotoClusterService
    
    init(
        libraryService: PhotoLibraryService = DefaultPhotoLibraryService(),
        clusterService: PhotoClusterService = DefaultPhotoClusterService()
    ) {
        self.libraryService = libraryService
        self.clusterService = clusterService
    }
    
    func refreshIfAuthorized(status: PHAuthorizationStatus) {
        guard status == .authorized || status == .limited else { return }
        guard isLoading == false, isFirstLoad == true else { return }
        isLoading = true
        isFirstLoad = false
        
        Task {
            let fetched = await Task(priority: .userInitiated) {
                libraryService.fetchAllImages()
            }.value
            
            self.photos = fetched
            await processClustering()
        }
    }
    
    func requestThumbnail(for asset: PHAsset, targetSize: CGSize) async throws -> UIImage {
        return try await libraryService.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill)
    }
    
    func saveToAlbum(assets: [PHAsset], albumName: String) async throws {
        try await libraryService.saveToAlbum(assets: assets, albumName: albumName)
    }
    
    /// 저장된 사진들을 해당 클러스터에서 제거합니다. (빈 클러스터는 자동 삭제)
    func removeSavedAssets(at clusterIndex: Int?, identifiers: Set<String>) {
        guard let clusterIndex, clusterIndex < clusters.count else { return }
        
        let remaining = clusters[clusterIndex].phAssets.filter { !identifiers.contains($0.localIdentifier) }
        if remaining.isEmpty {
            clusters.remove(at: clusterIndex)
        } else {
            clusters[clusterIndex] = PhotoCluster(
                id: clusters[clusterIndex].id,
                title: clusters[clusterIndex].title,
                phAssets: remaining
            )
        }
    }
    
    private func processClustering() async {
        guard !photos.isEmpty else { return }
        
        Task(priority: .utility) {  // UI보다 낮은 우선순위
            let stream = clusterService.clusterPhotos(photos)
            
            for await newCluster in stream {
                await MainActor.run {
                    withAnimation(.easeIn) {
                        self.clusters.append(newCluster)
                    }
                }
                
                try? await Task.sleep(for: .seconds(0.2))
            }
            self.isLoading = false
        }
    }
}
