//
//  NavigationTitleView.swift
//  YoutubeChannelFilter
//
//  Created by coolishbee on 2022/03/25.
//

import Foundation
import UIKit

class NavigationTitleView: UIView {
    let logoImage = UIImageView()
    private var constraintsDidSetup = false
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        setup(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with title: String) {
        //logoImage. = title
        self.addSubview(logoImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard constraintsDidSetup else {
            NSLayoutConstraint.activate([
                logoImage.widthAnchor.constraint(equalTo: self.window!.widthAnchor, constant: -100 * 2),
                logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            constraintsDidSetup = true
            return
        }
    }
}
