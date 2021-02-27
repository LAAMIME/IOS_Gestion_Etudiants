//
//  etudiantCell.swift
//  GestionEtudiant
//
//  Created by Macbook on 8/30/20.
//  Copyright © 2020 MacOthmane. All rights reserved.
//

import UIKit

class etudiantCell: UITableViewCell {
   
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var photo: UIImageView!
    var id : Int!
//    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
