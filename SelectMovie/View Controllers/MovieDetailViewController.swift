//
//  MovieDetailViewController.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: Label
    @IBOutlet weak var movieTitle: UILabel!
    var movieName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialUI()
    }
    
    func setupInitialUI() {
        self.movieTitle.textColor = .black
        self.movieTitle.text = movieName
        self.view.backgroundColor = .white
    }
    
    func configureMovieName(movieName: String?) {
        self.movieName = movieName ?? ""
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
