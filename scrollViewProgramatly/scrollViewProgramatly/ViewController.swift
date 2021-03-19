//
//  ViewController.swift
//  scrollViewProgramatly
//
//  Created by Israel Torres Alvarado on 05/03/21.
//

import UIKit

class ViewController: UIViewController {

    //1.- Crear componete
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var stackView: UIStackView = {
        
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2.- agregar componete
        view.addSubview(scrollView)
        setConstraintsScrollView()
        
    }
    
    func setConstraintsScrollView() {
        
        //2.- crear constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        addSubViewsDinamyc()

    }
    
    func addSubViewsDinamyc() {
        
        for i in 1...200 {
            print("Index: \(i)")
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "index : \(i)"
            label.textAlignment = .center
            label.backgroundColor = UIColor.random
            stackView.addArrangedSubview(label)
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    
    }
    

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

