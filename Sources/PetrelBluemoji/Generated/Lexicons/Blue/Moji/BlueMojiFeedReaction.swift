import Foundation
import Petrel

// lexicon: 1, id: blue.moji.feed.reaction

public struct BlueMojiFeedReaction: ATProtocolCodable, ATProtocolValue {
    public static let typeIdentifier = "blue.moji.feed.reaction"
    public let subject: ATProtocolURI
    public let subjectCid: CID?
    public let emoji: EmojiRef
    public let createdAt: ATProtocolDate

    public init(subject: ATProtocolURI, subjectCid: CID?, emoji: EmojiRef, createdAt: ATProtocolDate) {
        self.subject = subject
        self.subjectCid = subjectCid
        self.emoji = emoji
        self.createdAt = createdAt
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        subject = try container.decode(ATProtocolURI.self, forKey: .subject)
        do {
            subjectCid = try container.decodeIfPresent(CID.self, forKey: .subjectCid)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'subjectCid' — degrading to nil: \(error)")
            subjectCid = nil
        }
        emoji = try container.decode(EmojiRef.self, forKey: .emoji)
        createdAt = try container.decode(ATProtocolDate.self, forKey: .createdAt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
        try container.encode(subject, forKey: .subject)
        try container.encodeIfPresent(subjectCid, forKey: .subjectCid)
        try container.encode(emoji, forKey: .emoji)
        try container.encode(createdAt, forKey: .createdAt)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }

    public func isEqual(to other: any ATProtocolValue) -> Bool {
        guard let other = other as? Self else { return false }
        if subject != other.subject {
            return false
        }
        if subjectCid != other.subjectCid {
            return false
        }
        if emoji != other.emoji {
            return false
        }
        if createdAt != other.createdAt {
            return false
        }
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(subject)
        if let value = subjectCid {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        hasher.combine(emoji)
        hasher.combine(createdAt)
    }

    public func toCBORValue() throws -> Any {
        var map = OrderedCBORMap()
        map = map.adding(key: "$type", value: Self.typeIdentifier)
        let subjectValue = try subject.toCBORValue()
        map = map.adding(key: "subject", value: subjectValue)
        if let value = subjectCid {
            let subjectCidValue = try value.toCBORValue()
            map = map.adding(key: "subjectCid", value: subjectCidValue)
        }
        let emojiValue = try emoji.toCBORValue()
        map = map.adding(key: "emoji", value: emojiValue)
        let createdAtValue = try createdAt.toCBORValue()
        map = map.adding(key: "createdAt", value: createdAtValue)
        return map
    }

    private enum CodingKeys: String, CodingKey {
        case typeIdentifier = "$type"
        case subject
        case subjectCid
        case emoji
        case createdAt
    }

    public struct EmojiRef: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.feed.reaction#emojiRef"
        public let uri: ATProtocolURI
        public let cid: CID?
        public let name: String
        public let alt: String?
        public let adultOnly: Bool?
        public let formats: EmojiRefFormatsUnion

        public init(
            uri: ATProtocolURI, cid: CID?, name: String, alt: String?, adultOnly: Bool?, formats: EmojiRefFormatsUnion
        ) {
            self.uri = uri
            self.cid = cid
            self.name = name
            self.alt = alt
            self.adultOnly = adultOnly
            self.formats = formats
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
                cid = try container.decodeIfPresent(CID.self, forKey: .cid)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'cid' — degrading to nil: \(error)")
                cid = nil
            }
            do {
                name = try container.decode(String.self, forKey: .name)
            } catch {
                LogManager.logError("Decoding error for required property 'name': \(error)")
                throw error
            }
            do {
                alt = try container.decodeIfPresent(String.self, forKey: .alt)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'alt' — degrading to nil: \(error)")
                alt = nil
            }
            do {
                adultOnly = try container.decodeIfPresent(Bool.self, forKey: .adultOnly)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'adultOnly' — degrading to nil: \(error)")
                adultOnly = nil
            }
            do {
                formats = try container.decode(EmojiRefFormatsUnion.self, forKey: .formats)
            } catch {
                LogManager.logError("Decoding error for required property 'formats': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(uri, forKey: .uri)
            try container.encodeIfPresent(cid, forKey: .cid)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(alt, forKey: .alt)
            try container.encodeIfPresent(adultOnly, forKey: .adultOnly)
            try container.encode(formats, forKey: .formats)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(uri)
            if let value = cid {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(name)
            if let value = alt {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = adultOnly {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(formats)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if uri != other.uri {
                return false
            }
            if cid != other.cid {
                return false
            }
            if name != other.name {
                return false
            }
            if alt != other.alt {
                return false
            }
            if adultOnly != other.adultOnly {
                return false
            }
            if formats != other.formats {
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
            if let value = cid {
                let cidValue = try value.toCBORValue()
                map = map.adding(key: "cid", value: cidValue)
            }
            let nameValue = try name.toCBORValue()
            map = map.adding(key: "name", value: nameValue)
            if let value = alt {
                let altValue = try value.toCBORValue()
                map = map.adding(key: "alt", value: altValue)
            }
            if let value = adultOnly {
                let adultOnlyValue = try value.toCBORValue()
                map = map.adding(key: "adultOnly", value: adultOnlyValue)
            }
            let formatsValue = try formats.toCBORValue()
            map = map.adding(key: "formats", value: formatsValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case uri
            case cid
            case name
            case alt
            case adultOnly
            case formats
        }
    }

    public enum EmojiRefFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiRichtextFacetFormatsV0(BlueMojiRichtextFacet.Formats_v0)
        case blueMojiRichtextFacetFormatsV1(BlueMojiRichtextFacet.Formats_v1)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiRichtextFacet.Formats_v0) {
            self = .blueMojiRichtextFacetFormatsV0(value)
        }

        public init(_ value: BlueMojiRichtextFacet.Formats_v1) {
            self = .blueMojiRichtextFacetFormatsV1(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.richtext.facet#formats_v0":
                let value = try BlueMojiRichtextFacet.Formats_v0(from: decoder)
                self = .blueMojiRichtextFacetFormatsV0(value)
            case "blue.moji.richtext.facet#formats_v1":
                let value = try BlueMojiRichtextFacet.Formats_v1(from: decoder)
                self = .blueMojiRichtextFacetFormatsV1(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiRichtextFacetFormatsV0(value):
                try container.encode("blue.moji.richtext.facet#formats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .blueMojiRichtextFacetFormatsV1(value):
                try container.encode("blue.moji.richtext.facet#formats_v1", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiRichtextFacetFormatsV0(value):
                hasher.combine("blue.moji.richtext.facet#formats_v0")
                hasher.combine(value)
            case let .blueMojiRichtextFacetFormatsV1(value):
                hasher.combine("blue.moji.richtext.facet#formats_v1")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: EmojiRefFormatsUnion, rhs: EmojiRefFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiRichtextFacetFormatsV0(lhsValue),
                      .blueMojiRichtextFacetFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.blueMojiRichtextFacetFormatsV1(lhsValue),
                      .blueMojiRichtextFacetFormatsV1(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? EmojiRefFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiRichtextFacetFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.richtext.facet#formats_v0")

                let valueDict = try value.toCBORValue()

                // If the value is already an OrderedCBORMap, merge its entries
                if let orderedMap = valueDict as? OrderedCBORMap {
                    for (key, value) in orderedMap.entries where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                } else if let dict = valueDict as? [String: Any] {
                    // Otherwise add each key-value pair from the dictionary
                    for (key, value) in dict where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                }
                return map
            case let .blueMojiRichtextFacetFormatsV1(value):
                map = map.adding(key: "$type", value: "blue.moji.richtext.facet#formats_v1")

                let valueDict = try value.toCBORValue()

                // If the value is already an OrderedCBORMap, merge its entries
                if let orderedMap = valueDict as? OrderedCBORMap {
                    for (key, value) in orderedMap.entries where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                } else if let dict = valueDict as? [String: Any] {
                    // Otherwise add each key-value pair from the dictionary
                    for (key, value) in dict where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                }
                return map
            case let .unexpected(container):
                return try container.toCBORValue()
            }
        }
    }
}
