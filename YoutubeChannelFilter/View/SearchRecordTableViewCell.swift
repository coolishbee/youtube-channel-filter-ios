//
//  SearchRecordTableViewCell.swift
//  YoutubeChannelFilter
//
//  Created by gamepub on 2022/06/29.
//

import UIKit
import SnapKit

//protocol SearchRecordTableViewCellDelegate: AnyObject {
//    func removeCell(indexPath: IndexPath)
//}

final class SearchRecordTableViewCell: UITableViewCell {
    static let reuseIdentifier = "searchRecordTableViewCell"
    
    //weak var searchRecordTableViewCellDelegate: SearchRecordTableViewCellDelegate?
    var indexPath: IndexPath?
    private(set) var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTitleLabelText(title: String) {
        titleLabel.text = title
    }
    
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { label in
            label.leading.equalTo(contentView).inset(20)
            label.top.bottom.equalTo(contentView)
            //label.trailing.equalTo()
        }
    }
    
    private func setRemoveButnImageView() {
        
    }
    
}
