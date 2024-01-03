import UIKit
import SnapKit

class MarvelTableViewCell: UITableViewCell {
    static let identifier = "cuustomCell"
    //MARK: - Outlets
    private lazy var heroImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "airplane")
        image.layer.cornerRadius = image.frame.height / 2
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Хухухуху"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "хехеех"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 10)
        return label
    }()

    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubview(heroImageView)
        contentView.addSubview(title)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        heroImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(10)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(5)
            $0.centerY.equalTo(contentView).offset(-15)
            $0.leading.equalTo(heroImageView.snp.trailing).offset(5)
        }
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).offset(-5)
            $0.leading.equalTo(heroImageView.snp.trailing).offset(5)
            $0.top.equalTo(title.snp.bottom).offset(3)
        }
    }
}
