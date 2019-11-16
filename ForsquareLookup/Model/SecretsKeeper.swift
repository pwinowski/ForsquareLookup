//
//  SecretsKeeper.swift
//  ForsquareLookup
//
//  Created by Patryk Winowski on 14/11/2019.
//  Copyright © 2019 Patryk Winowski. All rights reserved.
//

import Foundation

class SecretsKeeper {
    private var userId: String?
    
    public func getUserId() throws -> String {
        if let id = self.userId {
            return id
        }
        guard let storedId = UserDefaults.standard.string(forKey: "UserId")
            else {
                throw AuthenticationError.noUserRefistered
        }
        self.userId = storedId
        return storedId
    }
    
    public func storeSecret(_ secret: String, forUserId user: String) throws {
        self.userId = user
        UserDefaults.standard.set(user, forKey: "UserId")
        let secretData = secret.data(using: String.Encoding.utf8)!
        let keychainQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                            kSecAttrAccount as String: user,
                                            kSecValueData as String: secretData]
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        guard status == errSecSuccess
            else {
                throw AuthenticationError.keychainSaveError
        }
        
    }
    
    public func getSecret() throws -> String {
        let account = try getUserId()
        let searchQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                          kSecAttrAccount as String: account,
                                          kSecMatchLimit as String: kSecMatchLimitOne,
                                          kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(searchQuery as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw AuthenticationError.keychaninNoSecretFound }
        guard status == errSecSuccess else { throw AuthenticationError.keychainOtherError }
        
        guard let existingItem = item as? [String : Any],
              let secretData = existingItem[kSecValueData as String] as? Data,
              let secret = String(data: secretData, encoding: String.Encoding.utf8)
        else {
            throw AuthenticationError.corruptedSecretData
        }
        return secret
    }
}

public enum AuthenticationError: Error {
    case noUserRefistered
    case keychainSaveError
    case keychaninNoSecretFound
    case keychainOtherError
    case corruptedSecretData
}
