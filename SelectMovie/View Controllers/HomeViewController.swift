//
//  ViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit

//let movies = ["Interstellar", "Inception", "Machinist", "Prestige"]

@MainActor
class HomeViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTblVwCell", for: indexPath) as? MovieTblVwCell else { return UITableViewCell(style: .default, reuseIdentifier: "MovieTblVwCell")}
        cell.alpha = 0
        cell.configureCell(textContent: movies[indexPath.row].title)
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController (
            withIdentifier: "MovieDetailViewController"
        ) as? MovieDetailViewController else {return}
        vc.configureMovieName(movieName: movies[indexPath.row].title)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
