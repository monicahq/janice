//
//  RootFunc.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-11.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import UIKit

func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    guard let windowUnwrapped = window else { return }
    if animated {
        UIView.transition(with: windowUnwrapped, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            windowUnwrapped.rootViewController = rootViewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    } else {
        windowUnwrapped.rootViewController = rootViewController
    }
}
