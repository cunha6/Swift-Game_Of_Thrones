/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case fullName
        case title
        case family
        case imageUrl
        

        var imageName: String? {
            switch self {
            case .title: return "square.and.pencil"
            case .family: return "clock"
            case .imageUrl: return "clock"
            default: return nil
            }
        }

        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }

        var textStyle: UIFont.TextStyle {
            switch self {
            case .fullName: return .headline
            default: return .subheadline
            }
        }
    }
}

