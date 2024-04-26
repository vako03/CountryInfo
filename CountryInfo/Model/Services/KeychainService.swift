//
//  KeychainService.swift
//  CountryInfo
//
//  Created by vako on 26.04.24.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private let service = "com.example.app"
    
    private init() {}
    
    func saveUserCredentials(_ credentials: UserCredentials) {
        if let username = credentials.username, let password = credentials.password {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: username,
                kSecValueData as String: password.data(using: .utf8)!
            ]
            
            SecItemDelete(query as CFDictionary)
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    func loadUserCredentials() -> UserCredentials? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else { return nil }
        guard let existingItem = item as? [String: Any],
              let username = existingItem[kSecAttrAccount as String] as? String,
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8) else { return nil }
        
        return UserCredentials(username: username, password: password)
    }
}
