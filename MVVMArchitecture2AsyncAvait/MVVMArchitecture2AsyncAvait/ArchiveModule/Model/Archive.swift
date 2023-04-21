//
//  Archive.swift
//  MVVMArchitecture2AsyncAvait
//
//  Created by Александр Рахимов on 18.04.2023.
//

import Foundation

class Archive {
    let archiveGames: [String]?
    
    init(archiveApi: ArchiveAPI) {
        self.archiveGames = archiveApi.archives
    }
}
