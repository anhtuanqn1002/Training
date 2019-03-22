//
//  PopupViewController.swift
//  TrainingAll
//
//  Created by TuanNVA on 3/21/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightOfContainerConstraint: NSLayoutConstraint!

    private var isFirstAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTouchUpInSideBackgroundView()
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppear {
            animatingContainerView()
        }
        isFirstAppear = false
    }
    
    private func setupTouchUpInSideBackgroundView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup(_:)))
        tapGesture.numberOfTapsRequired = 1
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissPopup(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    private func animatingContainerView() {
        containerView.alpha = 1.0
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { isFinished in
                guard isFinished else { return }
                self.addContentToPopup()
            }
        }
    }
    
    private func addContentToPopup() {
        let reportContentVC = ContentViewController()
        addChild(reportContentVC)
        reportContentVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(reportContentVC.view)
        NSLayoutConstraint.activate([
            reportContentVC.view.widthAnchor.constraint(equalTo: self.containerView.widthAnchor),
            reportContentVC.view.heightAnchor.constraint(equalTo: self.containerView.heightAnchor),
            reportContentVC.view.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            reportContentVC.view.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
            ])
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.heightOfContainerConstraint.constant = min(reportContentVC.heightOfContent, self.view.bounds.size.height * 4 / 5)
                self.view.layoutIfNeeded()
            })
        }
    }
}
