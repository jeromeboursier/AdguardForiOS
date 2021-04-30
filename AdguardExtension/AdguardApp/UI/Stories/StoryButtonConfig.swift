/**
    This file is part of Adguard for iOS (https://github.com/AdguardTeam/AdguardForiOS).
    Copyright © Adguard Software Limited. All rights reserved.

    Adguard for iOS is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Adguard for iOS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Adguard for iOS.  If not, see <http://www.gnu.org/licenses/>.
*/

import Foundation

enum StoryActionType: String, CaseIterable, Equatable {
    case readChangeLog = "READ_CHANGELOG"
    case activateLicense = "ACTIVATE_LICENSE"
    case downloadAdguardVpn = "DOWNLOAD_ADGUARD_VPN"
    case moreOnDns = "MORE_ON_DNS"
    case moreOnSafari = "MORE_ON_SAFARI"
    case enableAdguardDns = "ENABLE_ADGUARD_DNS"
    case enableGoogleDns = "ENABLE_GOOGLE_DNS"
    case enableCloudflareDns = "ENABLE_CLOUDFLARE_DNS"
    case addCustomDns = "ADD_CUSTOM_DNS"
}

enum StoryButtonStyle: String, Decodable, CaseIterable, Equatable {
    case standard = "STANDARD"
    case opaque = "OPAQUE"
}

struct StoryButtonConfig: Decodable, Equatable {
    let title: String
    let actionType: StoryActionType
    let buttonStyle: StoryButtonStyle
    
    private enum CodingKeys: String, CodingKey {
        case title = "action_title"
        case actionType = "action"
        case buttonStyle = "button_style"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let buttonTitleKey = try container.decode(String.self, forKey: .title)
        let buttonActionKey = try container.decode(String.self, forKey: .actionType)
        let buttonStyleKey = try container.decode(String.self, forKey: .buttonStyle)
        
        guard let actionType = StoryActionType(rawValue: buttonActionKey) else {
            throw DecodingError.dataCorruptedError(forKey: .actionType, in: container, debugDescription: "Unknown action type")
        }
        
        guard let buttonStyle = StoryButtonStyle(rawValue: buttonStyleKey) else {
            throw DecodingError.dataCorruptedError(forKey: .buttonStyle, in: container, debugDescription: "Unknown button style type")
        }
        
        self.title = String.localizedString(buttonTitleKey)
        self.actionType = actionType
        self.buttonStyle = buttonStyle
    }
}