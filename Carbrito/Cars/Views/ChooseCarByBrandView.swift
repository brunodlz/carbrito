import UIKit

final class ChooseCarByBrandView: UITableView {

    enum ActionName: String {
        case didSelectBrandCar
    }

    private let actions: [ActionName: ((BrandCar) -> Void)]

    private lazy var dataProvider: GenericDataProvider<BrandCar> = {
        let dataProvider = GenericDataProvider<BrandCar>(items: [], cellDescriptor: { item -> CellDescriptor in
            return CellDescriptor(identifier: String(describing: UITableViewCell.self)) { (cell: UITableViewCell) in
                cell.textLabel?.text = item.name
            }
        }, didSelectItem: { brandCar in
            self.execute(action: .didSelectBrandCar, brandCar: brandCar)
        })
        return dataProvider
    }()

    init(parentView: UIView, actions: [ActionName: ((BrandCar) -> Void)]) {
        self.actions = actions
        super.init(frame: .zero, style: .plain)
        setupView(parentView: parentView)
        delegate = dataProvider
        dataSource = dataProvider
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(Log.initCoder(from: CarFormView.self))
    }

    private func setupView(parentView: UIView) {
        backgroundColor = .white
        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let safeArea = parentView.safeAreaLayoutGuide
        topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
    }

    private func execute(action: ActionName, brandCar: BrandCar) {
        guard let actionCallback = actions[action] else { return Log.notLinked(action: action.rawValue) }
        actionCallback(brandCar)
    }

}

extension ChooseCarByBrandView: ListCarsByBrandPresenter {

    func present(brandCars: [BrandCar]) {
        dataProvider.tableView(self, updateItems: brandCars)
    }

    func present(error: BrandCarError) {
    }

    func presentEmpty() {}

}