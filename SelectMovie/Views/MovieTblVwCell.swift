//
//  MovieTblVwCell.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 18/02/26.
//

import UIKit

class MovieTblVwCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupInitialUI() {
        self.backgroundColor = .white
        self.label.textColor = .black        
    }
    
    func configureCell(textContent: String?) {
        self.label.text = textContent
    }
    
}
