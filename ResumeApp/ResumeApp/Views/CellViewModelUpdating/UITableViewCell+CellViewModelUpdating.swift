//
//  UITableViewCell+CellViewModelUpdating.swift
//  ResumeApp
//
//  Created by Łukasz Bazior on 24/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

import UIKit

extension UITableViewCell: CellViewModelUpdating {
        
    func update(viewModel: CellPresentableModel) {
        textLabel?.numberOfLines = 0
        textLabel?.text = viewModel.title
        
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .secondaryLabel
        detailTextLabel?.text = viewModel.subtitle
        
        imageView?.setImage(imageViewModel: viewModel.imageViewModel)
        imageView?.tintColor = .systemTeal

        selectionStyle = viewModel.selectable ? .default : .none
        
        accessoryType = viewModel.selectable ? .disclosureIndicator : .none
    }

}
