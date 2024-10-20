//
//  ViewController.swift
//  JsonDecodable
//
//  Created by Айгерим on 19.10.2024.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(titleLabel)
        setupConsstraints()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func setupConsstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    func fetchData() {
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: urlString) else {
            print("oshibka nevernyi url")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                    print("error:\(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("Error dannye otsutstvuyut")
                    return
                }
            do {
                let todo = try JSONDecoder().decode(Todo.self, from: data)
                DispatchQueue.main.async {
                    self.titleLabel.text = todo.title
                }
            } catch {
                print("error")
            }
            
        }.resume()
    }
}
