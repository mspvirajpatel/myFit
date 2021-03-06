//
//  CustomImageView.swift
//  myFit
//
//  Created by Winston Maragh on 9/06/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//


import UIKit


class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

@IBDesignable
class CustomImageView: UIImageView {

	@IBInspectable
    public var borderColor: UIColor = UIColor.clear {
		didSet {
			layer.borderColor = borderColor.cgColor
		}
	}

	@IBInspectable
    public var borderWidth: CGFloat = 0 {
		didSet {
			layer.borderWidth = borderWidth
		}
	}

	@IBInspectable
    public var cornerRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}

	@IBInspectable
    var pulseDelay: Double = 0.0

	@IBInspectable
    var popIn: Bool = false
	
    @IBInspectable
    var popInDelay: Double = 0.4


    @IBInspectable
    public var shadowOpacity: CGFloat = 0 {
		didSet {
			//layer.shadowOpacity = Float(shadowOpacity)
		}
	}

	@IBInspectable
    public var shadowColor: UIColor = UIColor.clear {
		didSet {
			//layer.shadowColor = shadowColor.cgColor
		}
	}

	@IBInspectable
    public var shadowRadius: CGFloat = 0 {
		didSet {
			//layer.shadowRadius = shadowRadius
		}
	}

	@IBInspectable
    public var shadowOffsetY: CGFloat = 0 {
		didSet {
			//layer.shadowOffset.height = shadowOffsetY
		}
	}

	override func draw(_ rect: CGRect) {
		if clipsToBounds && shadowOpacity > 0 {
			layer.masksToBounds = true
			layer.cornerRadius = cornerRadius

			// Outer UIView to hold the Shadow
			let shadow = UIView(frame: rect)
			shadow.layer.cornerRadius = cornerRadius
			shadow.layer.masksToBounds = false
			shadow.layer.shadowOpacity = Float(shadowOpacity)
			shadow.layer.shadowColor = shadowColor.cgColor
			shadow.layer.shadowRadius = shadowRadius
			shadow.layer.shadowOffset.height = shadowOffsetY
			shadow.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

			shadow.addSubview(self)
		}
	}

	override func awakeFromNib() {
		if pulseDelay > 0 {
			UIView.animate(withDuration: 1, delay: pulseDelay, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
				self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
				self.transform = CGAffineTransform.identity
			}, completion: nil)
		}

		if popIn {
			transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
			UIView.animate(withDuration: 0.8, delay: popInDelay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
				self.transform = CGAffineTransform.identity
			}, completion: nil)
		}
	}
}
