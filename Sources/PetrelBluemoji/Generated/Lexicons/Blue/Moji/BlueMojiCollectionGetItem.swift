import Foundation
import Petrel

// lexicon: 1, id: blue.moji.collection.getItem

public enum BlueMojiCollectionGetItem {
    public static let typeIdentifier = "blue.moji.collection.getItem"
    public struct Parameters: Parametrizable {
        public let repo: ATIdentifier
        public let name: String

        public init(
            repo: ATIdentifier,
            name: String
        ) {
            self.repo = repo
            self.name = name
        }
    }

    public struct Output: ATProtocolCodable {
        public let uri: ATProtocolURI

        public let item: BlueMojiCollectionItem.ItemView

        /// Standard public initializer
        public init(
            uri: ATProtocolURI,

            item: BlueMojiCollectionItem.ItemView

        ) {
            self.uri = uri

            self.item = item
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            uri = try container.decode(ATProtocolURI.self, forKey: .uri)

            item = try container.decode(BlueMojiCollectionItem.ItemView.self, forKey: .item)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(uri, forKey: .uri)

            try container.encode(item, forKey: .item)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            let uriValue = try uri.toCBORValue()
            map = map.adding(key: "uri", value: uriValue)

            let itemValue = try item.toCBORValue()
            map = map.adding(key: "item", value: itemValue)

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case uri
            case item
        }
    }
}

public extension ATProtoClient.Blue.Moji.Collection {
    // MARK: - getItem

    /// Get a single emoji from a repository. Requires auth.
    ///
    /// - Parameter input: The input parameters for the request
    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func getItem(input: BlueMojiCollectionGetItem.Parameters) async throws -> (responseCode: Int, data: BlueMojiCollectionGetItem.Output?) {
        let endpoint = "blue.moji.collection.getItem"

        let queryItems = input.asQueryItems()

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "GET",
            headers: ["Accept": "application/json"],
            body: nil,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.collection.getItem")
        let proxyHeaders = serviceDID.map { ["atproto-proxy": $0] }
        let (responseData, response) = try await networkService.performRequest(urlRequest, skipTokenRefresh: false, additionalHeaders: proxyHeaders)
        let responseCode = response.statusCode

        // Only validate Content-Type and decode on success. Error responses
        // (4xx/5xx) may have missing or different Content-Type headers and
        // are handled via the status code / structured error parser below.
        if (200 ... 299).contains(responseCode) {
            guard let contentType = response.allHeaderFields["Content-Type"] as? String else {
                throw NetworkError.invalidContentType(expected: "application/json", actual: "nil")
            }

            if !contentType.lowercased().contains("application/json") {
                throw NetworkError.invalidContentType(expected: "application/json", actual: contentType)
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(BlueMojiCollectionGetItem.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.collection.getItem: \(error)")
                return (responseCode, nil)
            }
        } else {
            // If we can't parse a structured error, return the response code
            // (maintains backward compatibility for endpoints without defined errors)
            return (responseCode, nil)
        }
    }
}
