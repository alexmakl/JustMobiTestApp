//
//  GiftView.swift
//  JustMobiTestApp
//
//  Created by Alexander on 15.07.2025.
//

import UIKit

final class GiftView: UIView {
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "giftbox")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let circle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.layer.cornerRadius = 84
        return view
    }()
    
    private var timer: Timer?
    private var remainingSeconds: Int = 0
    
    private var boxImageViewTopConstraint: NSLayoutConstraint!
    private var timerLabelTopConstraint: NSLayoutConstraint!
    
    init(timerFontSize: CGFloat = 22) {
        super.init(frame: .zero)
        timerLabel.font = UIFont.systemFont(ofSize: timerFontSize, weight: .semibold)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circle.layer.cornerRadius = circle.bounds.width / 2
        boxImageViewTopConstraint.constant = circle.bounds.height * 0.03
        timerLabelTopConstraint.constant = circle.bounds.height * 0.04
    }
    
    private func setupUI() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        backgroundColor = .clear
        
        addSubview(circle)
        addSubview(boxImageView)
        addSubview(timerLabel)
    }
    
    private func configureConstraints() {
        circle.translatesAutoresizingMaskIntoConstraints = false
        boxImageView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        boxImageViewTopConstraint = boxImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        timerLabelTopConstraint = timerLabel.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 8)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.widthAnchor.constraint(equalTo: widthAnchor),
            circle.heightAnchor.constraint(equalTo: heightAnchor),
            
            boxImageViewTopConstraint,
            boxImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            boxImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            boxImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabelTopConstraint
        ])
    }
    
    func startShaking() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [0, 0.1, -0.1, 0.1, 0, 0]
        animation.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 1]
        animation.duration = 1
        animation.repeatCount = .infinity
        boxImageView.layer.add(animation, forKey: "shake")
    }
    
    func stopShaking() {
        boxImageView.layer.removeAnimation(forKey: "shake")
    }
    
    func startTimer(seconds: Int) {
        remainingSeconds = seconds
        updateLabel()
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerTick),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func timerTick() {
        guard remainingSeconds > 0 else {
            timer?.invalidate()
            timer = nil
            stopShaking()
            return
        }
        remainingSeconds -= 1
        updateLabel()
    }
    
    private func updateLabel() {
        let h = remainingSeconds / 3600
        let m = (remainingSeconds % 3600) / 60
        let s = remainingSeconds % 60
        let timeString = String(format: "%02d:%02d:%02d", h, m, s)
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .strokeWidth: -3,
            .kern: -1
        ]
        timerLabel.attributedText = NSAttributedString(
            string: timeString,
            attributes: strokeTextAttributes
        )
    }
}
