//
//  EmptyStateView.swift
//  WeatherApp
//
//  Created by Fede Flores on 03/03/2024.
//

import UIKit

class EmptyStateView: UIView {
    
    private enum Constants {
        static let titleLabelNumberOfLines: Int = 0
        static let titlelabelFontSize: CGFloat = 32
        static let subtitlelabelFontSize: CGFloat = 24
        static let buttonCornerRadius: CGFloat = 12
        static let imageViewSize: CGFloat = 200
        static let imageViewTopPadding: CGFloat = 80
        static let titleLabelTopPadding: CGFloat = 50
        static let titleLabelHorizontalPadding: CGFloat = 24
        static let subtitleLabelTopPadding: CGFloat = 20
        static let subtitleLabelHorizontalPadding: CGFloat = 24
        static let buttonHorizontalPadding: CGFloat = 24
        static let buttonHeight: CGFloat = 50
        static let buttonBottomPadding: CGFloat = 80
        static let imageViewImageName: String = "exclamationmark.warninglight.fill"
    }
    
    private enum Wording {
        static let titleLabelText = "There's been a problem!"
        static let ButtonText = "Try again!"
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var action: (()->())?
    
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.imageViewImageName)?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = Wording.titleLabelText
        label.numberOfLines = Constants.titleLabelNumberOfLines
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: Constants.titlelabelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: Constants.subtitlelabelFontSize, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.textColor = UIColor.white
        button.setTitle(Wording.ButtonText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(subtitle: String? = nil, action: (() -> Void)? = nil) {
        self.subtitle = subtitle
        self.action = action
        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubviews() {
        backgroundColor = UIColor.black
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(button)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }
    
    private func setupConstraints() {
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize).isActive = true
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.imageViewTopPadding).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleLabelTopPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.titleLabelHorizontalPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.titleLabelHorizontalPadding).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleLabelTopPadding).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.subtitleLabelHorizontalPadding).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.subtitleLabelHorizontalPadding).isActive = true
        
        button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.buttonHorizontalPadding).isActive = true
        button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.buttonHorizontalPadding).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.buttonBottomPadding).isActive = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        action?()
    }    
}
