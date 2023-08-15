//
//  ViewController.swift
//  iosdc2023
//
//  Created by Ras on 2023/08/15.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello, iOSDC2023!"
        return view
    }()

    let rotateButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("🔄ROTATE🔄", for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // subviews
        view.addSubview(titleLabel)
        view.addSubview(rotateButton)

        // constrains
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            rotateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            rotateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])

        // targets
        rotateButton.addTarget(self, action: #selector(rotate(_:)), for: .touchDown)
    }
}

extension ViewController {
    @available(iOS, obsoleted: 16.0)
    override var shouldAutorotate: Bool {
        return false
    }

    @available(iOS, obsoleted: 16.0)
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    @objc func rotate(_: UIButton) {
        if #available(iOS 16, *) {
            print("rotate pushed, but not implemented!")
        } else {
            UIDevice.current.setValue(
                UIInterfaceOrientation.portraitUpsideDown,
                forKey: "orientation"
            )
        }
    }
}
