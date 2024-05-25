//
//  ViewController.swift
//  ElmTask
//
//  Created by Ahmed Khalaf on 25/05/2024.
//

import UIKit

class RootViewController: UIViewController {
    
    weak var delegate: (any Delegate)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension RootViewController {
    protocol Delegate: AnyObject {
        func rootViewController(
            _ rootViewController: Self,
            didReceiveAuthenticationStateChangeEvent: Any
        )
    }
}
