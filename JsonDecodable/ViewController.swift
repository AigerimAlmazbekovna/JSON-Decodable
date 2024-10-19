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
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error:\(error.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: data,
                                                                             options: []) as? [String: Any] {
                            if let userId = jsonObject["userId"] as? Int,
                               let id = jsonObject["id"] as? Int,
                               let title = jsonObject["title"] as? String,
                               let completed = jsonObject["completed"] as? Bool {
                                let todo = Todo(userId: userId, id: id, title: title, completed: completed)
                                DispatchQueue.main.async {
                                    self.titleLabel.text = todo.title
                                }
                            }
                        }
                    } catch {
                        print("Error")
                    }
                }
            }.resume()
        }
        
    }

}

