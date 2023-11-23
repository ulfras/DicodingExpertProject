//
//  Date + Extension.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

import Foundation

extension String {
    func formattedDate(inputFormat: String = "yyyy-MM-dd", outputFormat: String = "dd MMM yyyy") -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = inputFormat

        if let date = dateFormatterInput.date(from: self) {
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = outputFormat

            return dateFormatterOutput.string(from: date)
        } else {
            return self
        }
    }
}
