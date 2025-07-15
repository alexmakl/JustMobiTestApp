//
//  BannerGridView.swift
//  JustMobiTestApp
//
//  Created by Alexander on 14.07.2025.
//

import UIKit

final class BannerGridView: UIView {
    
    private let imageNames: [String]
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
    
    init(imageNames: [String]) {
        self.imageNames = imageNames
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        guard imageViews.count == 4 else { return }

        [imageViews[0], imageViews[2]].forEach { gridLeft.addSubview($0) }
        [imageViews[1], imageViews[3]].forEach { gridRight.addSubview($0) }
        [gridLeft, gridRight].forEach { gridStack.addArrangedSubview($0) }
        addSubview(gridStack)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageViews[0].heightAnchor.constraint(equalToConstant: 51),
            imageViews[1].heightAnchor.constraint(equalToConstant: 23),
            imageViews[2].heightAnchor.constraint(equalToConstant: 23),
            imageViews[3].heightAnchor.constraint(equalToConstant: 51),
            
            imageViews[0].topAnchor.constraint(equalTo: gridLeft.topAnchor),
            imageViews[0].leadingAnchor.constraint(equalTo: gridLeft.leadingAnchor),
            imageViews[0].trailingAnchor.constraint(equalTo: gridLeft.trailingAnchor),
            
            imageViews[2].leadingAnchor.constraint(equalTo: gridLeft.leadingAnchor),
            imageViews[2].trailingAnchor.constraint(equalTo: gridLeft.trailingAnchor),
            imageViews[2].bottomAnchor.constraint(equalTo: gridLeft.bottomAnchor),
            
            imageViews[1].topAnchor.constraint(equalTo: gridRight.topAnchor),
            imageViews[1].leadingAnchor.constraint(equalTo: gridRight.leadingAnchor),
            imageViews[1].trailingAnchor.constraint(equalTo: gridRight.trailingAnchor),
            
            imageViews[3].leadingAnchor.constraint(equalTo: gridRight.leadingAnchor),
            imageViews[3].trailingAnchor.constraint(equalTo: gridRight.trailingAnchor),
            imageViews[3].bottomAnchor.constraint(equalTo: gridRight.bottomAnchor),
            
            gridStack.topAnchor.constraint(equalTo: topAnchor),
            gridStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            gridStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            gridStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
