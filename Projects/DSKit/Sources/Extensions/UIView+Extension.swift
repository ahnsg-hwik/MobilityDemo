//
//  UIView+Extension.swift
//  DSKit
//
//  Created by iOS_Hwik on 1/20/26.
//

import UIKit

extension UIView {
    public func asImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
