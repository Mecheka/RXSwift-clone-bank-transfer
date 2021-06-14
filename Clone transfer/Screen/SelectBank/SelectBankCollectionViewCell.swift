//
//  SelectBankCollectionViewCell.swift
//  Clone transfer
//
//  Created by Suriya on 13/6/2564 BE.
//

import UIKit

class SelectBankCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBank: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ bank: Bank)  {
        if let image = bank.abv {
            imageBank.image = UIImage(named: image)
            bankName.text = image
        }
    }
}
