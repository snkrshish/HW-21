import UIKit


final class MarvelViewController: UIViewController {

    private var marvelView: MarvelView? {
        guard isViewLoaded else { return nil }
        return view as? MarvelView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = MarvelView()
        view.backgroundColor = .systemBackground
        setupNavigationController()
    }

    //MARK: - Navigation Controller
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Marvel Superheroes"
    }
}
