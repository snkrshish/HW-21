import UIKit
import SnapKit

class DetailViewController: UIViewController {

    var detailURL = ""

    var detailCharacter: FinalResult? {
        didSet {
            self.nameHero.text = detailCharacter?.name
            self.detailURL = detailCharacter?.urls.last?.url ?? ""
            guard let imagePath = detailCharacter?.thumbnail.path,
                  let imagePathExtension = detailCharacter?.thumbnail.thumbnailExtension.rawValue,
                  let imageURL = URL(string: imagePath + "." + imagePathExtension)
            else {
                imageHero.image = UIImage(named: "swift")
                return
            }
            APIManager.shared.loadImage(from: imageURL, into: imageHero)
        }
    }

    //MARK: - Outles
    private lazy var imageHero: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "swift")
        return image
    }()

    private lazy var nameHero: UILabel = {
        let label = UILabel()
        label.text = "Имя персонажа"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private lazy var buttomForMore: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.addTarget(self, action: #selector(detailButtonPressed), for: .touchUpInside)
        buttom.setTitle("Открыть список комиксов", for: .normal)
        buttom.tintColor = .systemBackground
        buttom.backgroundColor = .systemPink
        buttom.layer.cornerRadius = 10
        return buttom
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    //MARK: - Actions
    @objc private func detailButtonPressed() {
        guard let url = URL(string: detailURL) else {
            buttomForMore.titleLabel?.text = "Ссылка не найдена"
            return
        }
        UIApplication.shared.open(url)
    }


    //MARK: - Setup
    private func setupHierarchy() {
        view.addSubview(imageHero)
        view.addSubview(nameHero)
        view.addSubview(buttomForMore)
    }

    private func setupLayout() {
        imageHero.snp.makeConstraints {
            $0.top.equalTo(view).offset(20)
            $0.leading.trailing.equalTo(view).inset(40)
            $0.height.equalTo(imageHero.snp.width).offset(10)
        }

        nameHero.snp.makeConstraints {
            $0.top.equalTo(imageHero.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(view).inset(40)
            $0.height.greaterThanOrEqualTo(30)
        }

        buttomForMore.snp.makeConstraints {
            $0.top.equalTo(nameHero.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(view).inset(50)
            $0.height.greaterThanOrEqualTo(50)
        }
    }
}
