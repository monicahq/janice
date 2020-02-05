//
//  KeychainWrapper.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-18.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation

class KeychainWrapper {

    // MARK: - Public Properties

    /// Singleton instanciation.
    static let shared = KeychainWrapper()

    // MARK: - Private Properties

    private let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "KeychainWrapper"
    }()
    private let secClass: String = kSecClass as String
    private let secAttrAccessGroup: String = kSecAttrAccessGroup as String
    private let secAttrGeneric: String = kSecAttrGeneric as String
    private let secValueData: String = kSecValueData as String
    private let secAttrAccessible: String = kSecAttrAccessible as String
    private let secAttrAccount: String = kSecAttrAccount as String
    private let secAttrService: String = kSecAttrService as String
    private let secMatchLimit: String = kSecMatchLimit as String
    private let secReturnData: String = kSecReturnData as String

    // MARK: - Public Functions

    func getstring(key: String) -> String? {
        guard let keychainData = data(forKey: key) else {
            return nil
        }

        return String(data: keychainData, encoding: String.Encoding.utf8) as String?
    }

    func getData(forKey key: String) -> Data? {
        guard let keychainData = data(forKey: key) else {
            return nil
        }

        return keychainData
    }

    func set(_ value: String, forKey key: String) -> Bool {
        if let data = value.data(using: .utf8) {
            return set(data, forKey: key)
        } else {
            return false
        }
    }

    func set(_ value: Data, forKey key: String) -> Bool {
        var keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key)

        keychainQueryDictionary[secValueData] = value

        let status: OSStatus = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)

        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(value, forKey: key)
        } else {
            return false
        }
    }

    func remove(key: String) -> Bool {
        return removeObject(forKey: key)

    }

    // MARK: - Private Functions

    private func removeObject(forKey key: String) -> Bool {
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key)

        let status: OSStatus = SecItemDelete(keychainQueryDictionary as CFDictionary)

        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }

    private func data(forKey key: String) -> Data? {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)

        keychainQueryDictionary[secMatchLimit] = kSecMatchLimitOne
        keychainQueryDictionary[secReturnData] = kCFBooleanTrue

        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)

        return status == noErr ? result as? Data : nil
    }

    private func setupKeychainQueryDictionary(forKey key: String) -> [String: Any] {
        var keychainQueryDictionary: [String: Any] = [secClass: kSecClassGenericPassword]

        keychainQueryDictionary[secAttrService] = defaultServiceName
        keychainQueryDictionary[secAttrAccessible] = kSecAttrAccessibleWhenUnlocked

        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)

        keychainQueryDictionary[secAttrGeneric] = encodedIdentifier

        keychainQueryDictionary[secAttrAccount] = encodedIdentifier

        return keychainQueryDictionary
    }

    private func update(_ value: Data, forKey key: String) -> Bool {
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key)
        let updateDictionary = [secValueData: value]

        let status: OSStatus = SecItemUpdate(keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary)

        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
}
