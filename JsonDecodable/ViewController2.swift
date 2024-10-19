//
//  ViewController2.swift
//  JsonDecodable
//
//  Created by Айгерим on 19.10.2024.
//

import UIKit

class ViewController2: UIViewController {
    let planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        view.addSubview(planetLabel)
        setupConsstraints()
        fetchPlanetData()

        // Do any additional setup after loading the view.
    }
    

    func setupConsstraints() {
        NSLayoutConstraint.activate([
            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            planetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func fetchPlanetData() {
        let urlString = "https://swapi.dev/api/planets/1"
        guard let url = URL(string: urlString) else {
            print("Nevernyi url")
            return
            
        }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error:\(error.localizedDescription)")
                    return
                }
                guard let data = data else { return }
                    do {
                       let decoder = JSONDecoder()
                        let planet = try decoder.decode(Planet.self, from: data)
                            
                        DispatchQueue.main.async {
                self.planetLabel.text = "Период обращения: \(planet.orbitalPeriod) дней"
                                }
                    } catch {
                        print("Error")
                    }
            }.resume()
        }
        
    }
    
