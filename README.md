# babylon-wallet-ios

An iOS wallet for interacting with the [Radix DLT ledger][radixdlt].

Writtin in Swift using SwiftUI as UI framework and [TCA - The Composable Architecture][tca] as architecture.

# Development
Clone the repo and run bootstrap script:
```sh
./scripts/bootstrap
```

Setup [fastlane](#fastlane).

To open the project use:

```sh
open App/BabylonWallet.xcodeproj
```

# Architecture
The structure is the same as [Point-Free's game Isowords (source)][isowords] (the authors of TCA).

## SPM + App structure
A "gotcha" of this structure is that the project root contains the Package.swift and `Source` and `Tests` of the Swift Packages. The actual app is an ultra thin entrypoint, using `AppFeature` package, and is put in `App` folder. This is how the app references the local packages:

1. Select the project in the Navigator
2. Target "Wallet (iOS)"
3. Build Phases
4. Link Binary With Libraries
5. "+"button in bottom of section
6. "Add Other" button in bottom left
7. "Add Package Dependency"
8. And selecting the whole project ROOT (yes the root, and we will use a trick below to avoid "recursion")
9. This would not work if we did not use Point-Free's trick to create a "Dummy" Package.swift inside `./App/` folder, which we have done.
10. Again click "+"button in bottom of "Link Binary With Libraries" section and you should see "AppFeature" (and all other packages) there, add "AppFeature"!
11. This setup only needs to happen once, for all targets, but any other targets need to perform the last step, of adding the actual package as dependency, e.g. for macOS (for development purpuses).

## What do I import where?

A blanket rule for what to import in which situation is:

- If you're working on a **Feature**:
  - Import `FeaturePrelude` (automatically linked to **Feature** targets).
  - Link and import any client or core modules this new feature depends on (e.g. `EngineToolkitClient`, `Cryptography`).
- If you're working on a **Client**:
  - `import ClientPrelude` (automatically linked to **Client** targets).
  - Link and import any core modules this new client depends on (e.g. `EngineToolkit`, `Cryptography`).
- If you're writing tests:
  - Import the module you're testing (automatically linked to its corresponding test target).
  - if you are testing a **Client**: `import ClientTestingPrelude` (automatically linked to **Client** test targets).
  - if you are testing a **Feature**: `import FeatureTestingPrelude` (automatically linked to **Feature** test targets).
  - if you are testing **Core** or standalone module: `import TestingPrelude` (automatically linked to all test targets).

# Code style

## No `protocol`s
We do not use Protocols at all (maybe with few rare exceptions), instead we use `struct` with closures. See section "Encapsulate ALL Dependencies" below for more info.

## No `class`es
We do not use classes at all (maybe with a few ultrarare exceptions), instead we use `struct` with closures. See section "Encapsulate ALL Dependencies" below for more info.

(Except for `final class MyTests: TestCase` (inheriting from `open class TestCase: XCTestCase` with some config) ofc...)

## SwiftFormat
We use SwiftFormat to format code, rules are defined in `.swiftformat`.

## Packages
We use the super modular design that Point-Free uses in [Isowords](https://github.com/pointfreeco/isowords/blob/main/Package.swift) - with almost 100 different packages.

## Encapsulate ALL dependencies
We encapsulate ALL real world APIs, dependencies and inputs such as UserDefaults, Keychain, NotificationCenter, API Clients etc, we follow the pattern of [Point-Free's Isoword here UserDefaults][https://github.com/pointfreeco/isowords/tree/main/Sources/UserDefaultsClient].

```swift
public struct UserDefaultsClient {
  public var boolForKey: (String) -> Bool
  public var setBool: (Bool, String) -> Effect<Never, Never>


  public var hasShownFirstLaunchOnboarding: Bool {
    self.boolForKey(hasShownFirstLaunchOnboardingKey)
  }

  public func setHasShownFirstLaunchOnboarding(_ bool: Bool) -> Effect<Never, Never> {
    self.setBool(bool, hasShownFirstLaunchOnboardingKey)
  }
}

let hasShownFirstLaunchOnboardingKey = "hasShownFirstLaunchOnboardingKey"
let installationTimeKey = "installationTimeKey"
let multiplayerOpensCount = "multiplayerOpensCount"
```

Which does NOT use `protocol`s! We use structs with closures for each function as input, which makes mocking super easy.
Here is the Live version:

```swift
extension UserDefaultsClient {
  public static func live(
    userDefaults: UserDefaults = UserDefaults(suiteName: "group.isowords")!
  ) -> Self {
    Self(
      boolForKey: userDefaults.bool(forKey:),
      dataForKey: userDefaults.data(forKey:),
      doubleForKey: userDefaults.double(forKey:),
      integerForKey: userDefaults.integer(forKey:),
      remove: { key in
        .run { _ in
          userDefaults.removeObject(forKey: key)
        }
      },
      setBool: { value, key in
        .run { _ in
          userDefaults.set(value, forKey: key)
        }
      },
      setData: { data, key in
        .run { _ in
          userDefaults.set(data, forKey: key)
        }
      },
      setDouble: { value, key in
        .run { _ in
          userDefaults.set(value, forKey: key)
        }
      },
      setInteger: { value, key in
        .run { _ in
          userDefaults.set(value, forKey: key)
        }
      }
    )
  }
}
```

## Preview Packages
Thanks to TCA we can create Feature Previews, which are super small apps using a specific Feature's package as entry point, this is extremely useful, because suddenly we can start a small Preview App which takes us directly to Settings, or Directly directly to onboarding. See [Isowords Preview apps here](https://github.com/pointfreeco/isowords/tree/main/App/Previews).

instead of opening the root, otherwise you will not get access to the App and the Packages.

## Fastlane

### Bundler setup
We use [Bundler](https://bundler.io/) to install and update Fastlane. Follow below steps to have Bundler installed and execute fastlane lanes:

- Install ruby v3.1.2; it is strongly recommend to use a tool like [rbenv](https://github.com/rbenv/rbenv) to manage the rubby version.
- Install bundler:

```sh
gem install bundler -v 2.3.25
```
- Install this project gems:

```sh
bundle install
```

### Development config setup

- Download [fastlane secrets](https://start.1password.com/open/i?a=JWO4INKPOFHCDMZ2CYQMY4DRY4&v=srjnzoh2conosxfpkekxlakwzq&i=c75l3mugtfopfd5ebrcn22hssu&h=rdxworks.1password.com).
- Put the downloaded file in [fastlane](fastlane) folder. Be sure to remove the leading underscore from the file name.
- Run the below command to bring the necessary certificates for development:

```sh
bundle exec fastlane ios install_development_certificates
bundle exec fastlane mac install_development_certificates
```
- If your device is unregistered, register it with the below command, it will prompt you to enter the device name and device UDID.

#### For iOS

```sh
bundle exec fastlane ios register_new_iphone_device
```

#### For macOS

```sh
bundle exec fastlane mac register_new_mac_device
```

After the above setup, you are good to go with building and running the app on iPhone or Mac device. Open the `App/BabylonWallet.xcodeproj` and select the `Radix Wallet Dev (iOS)` scheme and hit run (`⌘R`).

# Testing
1. Unit tests for each package, split into multiple files for each seperate system under test (sut).
2. UI testing using [Point-Free's Snapshot testing Package][snapshotTesting] (Only when UI becomes stable)
3. Integration tests can be enabled later on using locally running Gateway service with Docker. Which has been [done before in ancient deprecated Swift SDK](https://github.com/radixdlt/radixdlt-swift-archive/tree/develop/Tests/TestCases/IntegrationTests)


# Releasing

## Versioning
We use SemVer, semantically versioning on format `MAJOR.MINOR.PATCH` (with a "build #\(BUILD)" suffix in UI).
Application version is specified in [Common.xcconfig](App/Config/Common.xcconfig), and is shared between all targets with their respective `.xcconfig` file.

[radixdlt]: https://radixdlt.com
[tca]: https://github.com/pointfreeco/swift-composable-architecture
[isowords]: https://github.com/pointfreeco/isowords
[snapshotTesting]: https://github.com/pointfreeco/swift-snapshot-testing


# License

The code for the iOS Radix Wallet is released under the [Apache 2.0 license](./LICENSE). Binaries are licensed under the [Radix Wallet Software EULA](https://www.radixdlt.com/terms/walletEULA).
