//
//  RecordsTableViewCell.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 28.10.22.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    static let id = "RecordsTableViewCell"

    weak var delegate: RecordsViewControllerDelegate?
    
    var labelForName: UILabel = {
        var labelForName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        labelForName.textColor = .black
        labelForName.font = UIFont(name: "Marker Felt", size: 40)
        labelForName.numberOfLines = 0
        labelForName.lineBreakMode = .byWordWrapping
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        return labelForName
    }()
    
    var buttonChangeColor: UIButton = {
        var buttonChangeColor = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        buttonChangeColor.translatesAutoresizingMaskIntoConstraints = false
        buttonChangeColor.setTitle("Change color", for: .normal)
        buttonChangeColor.titleLabel?.font = UIFont(name: "Marker Felt", size: 20)
        buttonChangeColor.titleLabel?.numberOfLines = 0
        buttonChangeColor.titleLabel?.lineBreakMode = .byWordWrapping
        buttonChangeColor.titleLabel?.textAlignment = .center
        buttonChangeColor.layer.cornerRadius = 20
        buttonChangeColor.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        buttonChangeColor.setTitleColor(.black, for: .normal)
        return buttonChangeColor
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "RecordsTableViewCell")
        
        self.contentView.addSubview(labelForName)
        self.contentView.addSubview(buttonChangeColor)
        
        self.contentView.backgroundColor = getRandomColor()
        
        labelForName.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        labelForName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        labelForName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        labelForName.rightAnchor.constraint(equalTo: self.buttonChangeColor.leftAnchor, constant: 10).isActive = true
        labelForName.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        
        buttonChangeColor.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        buttonChangeColor.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5).isActive = true
        buttonChangeColor.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5).isActive = true
        
        buttonChangeColor.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getRandomColor() -> UIColor {
    // drand48() возвращает случайное число в диапазоне от 0.0 до 1.0
         let red: CGFloat = CGFloat (drand48())
         let green: CGFloat = CGFloat (drand48())
         let blue: CGFloat = CGFloat (drand48())
         return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    @objc func changeColor() {
        guard var color = self.contentView.backgroundColor else { return }
        delegate?.changeColor(color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
