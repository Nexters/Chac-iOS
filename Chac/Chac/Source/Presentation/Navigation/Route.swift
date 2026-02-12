//
//  Route.swift
//  Chac
//
//  Created by 이원빈 on 1/14/26.
//

import Foundation
import Photos

enum Route: Hashable {
    case main
    case photoSelect(isTotal: Bool, index: Int?)
    case editAlbumName(assets: [PHAsset], albumName: String)
}
