//
//  MovieDetailViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    //MARK: Label
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var posterHeightConstraint: NSLayoutConstraint!
    
    var movieDetails: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.alpha = 0
        contentView.transform = CGAffineTransform(translationX: 0, y: 40)
        
        UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.75) {
            self.contentView.alpha = 1
            self.contentView.transform = .identity
        }.startAnimation()
    }
    
    func setupInitialUI() {
        self.movieTitle.textColor = .black
        self.view.backgroundColor = .white
        self.scrollView.delegate = self
        
        self.movieTitle.text = movieDetails?.title
        self.movieOverview.text = movieDetails?.overview
        if let path = movieDetails?.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.moviePoster.sd_setImage(with: url, placeholderImage: UIImage(named: "posterPlaceholder"))
        }
    }
    
    func configureMovieName(movie: Movie?) {
        self.movieDetails = movie
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y < 0 {
            posterHeightConstraint.constant = 500 - y
        } else {
            posterHeightConstraint.constant = max(100, 500 - y)
        }
        
        let fadeStart: CGFloat = 0
        let fadeEnd: CGFloat = 200
        
        let alpha = 1 - ((y - fadeStart) / (fadeEnd - fadeStart))
        moviePoster.alpha = max(0.6, min(1.0, alpha))
        
    }
}
