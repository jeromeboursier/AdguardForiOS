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

enum StoryScope: String, Decodable, CaseIterable, Equatable {
    case forPro = "FOR_PRO"
    case forFree = "FOR_FREE"
    case forVpnAppPromotion = "FOR_VPN_APP_PROMOTION"
    case forAll = "FOR_ALL"
}

/* StoryToken is a model for one story */
struct StoryToken: Decodable, Equatable {
    let image: UIImage? // UIImage for light theme
    let darkImage: UIImage? // UIImage for dark theme
    
    //decodable fields
    let title: String?
    let description: String?
    let scope: StoryScope?
    let buttonConfig: StoryButtonConfig?
        
    private enum LocalizedStringKeysWithFormat: String, CaseIterable {
        case whatsNewDescription = "story_whats_new_1_description"
        
        var localizedString: String {
            switch self {
            case .whatsNewDescription:
                let version = ADProductInfo().version() ?? ""
                return String(format: String.localizedString(self.rawValue), version)
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case image
        case title
        case description
        case scope
        case buttonConfig = "button_config"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let imageName = try container.decode(String.self, forKey: .image)
        let titleKey = try container.decode(String.self, forKey: .title)
        let descKey = try container.decode(String.self, forKey: .description)
        
        self.image = UIImage(named: imageName)
        self.darkImage = UIImage(named: imageName + "_dark")
        
        if let titleFormat = LocalizedStringKeysWithFormat(rawValue: titleKey) {
            self.title = titleFormat.localizedString
        } else {
            self.title = String.localizedString(titleKey)
        }
        
        if let descFormat = LocalizedStringKeysWithFormat(rawValue: descKey) {
            self.description = descFormat.localizedString
        } else {
            self.description = String.localizedString(descKey)
        }
        
        self.scope = try? container.decode(StoryScope.self, forKey: .scope)
        self.buttonConfig = try? container.decode(StoryButtonConfig.self, forKey: .buttonConfig)
    }
}