import Foundation
import Petrel

// lexicon: 1, id: blue.moji.feed.getReactionCounts

public enum BlueMojiFeedGetReactionCounts {
    public static let typeIdentifier = "blue.moji.feed.getReactionCounts"

    public struct SubjectReactionCounts: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.feed.getReactionCounts#subjectReactionCounts"
        public let uri: ATProtocolURI
        public let groups: [BlueMojiFeedDefs.ReactionGroup]

        public init(
            uri: ATProtocolURI, groups: [BlueMojiFeedDefs.ReactionGroup]
        ) {
            self.uri = uri
            self.groups = groups
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                uri = try container.decode(ATProtocolURI.self, forKey: .uri)
            } catch {
                LogManager.logError("Decoding error for required property 'uri': \(error)")
                throw error
            }
            do {
                groups = try container.decode([BlueMojiFeedDefs.ReactionGroup].self, forKey: .groups)
            } catch {
                LogManager.logError("Decoding error for required property 'groups': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(uri, forKey: .uri)
            try container.encode(groups, forKey: .groups)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(uri)
            hasher.combine(groups)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if uri != other.uri {
                return false
            }
            if groups != other.groups {
                return false
            }
            return true
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            let uriValue = try uri.toCBORValue()
            map = map.adding(key: "uri", value: uriValue)
            let groupsValue = try groups.toCBORValue()
            map = map.adding(key: "groups", value: groupsValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case uri
            case groups
        }
    }

    public struct Parameters: Parametrizable {
        public let uris: [ATProtocolURI]

        public init(
            uris: [ATProtocolURI]
        ) {
            self.uris = uris
        }
    }

    public struct Output: ATProtocolCodable {
        public let counts: [SubjectReactionCounts]

        /// Standard public initializer
        public init(
            counts: [SubjectReactionCounts]

        ) {
            self.counts = counts
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            counts = try container.decode([SubjectReactionCounts].self, forKey: .counts)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(counts, forKey: .counts)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            let countsValue = try counts.toCBORValue()
            map = map.adding(key: "counts", value: countsValue)

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case counts
        }
    }
}

public extension ATProtoClient.Blue.Moji.Feed {
    // MARK: - getReactionCounts

    /// Batch version of blue.moji.feed.getReactions for timelines: aggregated reaction groups (counts only, no paginated individual reactions) for many posts in one call, avoiding an N+1 fetch per rendered post. Use getReactions for a single post's full detail (e.g. its own dedicated view with an actor list).
    ///
    /// - Parameter input: The input parameters for the request
    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func getReactionCounts(input: BlueMojiFeedGetReactionCounts.Parameters) async throws -> (responseCode: Int, data: BlueMojiFeedGetReactionCounts.Output?) {
        let endpoint = "blue.moji.feed.getReactionCounts"

        let queryItems = input.asQueryItems()

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "GET",
            headers: ["Accept": "application/json"],
            body: nil,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.feed.getReactionCounts")
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
                let decodedData = try decoder.decode(BlueMojiFeedGetReactionCounts.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.feed.getReactionCounts: \(error)")
                return (responseCode, nil)
            }
        } else {
            // If we can't parse a structured error, return the response code
            // (maintains backward compatibility for endpoints without defined errors)
            return (responseCode, nil)
        }
    }
}
