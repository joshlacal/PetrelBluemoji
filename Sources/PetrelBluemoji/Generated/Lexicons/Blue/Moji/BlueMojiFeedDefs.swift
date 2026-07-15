import Foundation
import Petrel

// lexicon: 1, id: blue.moji.feed.defs

public enum BlueMojiFeedDefs {
    public static let typeIdentifier = "blue.moji.feed.defs"

    public struct ReactionView: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.feed.defs#reactionView"
        public let uri: ATProtocolURI
        public let actor: AppBskyActorDefs.ProfileViewBasic
        public let emoji: BlueMojiFeedReaction.EmojiRef
        public let createdAt: ATProtocolDate

        public init(
            uri: ATProtocolURI, actor: AppBskyActorDefs.ProfileViewBasic, emoji: BlueMojiFeedReaction.EmojiRef, createdAt: ATProtocolDate
        ) {
            self.uri = uri
            self.actor = actor
            self.emoji = emoji
            self.createdAt = createdAt
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
                actor = try container.decode(AppBskyActorDefs.ProfileViewBasic.self, forKey: .actor)
            } catch {
                LogManager.logError("Decoding error for required property 'actor': \(error)")
                throw error
            }
            do {
                emoji = try container.decode(BlueMojiFeedReaction.EmojiRef.self, forKey: .emoji)
            } catch {
                LogManager.logError("Decoding error for required property 'emoji': \(error)")
                throw error
            }
            do {
                createdAt = try container.decode(ATProtocolDate.self, forKey: .createdAt)
            } catch {
                LogManager.logError("Decoding error for required property 'createdAt': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(uri, forKey: .uri)
            try container.encode(actor, forKey: .actor)
            try container.encode(emoji, forKey: .emoji)
            try container.encode(createdAt, forKey: .createdAt)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(uri)
            hasher.combine(actor)
            hasher.combine(emoji)
            hasher.combine(createdAt)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if uri != other.uri {
                return false
            }
            if actor != other.actor {
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

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            let uriValue = try uri.toCBORValue()
            map = map.adding(key: "uri", value: uriValue)
            let actorValue = try actor.toCBORValue()
            map = map.adding(key: "actor", value: actorValue)
            let emojiValue = try emoji.toCBORValue()
            map = map.adding(key: "emoji", value: emojiValue)
            let createdAtValue = try createdAt.toCBORValue()
            map = map.adding(key: "createdAt", value: createdAtValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case uri
            case actor
            case emoji
            case createdAt
        }
    }

    public struct ReactionGroup: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.feed.defs#reactionGroup"
        public let emoji: BlueMojiFeedReaction.EmojiRef
        public let count: Int
        public let viewer: ATProtocolURI?

        public init(
            emoji: BlueMojiFeedReaction.EmojiRef, count: Int, viewer: ATProtocolURI?
        ) {
            self.emoji = emoji
            self.count = count
            self.viewer = viewer
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                emoji = try container.decode(BlueMojiFeedReaction.EmojiRef.self, forKey: .emoji)
            } catch {
                LogManager.logError("Decoding error for required property 'emoji': \(error)")
                throw error
            }
            do {
                count = try container.decode(Int.self, forKey: .count)
            } catch {
                LogManager.logError("Decoding error for required property 'count': \(error)")
                throw error
            }
            do {
                viewer = try container.decodeIfPresent(ATProtocolURI.self, forKey: .viewer)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'viewer' — degrading to nil: \(error)")
                viewer = nil
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(emoji, forKey: .emoji)
            try container.encode(count, forKey: .count)
            try container.encodeIfPresent(viewer, forKey: .viewer)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(emoji)
            hasher.combine(count)
            if let value = viewer {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if emoji != other.emoji {
                return false
            }
            if count != other.count {
                return false
            }
            if viewer != other.viewer {
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
            let emojiValue = try emoji.toCBORValue()
            map = map.adding(key: "emoji", value: emojiValue)
            let countValue = try count.toCBORValue()
            map = map.adding(key: "count", value: countValue)
            if let value = viewer {
                let viewerValue = try value.toCBORValue()
                map = map.adding(key: "viewer", value: viewerValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case emoji
            case count
            case viewer
        }
    }
}
