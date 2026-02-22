//
//  MovieDetailViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit
import SDWebImage
import AVKit

class MovieDetailViewController: UIViewController {
    
    //MARK: Label
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var posterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailerButton: UIButton!
    
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
        self.trailerButton.setTitle("Watch Trailer", for: .normal)
        self.trailerButton.setTitleColor(.white, for: .normal)
        self.trailerButton.tintColor = .brown
        self.trailerButton.backgroundColor = .brown
        self.trailerButton.layer.cornerRadius = 8
    }
    
    func configureMovieName(movie: Movie?) {
        self.movieDetails = movie
    }
    
    func playPlayer() async {
        guard let movieId = movieDetails?.id else {return}
        
        do {
            guard let trailerKey = try await APIService.shared.getTrailerKey(for: movieId) else {return}
            let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)")!
            presentPlayer(with: youtubeURL)
        } catch {
            print("Error", error)
        }
    }
    
    func presentPlayer(with url: URL) {
        print(url) //Just to show we have received the url, but AVKit cannot play YouTube videos, hence a sample link of .mp4
        let newUrl = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!
        let player = AVPlayer(url: newUrl)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        playerVC.modalPresentationStyle = .custom
        playerVC.transitioningDelegate = self
        
        present(playerVC, animated: true) {
            player.play()
        }
    }
}

//MARK: Scroll View Delegates
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

//MARK: IBActions
extension MovieDetailViewController: UIViewControllerTransitioningDelegate {
    @IBAction func showTrailer(_ sender: UIButton) {
        Task {
            await playPlayer()
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return TrailerAnimator()
    }
}
