//
//  NewsTableViewCell.swift
//  MNCTest
//
//  Created by Dimas Syuhada on 14/06/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtCategory: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    static let identifier = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    func configure(with model: NewsData){
        self.txtTitle.text = model.title
        self.txtCategory.text = "Drama"
        self.img.downloadedFrom(link: model.contentThumbnail)
    }
    
}
