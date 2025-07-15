//
//  BannerView.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

final class BannerView: UIView {
    
    public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    public var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.numberOfLines = 0
        return label
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let bannerGridView = BannerGridView(imageNames: ["Image1", "Image2", "Image3", "Image4"])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        backgroundColor = .customPurple
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        [titleLabel, descriptionLabel].forEach { textStack.addArrangedSubview($0) }
        addSubview(textStack)
        addSubview(bannerGridView)
    }
    
    private func setupLayout() {
        bannerGridView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            textStack.trailingAnchor.constraint(equalTo: bannerGridView.leadingAnchor, constant: -20),
            
            bannerGridView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bannerGridView.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            bannerGridView.widthAnchor.constraint(equalToConstant: 94),
            bannerGridView.heightAnchor.constraint(equalToConstant: 80),
            bannerGridView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 14),
            bannerGridView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -14),
        ])
    }
}
