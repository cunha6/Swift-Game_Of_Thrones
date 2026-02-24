//
//  MyCollectionViewCell.swift
//  GRUPO_FLG_3_M1
//
//  Created by Fábio Oliveira on 19/11/2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    
    //mudar notificaçoes para botao- acoes nas notificaçoes
    //

}
