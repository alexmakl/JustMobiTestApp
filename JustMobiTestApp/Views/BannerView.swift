//
//  BannerView.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

final class BannerView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Try three days free trial"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You will get all premium template, additional stickers and no ads"
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
    
    private let imageNames = ["Image1", "Image2", "Image3", "Image4"]
    private lazy var imageViews: [UIImageView] = imageNames.map {
        let iv = UIImageView(image: UIImage(named: $0))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 3
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }
    
    private lazy var image1 = imageViews[0]
    private lazy var image2 = imageViews[1]
    private lazy var image3 = imageViews[2]
    private lazy var image4 = imageViews[3]
    
    private lazy var gridLeft = UIView()
    private lazy var gridRight = UIView()
    
    private lazy var gridStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
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
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .customPurple
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        [titleLabel, descriptionLabel].forEach { textStack.addArrangedSubview($0) }
        addSubview(textStack)
        
        [image1, image3].forEach { gridLeft.addSubview($0) }
        [image2, image4].forEach { gridRight.addSubview($0) }
        [gridLeft, gridRight].forEach { gridStack.addArrangedSubview($0) }
        
        addSubview(gridStack)
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            textStack.trailingAnchor.constraint(equalTo: gridStack.leadingAnchor, constant: -20),
            
            image1.heightAnchor.constraint(equalToConstant: 51),
            image2.heightAnchor.constraint(equalToConstant: 23),
            image3.heightAnchor.constraint(equalToConstant: 23),
            image4.heightAnchor.constraint(equalToConstant: 51),
            image1.topAnchor.constraint(equalTo: gridLeft.topAnchor),
            image1.leadingAnchor.constraint(equalTo: gridLeft.leadingAnchor),
            image1.trailingAnchor.constraint(equalTo: gridLeft.trailingAnchor),
            image3.leadingAnchor.constraint(equalTo: gridLeft.leadingAnchor),
            image3.trailingAnchor.constraint(equalTo: gridLeft.trailingAnchor),
            image3.bottomAnchor.constraint(equalTo: gridLeft.bottomAnchor),
            
            image2.topAnchor.constraint(equalTo: gridRight.topAnchor),
            image2.leadingAnchor.constraint(equalTo: gridRight.leadingAnchor),
            image2.trailingAnchor.constraint(equalTo: gridRight.trailingAnchor),
            image4.leadingAnchor.constraint(equalTo: gridRight.leadingAnchor),
            image4.trailingAnchor.constraint(equalTo: gridRight.trailingAnchor),
            image4.bottomAnchor.constraint(equalTo: gridRight.bottomAnchor),
            
            gridStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            gridStack.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            gridStack.widthAnchor.constraint(equalToConstant: 94),
            gridStack.heightAnchor.constraint(equalToConstant: 80),
            gridStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 14),
            gridStack.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -14),
        ])
    }
}
