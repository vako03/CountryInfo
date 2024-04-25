//
//  AppColors.swift
//  CountryInfo
//
//  Created by vako on 24.04.24.
//

    import UIKit

    struct AppColors {
        
        static let customBackgroundColor = UIColor { traitCollection in
            
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(named: "screen_background")!
            default:
                return UIColor(named: "screen_background")!
            }

        }
        
        static let customBackgroundColor1 = UIColor { traitCollection in
            
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(named: "screen_background1")!
            default:
                return UIColor(named: "screen_background1")!
            }

        }
        static let customCellBackgroundColor = UIColor { traitCollection in
            
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(named: "cell_color")!
            default:
                return UIColor(named: "cell_color")!
        
            }
        }
        
        static let customTextColor = UIColor { traitCollection in
            
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(named: "text_color")!
            default:
                return UIColor(named: "text_color")!
            }
            
        }
        
    }
