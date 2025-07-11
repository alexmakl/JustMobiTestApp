//
//  MainViewController.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

final class MainViewController: UIViewController {

    private let promoView = BannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        promoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promoView)
        
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

