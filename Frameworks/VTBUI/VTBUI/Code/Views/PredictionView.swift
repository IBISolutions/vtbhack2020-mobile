//
//  PredictionView.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit
import SnapKit
import Resources

public class PredictionView: CustomView {
    
    private enum Layouts {
        static let size = CGSize(width: 270, height: 124)
        static let cornerRadius: CGFloat = 8
        
        enum Header {
            static let height: CGFloat = 54
        }
        enum Offers {
            static let bottom: CGFloat = 25
        }
    }
    
    private let headerView = UIView(backgroundColor: Color.primaryBlue,
                                    isHidden: false,
                                    isUserInteractionEnabled: false)
    
    private let carNameLabel = UILabel(size: 14, weight: .bold, color: .white)
    private let offersLabel = UILabel(size: 14, weight: .regular, color: .black)
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = Color.primaryBlue
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = Layouts.cornerRadius
        clipsToBounds = true
        addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(Layouts.Header.height)
        }
        headerView.addSubview(carNameLabel)
        carNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        addSubview(offersLabel)
        offersLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Layouts.Offers.bottom)
        }
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(offersLabel.snp.bottom)
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        Layouts.size
    }
    
    public func configure(header: String = "", offers: String = "", showsLoader: Bool = false) {
        carNameLabel.text = header
        offersLabel.text = offers
        showsLoader ? indicator.startAnimating() : indicator.stopAnimating()
    }
}
