//
//  MLSortViewTableViewCell.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 30-04-21.
//

import UIKit

class MLSortViewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bind(_ item: MLSortItem, isSelected: Bool) {
        nameLabel.text = item.name.localized
        backgroundColor = isSelected ? .systemGray5 : .white
    }
}
