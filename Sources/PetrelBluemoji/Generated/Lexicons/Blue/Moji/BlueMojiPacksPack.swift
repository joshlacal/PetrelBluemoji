import Foundation
import Petrel

// lexicon: 1, id: blue.moji.packs.pack

public struct BlueMojiPacksPack: ATProtocolCodable, ATProtocolValue {
    public static let typeIdentifier = "blue.moji.packs.pack"
    public let name: String
    public let description: String?
    public let descriptionFacets: [BlueMojiRichtextFacet]?
    public let icon: Blob?
    public let adultOnly: Bool?
    public let createdAt: ATProtocolDate
    public let labels: BlueMojiPacksPackLabelsUnion?

    public init(name: String, description: String?, descriptionFacets: [BlueMojiRichtextFacet]?, icon: Blob?, adultOnly: Bool?, createdAt: ATProtocolDate, labels: BlueMojiPacksPackLabelsUnion?) {
        self.name = name
        self.description = description
        self.descriptionFacets = descriptionFacets
        self.icon = icon
        self.adultOnly = adultOnly
        self.createdAt = createdAt
        self.labels = labels
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        do {
            description = try container.decodeIfPresent(String.self, forKey: .description)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'description' — degrading to nil: \(error)")
            description = nil
        }
        do {
            descriptionFacets = try container.decodeIfPresent([BlueMojiRichtextFacet].self, forKey: .descriptionFacets)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'descriptionFacets' — degrading to nil: \(error)")
            descriptionFacets = nil
        }
        do {
            icon = try container.decodeIfPresent(Blob.self, forKey: .icon)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'icon' — degrading to nil: \(error)")
            icon = nil
        }
        do {
            adultOnly = try container.decodeIfPresent(Bool.self, forKey: .adultOnly)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'adultOnly' — degrading to nil: \(error)")
            adultOnly = nil
        }
        createdAt = try container.decode(ATProtocolDate.self, forKey: .createdAt)
        do {
            labels = try container.decodeIfPresent(BlueMojiPacksPackLabelsUnion.self, forKey: .labels)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'labels' — degrading to nil: \(error)")
            labels = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptionFacets, forKey: .descriptionFacets)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(adultOnly, forKey: .adultOnly)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }

    public func isEqual(to other: any ATProtocolValue) -> Bool {
        guard let other = other as? Self else { return false }
        if name != other.name {
            return false
        }
        if description != other.description {
            return false
        }
        if descriptionFacets != other.descriptionFacets {
            return false
        }
        if icon != other.icon {
            return false
        }
        if adultOnly != other.adultOnly {
            return false
        }
        if createdAt != other.createdAt {
            return false
        }
        if labels != other.labels {
            return false
        }
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        if let value = description {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = descriptionFacets {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = icon {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = adultOnly {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        hasher.combine(createdAt)
        if let value = labels {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
    }

    public func toCBORValue() throws -> Any {
        var map = OrderedCBORMap()
        map = map.adding(key: "$type", value: Self.typeIdentifier)
        let nameValue = try name.toCBORValue()
        map = map.adding(key: "name", value: nameValue)
        if let value = description {
            let descriptionValue = try value.toCBORValue()
            map = map.adding(key: "description", value: descriptionValue)
        }
        if let value = descriptionFacets {
            let descriptionFacetsValue = try value.toCBORValue()
            map = map.adding(key: "descriptionFacets", value: descriptionFacetsValue)
        }
        if let value = icon {
            let iconValue = try value.toCBORValue()
            map = map.adding(key: "icon", value: iconValue)
        }
        if let value = adultOnly {
            let adultOnlyValue = try value.toCBORValue()
            map = map.adding(key: "adultOnly", value: adultOnlyValue)
        }
        let createdAtValue = try createdAt.toCBORValue()
        map = map.adding(key: "createdAt", value: createdAtValue)
        if let value = labels {
            let labelsValue = try value.toCBORValue()
            map = map.adding(key: "labels", value: labelsValue)
        }
        return map
    }

    private enum CodingKeys: String, CodingKey {
        case typeIdentifier = "$type"
        case name
        case description
        case descriptionFacets
        case icon
        case adultOnly
        case createdAt
        case labels
    }

    public enum BlueMojiPacksPackLabelsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case comAtprotoLabelDefsSelfLabels(ComAtprotoLabelDefs.SelfLabels)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: ComAtprotoLabelDefs.SelfLabels) {
            self = .comAtprotoLabelDefsSelfLabels(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "com.atproto.label.defs#selfLabels":
                let value = try ComAtprotoLabelDefs.SelfLabels(from: decoder)
                self = .comAtprotoLabelDefsSelfLabels(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                try container.encode("com.atproto.label.defs#selfLabels", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                hasher.combine("com.atproto.label.defs#selfLabels")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: BlueMojiPacksPackLabelsUnion, rhs: BlueMojiPacksPackLabelsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.comAtprotoLabelDefsSelfLabels(lhsValue),
                      .comAtprotoLabelDefsSelfLabels(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? BlueMojiPacksPackLabelsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                map = map.adding(key: "$type", value: "com.atproto.label.defs#selfLabels")

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
