struct DetailCarGatewayFactory {

    static func make() -> DetailCarGateway {
        return DetailCarNetworkGateway()
    }

}
