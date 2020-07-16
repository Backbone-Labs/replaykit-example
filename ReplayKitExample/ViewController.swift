//
//  ViewController.swift
//  ReplayKitExample
//
//  Created by Shawn O'Connor on 7/15/20.
//

import ReplayKit
import UIKit

class ViewController: UIViewController {

    // Standard broadcast picker
    var broadcastPicker: RPSystemBroadcastPickerView = {
        // Create broadcast picker off screen we will simulate button events to trigger it
        let pickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        // Theme the picker view to match the white that we want.
        if let button = pickerView.subviews.first as? UIButton {
            button.imageView?.tintColor = UIColor.white
        }
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    // Rounded button with a title which is easier to tap
    // Also more evident which interface orientation we are in
    var broadcastButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 0)
        button.backgroundColor = .systemPink
        button.setTitle("Start Broadcast", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(broadcastButton)
        view.addSubview(broadcastPicker)
        
        // Broadcast picker is technically a button, but handle if the larger frame was tapped
        broadcastButton.addTarget(self, action: #selector(startBroadcast(sender:)), for: UIControl.Event.touchUpInside)

        // Center the buttons
        NSLayoutConstraint.activate([
            broadcastButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            broadcastButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            broadcastButton.widthAnchor.constraint(equalToConstant: 200),
            broadcastButton.heightAnchor.constraint(equalToConstant: 50),
            broadcastPicker.centerYAnchor.constraint(equalTo: broadcastButton.centerYAnchor),
            broadcastPicker.leadingAnchor.constraint(equalTo: broadcastButton.leadingAnchor, constant: 10),
            broadcastPicker.widthAnchor.constraint(equalToConstant: 40),
            broadcastPicker.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func startBroadcast(sender: UIButton) {
        // make button easier to hit, relay press
        if let button = broadcastPicker.subviews.first as? UIButton {
            button.sendActions(for: UIControl.Event.allTouchEvents)
        }
    }
}

