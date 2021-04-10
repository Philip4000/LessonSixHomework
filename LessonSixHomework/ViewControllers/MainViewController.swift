//
//  MainViewController.swift
//  LessonSixHomework
//
//  Created by Philip Noskov on 10.04.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(from settingsView: UIColor)
}

class MainViewController: UIViewController {

    @IBOutlet weak var startView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.backgroundColor = startView.backgroundColor
            settingsVC.delegate = self
        }
        
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(from settingsView: UIColor) {
        startView.backgroundColor = settingsView
    }
}

