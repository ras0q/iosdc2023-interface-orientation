//
//  ViewController.swift
//  iosdc2023
//
//  Created by Ras on 2023/08/15.
//

import UIKit

class ViewController: UIViewController {
    var isRotated: Bool = false {
        didSet {
            let orientation: UIInterfaceOrientationMask = isRotated
                ? .portrait
                : .landscape

            if #available(iOS 16, *) {
                guard
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
                        as? SceneDelegate
                else {
                    return
                }

                guard let windowScene = sceneDelegate.window?.windowScene else {
                    return
                }

                windowScene.requestGeometryUpdate(
                    .iOS(interfaceOrientations: orientation)
                ) { error in
                    print(error)
                }
            } else {
                UIDevice.current.setValue(orientation, forKey: "orientation")
            }
        }
    }

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

        // actions
        rotateButton.addAction(
            UIAction { _ in
                self.isRotated.toggle()
                if #available(iOS 16.0, *) {
                    // explicitly notify the VC of the change in supported interface orientations
                    self.setNeedsUpdateOfSupportedInterfaceOrientations()
                }
            },
            for: .touchDown
        )
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if isRotated {
            return .landscape
        } else {
            return .portrait
        }
    }

    @available(iOS, obsoleted: 16.0)
    override var shouldAutorotate: Bool {
        return false
    }
}
