//
//  ProductImageCell.swift
//  Assignment
//
//  Created by Anil on 23/05/21.
//

import UIKit

class ProductImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayContent(itemImage : String) {
        imageView.sd_setImage(with: URL(string: itemImage), placeholderImage: UIImage(named: ""))
    }

}
