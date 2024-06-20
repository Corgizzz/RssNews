//
//  BaseViewController.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/19.
//

import UIKit

// MARK: - Class
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
}

// MARK: - Setup
extension BaseViewController {
    func setupBaseUI() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.textLimedSpruce
        ]
        
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            let customBackButton = UIBarButtonItem(image: UIImage(named: "navbar_back"), style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = customBackButton
        }
    }
}

// MARK: - Action
extension BaseViewController {
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Internal Method
extension BaseViewController {
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
