// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Home {
    /// Multiplayer
    internal static let multiplayer = L10n.tr("Localizable", "Home.Multiplayer", fallback: "Multiplayer")
    /// Localizable.strings
    ///   RPS Multiplayer
    /// 
    ///   Created by Youssef Bhl on 02/01/2023.
    internal static let singlePlayer = L10n.tr("Localizable", "Home.SinglePlayer", fallback: "Single Player")
  }
  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "Settings.title", fallback: "Settings")
  }
  internal enum PlayerInfo {
    internal enum SinglePlayer {
      /// Avatar
      internal static let avatar = L10n.tr("Localizable", "playerInfo.singlePlayer.avatar", fallback: "Avatar")
      /// Nickname
      internal static let nickname = L10n.tr("Localizable", "playerInfo.singlePlayer.nickname", fallback: "Nickname")
      /// Swimming potato..
      internal static let nicknameExample = L10n.tr("Localizable", "playerInfo.singlePlayer.nicknameExample", fallback: "Swimming potato..")
      /// Play
      internal static let play = L10n.tr("Localizable", "playerInfo.singlePlayer.play", fallback: "Play")
      /// Player info
      internal static let title = L10n.tr("Localizable", "playerInfo.singlePlayer.title", fallback: "Player info")
    }
  }
  internal enum Pregame {
    /// Get ready...
    internal static let getReady = L10n.tr("Localizable", "pregame.getReady", fallback: "Get ready...")
    /// VS
    internal static let vs = L10n.tr("Localizable", "pregame.vs", fallback: "VS")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
