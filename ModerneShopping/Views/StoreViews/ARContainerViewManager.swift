//
//  ARContainerViewManager.swift
//  ARKIT-SWIFTUI
//
//  Created by Brian Riviere on 2023-03-19.
//

import SwiftUI
import ARKit
import RealityKit

final class ARContainerViewManager: ObservableObject {
    var arView = CustomARView()
    
    private let worldTrackingConfiguration: ARWorldTrackingConfiguration = {
        let worldTrackingConfiguration = ARWorldTrackingConfiguration()
        worldTrackingConfiguration.planeDetection = .horizontal
        worldTrackingConfiguration.isLightEstimationEnabled = false
        return worldTrackingConfiguration
    }()
    
    func resetTrackingConfiguration(options: ARSession.RunOptions = []) {
        arView.session.run(
            worldTrackingConfiguration, options: options)
    }
    
    func appendTextToScene(anchor: ARAnchor) {
        let textMeshResource = MeshResource.generateText("AppCoda.com\nx\nMastering ARKit",
                                                         extrusionDepth: 0.02,
                                                         font: UIFont.systemFont(ofSize: 0.05),
                                                         alignment: .center)
        let modeEntity = ModelEntity(mesh: textMeshResource, materials: [SimpleMaterial(color: .systemOrange, isMetallic: false)]
        )
        let anchorEnity = AnchorEntity()
        anchorEnity.transform.translation.x = -textMeshResource.bounds.extents.x / 2
        anchorEnity.addChild(modeEntity)
        arView.scene.anchors.append(anchorEnity)
                
    }
}
