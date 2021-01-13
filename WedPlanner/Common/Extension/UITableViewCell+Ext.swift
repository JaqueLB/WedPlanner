//
//  UITableViewCell+Ext.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 13/01/21.
//

import UIKit

extension UITableViewCell {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
