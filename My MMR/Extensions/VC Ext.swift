//
//  VC Ext.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import UIKit

fileprivate var contentView : UIView!
extension UIViewController {
   
    func presentAlertOnMainThread(title : String , message : String , buttonTitle : String){
        DispatchQueue.main.async {
        let alertVC = Alert(title: title, message: message, buttonTitel: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingScreen(){
        contentView = UIView(frame: view.bounds)
        view.addSubview(contentView)
        contentView.backgroundColor = .systemBackground
        contentView.alpha           = 0
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activitiIndicator)

        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        UIView.animate(withDuration: 0.25) { contentView.alpha = 0.8  }
        activitiIndicator.startAnimating()
    }
    
    func stopLoadingScreen(){
        DispatchQueue.main.async {
            guard contentView != nil else {return}
            contentView.removeFromSuperview()
            contentView = nil
        }
    }
    
}
