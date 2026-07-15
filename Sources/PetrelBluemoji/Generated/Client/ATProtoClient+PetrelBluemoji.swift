import Foundation
import Petrel

// Generated namespace extensions for the PetrelBluemoji overlay package.

public extension ATProtoClient {
    var blue: Blue {
        Blue(networkService: networkService)
    }

    final class Blue: @unchecked Sendable {
        public let networkService: NetworkService
        public init(networkService: NetworkService) {
            self.networkService = networkService
        }

        public lazy var moji: Moji = .init(networkService: networkService)

        public final class Moji: @unchecked Sendable {
            public let networkService: NetworkService
            public init(networkService: NetworkService) {
                self.networkService = networkService
            }

            public lazy var collection: Collection = .init(networkService: networkService)

            public final class Collection: @unchecked Sendable {
                public let networkService: NetworkService
                public init(networkService: NetworkService) {
                    self.networkService = networkService
                }
            }

            public lazy var embed: Embed = .init(networkService: networkService)

            public final class Embed: @unchecked Sendable {
                public let networkService: NetworkService
                public init(networkService: NetworkService) {
                    self.networkService = networkService
                }
            }

            public lazy var feed: Feed = .init(networkService: networkService)

            public final class Feed: @unchecked Sendable {
                public let networkService: NetworkService
                public init(networkService: NetworkService) {
                    self.networkService = networkService
                }
            }

            public lazy var packs: Packs = .init(networkService: networkService)

            public final class Packs: @unchecked Sendable {
                public let networkService: NetworkService
                public init(networkService: NetworkService) {
                    self.networkService = networkService
                }
            }

            public lazy var richtext: Richtext = .init(networkService: networkService)

            public final class Richtext: @unchecked Sendable {
                public let networkService: NetworkService
                public init(networkService: NetworkService) {
                    self.networkService = networkService
                }
            }
        }
    }
}
