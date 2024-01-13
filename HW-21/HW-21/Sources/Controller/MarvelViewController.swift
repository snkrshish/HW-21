import UIKit


final class MarvelViewController: UIViewController {

    private var characters: [FinalResult]? = []

    //MARK: - Outlets
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MarvelTableViewCell.self, forCellReuseIdentifier: MarvelTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.fetchCharacters { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.characters = values
                self.tableView.reloadData()
            }
        }
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
        setupNavigationController()
    }

    //MARK: - setup
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Marvel Superheroes"
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MarvelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelTableViewCell.identifier, for: indexPath) as? MarvelTableViewCell
        cell?.character = characters?[indexPath.row]
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailViewController()
        detailView.detailCharacter = characters?[indexPath.row]
        present(detailView, animated: true)
    }
}
