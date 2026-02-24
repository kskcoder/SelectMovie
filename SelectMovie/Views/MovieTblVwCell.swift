//
//  MovieTblVwCell.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit

class MovieTblVwCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    let gradientLayer = CAGradientLayer()
    let shimmerLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImage.image = nil
    }
    
    func setupInitialUI() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.movieTitle.textColor = .black
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = movieImage.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        gradientLayer.locations = [0.7, 1.0]
        
        if gradientLayer.superlayer == nil {
            movieImage.layer.addSublayer(gradientLayer)
        }
    }
    
    func configureCell(textContent: String?) {
        self.movieTitle.text = textContent
    }
    
    func startShimmer() {
        shimmerLayer.frame = movieImage.bounds
        shimmerLayer.colors = [
            UIColor.lightGray.cgColor,
            UIColor.white.cgColor,
            UIColor.lightGray.cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        shimmerLayer.locations = [0.0, 0.5, 1.0]
        
        movieImage.layer.addSublayer(shimmerLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.2
        animation.repeatCount = .infinity
        
        DispatchQueue.main.async { [weak self] in
            self?.shimmerLayer.add(animation, forKey: "shimmer")
        }
    }
    
    func stopShimmer() {
        shimmerLayer.removeFromSuperlayer()
    }
}
