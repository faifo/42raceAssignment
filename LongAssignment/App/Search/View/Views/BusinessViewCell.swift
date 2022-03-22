//
//  BusinessViewCell.swift
//  LongAssignment
//
//  Created by Solo on 23/03/2022.
//

import UIKit
import Kingfisher
class BusinessViewCell: UITableViewCell {

    @IBOutlet weak var businessImageName: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    static let identifier = "BusinessViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BusinessViewCell: ModelConfigurable {
    func configure(with model: BusinessViewData) {
        if let imgUrl = URL(string: model.imageUrl) {
            businessImageView.kf.setImage(with: imgUrl)
        }
        businessImageName.text = model.name
        distanceLabel.text = "Distance : \(model.distance)"
        ratingLabel.text = "Rating: \(model.rating)"
        
    }
}

