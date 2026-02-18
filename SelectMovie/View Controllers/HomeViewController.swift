//
//  ViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit

let movies = ["Interstellar", "Inception", "Machinist", "Prestige"]

class HomeViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTblVwCell", bundle: nil), forCellReuseIdentifier: "MovieTblVwCell")
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTblVwCell", for: indexPath) as? MovieTblVwCell else { return UITableViewCell(style: .default, reuseIdentifier: "MovieTblVwCell")}
        cell.alpha = 0
        cell.configureCell(textContent: movies[indexPath.row])
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieName = movies[indexPath.row]
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController (
            withIdentifier: "MovieDetailViewController"
        ) as? MovieDetailViewController else {return}
        vc.configureMovieName(movieName: movieName)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

