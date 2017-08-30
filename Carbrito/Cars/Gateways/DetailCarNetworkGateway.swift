import Foundation

struct DetailCarNetworkGateway: DetailCarGateway {

    private var url = "http://fipe-api.herokuapp.com/cars"
    private let getRequest: GetRequestable

    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }

    func detail(byCode code: String, andYear year: String,
                _ completionHandler: @escaping CompletionHandler<[Car], CarbritoError>) {
        getRequest.get(url: "\(url)/\(code)/\(year)") { data, error in
            let result = GenerateResultHandler<CarDecodableEntity, Car>(self.generateStruct).generate(data: data,
                                                                                                      error: error)
            completionHandler(result)
        }
    }

    private func generateStruct(carsDecodable: [CarDecodableEntity]) -> [Car] {
        return carsDecodable.map({ Car(name: $0.name, code: $0.code, year: $0.year, brand: $0.brand, price: $0.price,
                                       tax: $0.tax) })
    }

}
