//
//  ARContainerView.swift
//  ARKIT-SWIFTUI
//
//  Created by Brian Riviere on 2023-03-19.
//

import SwiftUI
import ARKit
import RealityKit

struct ARContainerView: UIViewRepresentable {
    @ObservedObject var containerViewManager = ARContainerViewManager()
    var sessionRunOptions: ARSession.RunOptions
        
    func makeUIView(context: Context) -> CustomARView {
        containerViewManager.arView.didTapView = didTapView(_:)
        containerViewManager.resetTrackingConfiguration()
        containerViewManager.arView.session.delegate = context.coordinator
        return containerViewManager.arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
    }
    
    func didTapView(_ sender: UITapGestureRecognizer) {
        let arView = containerViewManager.arView
        let tapLocation = sender.location(in: arView)
        let raycastResults = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        guard let firstRaycastResult = raycastResults.first else { return }
        let anchor = ARAnchor(name: "anchorName", transform: firstRaycastResult.worldTransform)
        arView.session.add(anchor: anchor)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    var parent: ARContainerView
    
    init(_ parent: ARContainerView) {
        self.parent = parent
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard anchor.name == "anchorName" else { continue }
            parent.containerViewManager.appendTextToScene(anchor: anchor)
        }
    }
}
