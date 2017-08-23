 
//
//  TimberNumberInputView.swift
//  TimberNumberInputView
//
//  Created by TimberTang on 2017/8/23.
//  Copyright © 2017年 TimberTang. All rights reserved.
//


import Foundation
import UIKit
import SnapKit

enum NuberInputE {
    case text(String)
    case ensure
    case delete
}

class NumberCollectionCell : UICollectionViewCell {
    
    private let label = UILabel()
    override var isHighlighted: Bool {
        willSet {
            guard let m = model else {
                return
            }
            
            if newValue {
                label.backgroundColor = UIColor.lightGray
            } else {
                switch m {
                case .text:
                    label.backgroundColor = .clear
                case .ensure:
                    label.backgroundColor = UIColor(rgbValue: 0x28a6f7)
                case .delete:
                    label.backgroundColor = UIColor(rgbValue: 0xe5e5e5)
                }
            }
        }
    }
    
    var model : NuberInputE?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNumberCell(model : NuberInputE) {
        self.model = model
        
        switch model {
        case .text(let num):
            label.backgroundColor = .clear
            label.textColor = UIColor(rgbValue: 0x333333)
            label.font = UIFont.systemFont(ofSize: 30)
            label.text = num
        case .ensure:
            label.backgroundColor = UIColor(rgbValue: 0x28a6f7)
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "确定"
        case .delete:
            label.backgroundColor = UIColor(rgbValue: 0xe5e5e5)
            label.textColor = UIColor(rgbValue: 0x333333)
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "删除"
        }
    }
    
    private func configureView() {
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

public
class NumberInputView: UIInputView {
    
    private var collectionView : UICollectionView!
    fileprivate var sources = Array<NuberInputE>()
    
    weak var keyInput : UIKeyInput?
    
    public convenience init(keyInput : UIKeyInput) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))
        self.keyInput = keyInput
        
        self.configureView()
        
        for i in 1..<13 {
            if i == 10 {
                self.sources.append(NuberInputE.ensure)
            } else if i == 11 {
                self.sources.append(NuberInputE.text("0"))
            } else if i == 12 {
                self.sources.append(NuberInputE.delete)
            } else {
                self.sources.append(NuberInputE.text(String(i)))
            }
        }
    }
    
    private func configureView() {
        
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.0, height: 54)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flow)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        self.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NumberCollectionCell.self, forCellWithReuseIdentifier: "num")
        
        for i in 0..<3 {
            if i < 2 {
                let v = UIView()
                v.backgroundColor = .gray
                self.addSubview(v)
                
                v.snp.makeConstraints({ (make) in
                    make.left.equalTo(CGFloat(i + 1) * self.bounds.width / 3.0)
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.width.equalTo(0.5)
                })
            }
            
            let h = UIView()
            h.backgroundColor = .gray
            self.addSubview(h)
            
            h.snp.makeConstraints({ (make) in
                make.top.equalTo(CGFloat(i + 1) * self.bounds.height / 4.0)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(0.5)
            })
        }
    }
}

extension NumberInputView : UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "num", for: indexPath) as! NumberCollectionCell
        cell.configureNumberCell(model: self.sources[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.sources[indexPath.item]
        switch model {
        case .text(let num):
            self.keyInput?.insertText(num)
        case .ensure:
            if let textField = self.keyInput as? UITextField {
                textField.endEditing(true)
//                _ = textField.delegate?.textFieldShouldReturn?(textField)
            }
        case .delete:
            self.keyInput?.deleteBackward()
        }
    }
}
