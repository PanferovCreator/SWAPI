//
//  CharacterDetailViewController.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 12/07/23.
//

import UIKit
import SnapKit

class CharacterDetailViewController: UIViewController {
    
    var character: Character?
    
    // MARK: - Private Properties
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.createBorder(for: imageView, with: 3, color: .black, cornerRadius: 20)
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: character?.name ?? "")
        return imageView
    }()
    
    private var planetView: UIView = {
        let view = UIView()
        view.createBorder(for: view, with: 3, color: .systemMint, cornerRadius: 20)
        return view
    }()
    
    private var descriptionView: UIView = {
        let view = UIView()
        view.createBorder(for: view, with: 3, color: .systemYellow, cornerRadius: 20)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemYellow
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = character?.description
        return label
    }()
    
    private var planetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Hello"
        
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews(characterImageView, descriptionLabel, descriptionView, planetView)
        setConstraints()
    }
    // MARK: - Private Methods
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        characterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(400)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalTo(descriptionView).inset(12)
            $0.height.lessThanOrEqualTo(200)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(200)
        }
        
        planetView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(50)
        }
    }
}

extension UIView {
    func createBorder(for view: UIView, with width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        view.layer.cornerRadius = cornerRadius
    }
}

