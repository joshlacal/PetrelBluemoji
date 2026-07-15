import Foundation
import Petrel

// lexicon: 1, id: blue.moji.collection.putItem

public enum BlueMojiCollectionPutItem {
    public static let typeIdentifier = "blue.moji.collection.putItem"
    public struct Input: ATProtocolCodable {
        public let repo: ATIdentifier
        public let validate: Bool?
        public let item: BlueMojiCollectionItem.ItemView

        /// Standard public initializer
        public init(repo: ATIdentifier, validate: Bool? = nil, item: BlueMojiCollectionItem.ItemView) {
            self.repo = repo
            self.validate = validate
            self.item = item
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            repo = try container.decode(ATIdentifier.self, forKey: .repo)
            validate = try container.decodeIfPresent(Bool.self, forKey: .validate)
            item = try container.decode(BlueMojiCollectionItem.ItemView.self, forKey: .item)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(repo, forKey: .repo)
            try container.encodeIfPresent(validate, forKey: .validate)
            try container.encode(item, forKey: .item)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            let repoValue = try repo.toCBORValue()
            map = map.adding(key: "repo", value: repoValue)
            if let value = validate {
                let validateValue = try value.toCBORValue()
                map = map.adding(key: "validate", value: validateValue)
            }
            let itemValue = try item.toCBORValue()
            map = map.adding(key: "item", value: itemValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case repo
            case validate
            case item
        }
    }

    public struct Output: ATProtocolCodable {
        public let uri: ATProtocolURI

        /// Standard public initializer
        public init(
            uri: ATProtocolURI

        ) {
            self.uri = uri
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            uri = try container.decode(ATProtocolURI.self, forKey: .uri)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(uri, forKey: .uri)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            let uriValue = try uri.toCBORValue()
            map = map.adding(key: "uri", value: uriValue)

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case uri
        }
    }
}

public extension ATProtoClient.Blue.Moji.Collection {
    // MARK: - putItem

    // Write a Bluemoji record, creating or updating it as needed. Requires auth, implemented by AppView.
    //
    // - Parameter input: The input parameters for the request

    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func putItem(
        input: BlueMojiCollectionPutItem.Input

    ) async throws -> (responseCode: Int, data: BlueMojiCollectionPutItem.Output?) {
        let endpoint = "blue.moji.collection.putItem"

        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"

        headers["Accept"] = "application/json"

        let requestData: Data? = try JSONEncoder().encode(input)

        let queryItems: [URLQueryItem]? = nil

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "POST",
            headers: headers,
            body: requestData,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.collection.putItem")
        let proxyHeaders = serviceDID.map { ["atproto-proxy": $0] }
        let (responseData, response) = try await networkService.performRequest(urlRequest, skipTokenRefresh: false, additionalHeaders: proxyHeaders)
        let responseCode = response.statusCode

        // Only validate Content-Type and decode on success. Error responses
        // (4xx/5xx) may have missing or different Content-Type headers and
        // are handled by the caller via the status code.
        if (200 ... 299).contains(responseCode) {
            guard let contentType = response.allHeaderFields["Content-Type"] as? String else {
                throw NetworkError.invalidContentType(expected: "application/json", actual: "nil")
            }

            if !contentType.lowercased().contains("application/json") {
                throw NetworkError.invalidContentType(expected: "application/json", actual: contentType)
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(BlueMojiCollectionPutItem.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.collection.putItem: \(error)")
                return (responseCode, nil)
            }
        } else {
            // Don't try to decode error responses as success types
            return (responseCode, nil)
        }
    }
}
