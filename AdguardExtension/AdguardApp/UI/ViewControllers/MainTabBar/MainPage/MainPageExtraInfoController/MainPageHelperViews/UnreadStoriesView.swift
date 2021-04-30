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

final class UnreadStoriesView: MainPageCompactView {
    
    // MARK: - Public properties
    
    var unreadStoriesCount: Int = 0 {
        didSet {
            processTitleLabel()
        }
    }
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        processTitleLabel()
        descriptionLabel.text = String.localizedString("unread_stories_desc")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        processTitleLabel()
        descriptionLabel.text = String.localizedString("unread_stories_desc")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        processTitleLabel()
        descriptionLabel.text = String.localizedString("unread_stories_desc")
    }
    
    // MARK: - Public methods
    
    override func updateTheme(_ themeService: ThemeServiceProtocol) {
        super.updateTheme(themeService)
        processTitleLabel()
    }
    
    // MARK: - Private methods
    
    private func processTitleLabel() {
        let format = String.localizedString("unread_stories")
        let numberColorHex = UIColor.AdGuardColor.errorRedColor.hex()
        let string = String.localizedStringWithFormat(format, unreadStoriesCount, numberColorHex)//String(format: format, unreadStoriesCount, numberColorHex)
        let fontSize = titleLabel.font.pointSize
        let fontColor = titleLabel.textColor ?? .clear
        titleLabel.setAttributedTitle(string, fontSize: fontSize, color: fontColor, attachmentImage: nil, textAlignment: .center)
    }
}