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
      
      // 캡쳐하려는 뷰의 레이어를 textField.layer 사이에 끼워넣기
      textField.layer.removeFromSuperlayer() // 이 코드가 없으면 run time error (layer 참조 관계에 cycle이 생성되므로)
      self.layer.superlayer?.insertSublayer(textField.layer, at: 0)
      textField.layer.sublayers?.last?.addSublayer(self.layer)
    }
  }
  
  public func makeSecureWithPlaceholder() {
    DispatchQueue.main.async {
      let backView = UIView(frame: self.frame)
      backView.backgroundColor = UIColor.lightGray
      self.superview?.insertSubview(backView, at: 0)
      
      self.makeSecure()
    }
  }
}
