//
//  RouterViewController.swift
//  ExGesture
//
//  Created by 강동영 on 1/23/25.
//

import UIKit

final class RouterViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let viewControllers: [RouterPath] = RouterPath.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RouterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = viewControllers[indexPath.row].title
        configuration.textProperties.color = .label
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let router = RouterPath(rawValue: indexPath.row)!
        switch router {
        case .gestures:
            let actionVC = ActionViewController()
            navigationController?.pushViewController(actionVC, animated: true)
        case .additiveColor:
            let additiveColorVC = AdditiveColorViewController()
            navigationController?.pushViewController(additiveColorVC, animated: true)
        case .drawLine:
            let drawLineVC = DrawLineViewController()
            navigationController?.pushViewController(drawLineVC, animated: true)
        }
    }
}

extension RouterViewController {
    enum RouterPath: Int, CaseIterable {
        case gestures
        case additiveColor
        case drawLine
        
        var title: String {
            switch self {
            case .gestures:
                "Do Any Gestures"
            case .additiveColor:
                "additiveColor"
            case .drawLine:
                "Implementing coalesced touch support in an app"
            }
        }
    }
}
