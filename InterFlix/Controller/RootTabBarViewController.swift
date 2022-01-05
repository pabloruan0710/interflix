//
//  RootTabBarViewController.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import UIKit

enum Tabs: Int {
    case inicio
    case populares
    
    var title: String {
        switch self {
        case .inicio:
            return "Inicio"
        case .populares:
            return "Populares"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .inicio:
            return .inicio
        case .populares:
            return nil
        }
    }
}

extension UIImage {
    public class var inicio: UIImage? {
        return UIImage(named: "home")
    }
}

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
}
