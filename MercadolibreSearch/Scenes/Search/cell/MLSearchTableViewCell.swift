//
//  MLSearchTableViewCell.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 01-05-21.
//

import UIKit

class MLSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bind(item: MLSearchObject) {
        searchTextLabel.text = item.text
        dateLabel.text = item.lastUpdate?.timeAgoDisplay()
    }

}
