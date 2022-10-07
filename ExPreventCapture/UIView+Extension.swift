//
//  UIView+Extension.swift
//  ExPreventCapture
//
//  Created by 김종권 on 2022/10/07.
//

import UIKit

extension UIView {
  func makeSecure() {
    DispatchQueue.main.async {
      let textField = UITextField()
      textField.isSecureTextEntry = true
      
      self.addSubview(textField)
      textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      
      self.layer.superlayer?.addSublayer(textField.layer)
      textField.layer.sublayers?.first?.addSublayer(self.layer)
    }
  }
  
  public func makeSecureWithPlaceholder() {
    DispatchQueue.main.async {
      let backView = UIView(frame: self.frame)
      backView.backgroundColor = UIColor.lightGray
      self.superview?.insertSubview(backView, at: 0)
      
      let label = UILabel()
      label.text = "Can't Capture"
      label.textColor = .red
      label.frame = backView.frame
      backView.addSubview(label)
      
      self.makeSecure()
    }
  }
}
