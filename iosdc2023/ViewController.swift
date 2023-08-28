//
//  ViewController.swift
//  iosdc2023
//
//  Created by Ras on 2023/08/15.
//

import UIKit

class ViewController: UIViewController {
    var localSupportedInterfaceOrientations: UIInterfaceOrientationMask = .portrait

    @available(iOS, obsoleted: 16.0)
    var localShouldAutorotate: Bool = false

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hello, iOSDC2023!"
        return view
    }()

    lazy var rotateButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("🔄ROTATE🔄", for: .normal)
        view.addAction(
            UIAction { _ in self.toggleOrientations() },
            for: .touchDown
        )
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
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            rotateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            rotateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            rotateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return localSupportedInterfaceOrientations
    }

    @available(iOS, obsoleted: 16.0)
    override var shouldAutorotate: Bool {
        return localShouldAutorotate
    }

    private func toggleOrientations() {
        switch localSupportedInterfaceOrientations {
        case .portrait:
            localSupportedInterfaceOrientations = .landscape
        case .landscape:
            localSupportedInterfaceOrientations = .portrait
        default:
            fatalError("unsupported orientations")
        }

        if #available(iOS 16, *) {
            // explicitly notify the ViewController of the change in supported interface orientations,
            // and reload the `supportedInterfaceOrientations` via this method
            self.setNeedsUpdateOfSupportedInterfaceOrientations()

            guard let windowScene = view.window?.windowScene else { return }
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: localSupportedInterfaceOrientations)) { error in
                print(error)
            }
        } else {
            let orientation: UIInterfaceOrientation = {
                switch localSupportedInterfaceOrientations {
                case .portrait:
                    return .portrait
                case .landscape:
                    return .landscapeLeft
                default:
                    fatalError("unsupported orientations")
                }
            }()


            // need to allow temporary screen rotation.
            localShouldAutorotate = true
            UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
            localShouldAutorotate = false
        }
    }
}
