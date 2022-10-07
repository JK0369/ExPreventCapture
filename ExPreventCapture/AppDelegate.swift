//
//  AppDelegate.swift
//  ExPreventCapture
//
//  Created by 김종권 on 2022/10/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(alertCapture),
      name: UIApplication.userDidTakeScreenshotNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(alertRecoding),
      name: UIScreen.capturedDidChangeNotification,
      object: nil
    )
    
    return true
  }
  
  @objc private func alertCapture() {
    alert("캡쳐가 감지되었습니다.")
  }
  @objc private func alertRecoding() {
    alert("녹화가 감지되었습니다.")
//    window?.isHidden = UIScreen.main.isCaptured
  }
  
  private func alert(_ title: String) {
    // 레코딩이 진행중일때만 alert (= 레코딩이 끝난 경우 alert해주지 않도록 guard)
    guard UIScreen.main.isCaptured else { return }
    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
    let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
    alert.addAction(confirm)
    
    if var topController = self.window?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      DispatchQueue.main.async {
        topController.present(alert, animated: false, completion: nil)
      }
    }
  }
}
