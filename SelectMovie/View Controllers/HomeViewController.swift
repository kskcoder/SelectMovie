//
//  ViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit
import SDWebImage

@MainActor
class HomeViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        
        fetchMovies()
        
        tableView.backgroundColor = .cyan
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTblVwCell", bundle: nil), forCellReuseIdentifier: "MovieTblVwCell")
    }
    
    private func fetchMovies() {
        Task {
            do {
                let responseMovies = try await APIService.shared.fetchMovies()
                self.movies = responseMovies
                self.tableView.reloadData()
            } catch {
                print("Error", error)
            }
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTblVwCell", for: indexPath) as? MovieTblVwCell else { return UITableViewCell(style: .default, reuseIdentifier: "MovieTblVwCell")}
        cell.movieImage.image = nil
        cell.configureCell(textContent: movies[indexPath.section].title)
        cell.startShimmer()
        let posterPath = movies[indexPath.section].posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        cell.movieImage.sd_setImage(with: url, placeholderImage: UIImage(named: "posterPlaceholder"))
        cell.stopShimmer()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController (
            withIdentifier: "MovieDetailViewController"
        ) as? MovieDetailViewController else {return}
        vc.configureMovieName(movie: movies[indexPath.section])
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
            
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
    }
}
