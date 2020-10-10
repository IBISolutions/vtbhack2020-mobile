//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
public struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  public static func validate() throws {
    try intern.validate()
  }

  /// This `R.image` struct is generated, and contains static references to 0 images.
  public struct image {
    /// This `R.image.main` struct is generated, and contains static references to 3 images.
    public struct main {
      /// Image `Background`.
      public static let background = Rswift.ImageResource(bundle: R.hostingBundle, name: "Main/Background")
      /// Image `Car`.
      public static let car = Rswift.ImageResource(bundle: R.hostingBundle, name: "Main/Car")
      /// Image `Shake`.
      public static let shake = Rswift.ImageResource(bundle: R.hostingBundle, name: "Main/Shake")

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Background", bundle: ..., traitCollection: ...)`
      public static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.main.background, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Car", bundle: ..., traitCollection: ...)`
      public static func car(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.main.car, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Shake", bundle: ..., traitCollection: ...)`
      public static func shake(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.main.shake, compatibleWith: traitCollection)
      }
      #endif

      fileprivate init() {}
    }

    /// This `R.image.uI` struct is generated, and contains static references to 1 images.
    public struct uI {
      /// Image `Thumb`.
      public static let thumb = Rswift.ImageResource(bundle: R.hostingBundle, name: "UI/Thumb")

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Thumb", bundle: ..., traitCollection: ...)`
      public static func thumb(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.uI.thumb, compatibleWith: traitCollection)
      }
      #endif

      /// This `R.image.uI.checkbox` struct is generated, and contains static references to 2 images.
      public struct checkbox {
        /// Image `Deselected`.
        public static let deselected = Rswift.ImageResource(bundle: R.hostingBundle, name: "UI/Checkbox/Deselected")
        /// Image `Selected`.
        public static let selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "UI/Checkbox/Selected")

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "Deselected", bundle: ..., traitCollection: ...)`
        public static func deselected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.uI.checkbox.deselected, compatibleWith: traitCollection)
        }
        #endif

        #if os(iOS) || os(tvOS)
        /// `UIImage(named: "Selected", bundle: ..., traitCollection: ...)`
        public static func selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
          return UIKit.UIImage(resource: R.image.uI.checkbox.selected, compatibleWith: traitCollection)
        }
        #endif

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      // There are no resources to validate
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

public struct _R {
  fileprivate init() {}
}
