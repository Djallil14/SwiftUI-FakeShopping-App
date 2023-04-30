//
//  CustomARView.swift
//  ARKIT-SWIFTUI
//
//  Created by Brian Riviere on 2023-03-19.
//

import SwiftUI
import ARKit
import RealityKit

final class CustomARView: ARView {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var didTapView: ((_ sender: UITapGestureRecognizer) -> Void)?
    
    @objc required dynamic init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
        registerTapGesture()
    }
    
    private func registerTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRegisterTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didRegisterTap(_ sender: UITapGestureRecognizer) {
        guard let didTapView = didTapView else { return }
        didTapView(sender)
    }
    
    
}
