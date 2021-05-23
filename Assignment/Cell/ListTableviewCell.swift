//
//  ListTableviewCell.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import UIKit
import SDWebImage

class ListTableviewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descLbl: UILabel!
    var productCollectionModel : [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 30.0
        imgView.backgroundColor = UIColor.gray
        productCollectionModel = []
        collectionViewHeightConstraint.constant = 50
        collectionView.register(UINib(nibName: "ProductImageCell", bundle: nil), forCellWithReuseIdentifier: "productimagecell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    func displayContent(item : users?) {
        titleLbl.text = item?.name ?? ""
        descLbl.text = item?.description ?? ""
        imgView.sd_setImage(with: URL(string: item?.image ?? ""), placeholderImage: UIImage(named: ""))
        print("User name : \(item?.name ?? "")")
        print("Item images name : \(item?.items ?? [])")
        productCollectionModel = item?.items ?? []
        
        frame = self.bounds
        layoutIfNeeded()
        collectionView.reloadData()
        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }

}

extension ListTableviewCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCollectionModel!.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productimagecell", for: indexPath) as! ProductImageCell
        cell.layer.cornerRadius = 8
        cell.displayContent(itemImage : "\(productCollectionModel![indexPath.row])")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if productCollectionModel!.count == 1{
            return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.width)
        }else if productCollectionModel!.count % 2 == 0{
            return CGSize(width: (collectionView.frame.size.width-10)/2 - 10 , height: (collectionView.frame.size.width-10)/2 - 10)
        }else{
            if indexPath.row == 0{
                return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.width)
            }else{
                return CGSize(width: (collectionView.frame.size.width-10)/2 , height: (collectionView.frame.size.width-10)/2)
            }
        }
        
    }
    
}
