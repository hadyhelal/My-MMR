//
//  App+Injection.swift
//  My MMR
//
//  Created by Hady Helal on 23/12/2021.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        register { OperationQueue() }
        register { DropDownList() }.implements(DropDownProtocol.self)
        register { AlamoFireManager() }.implements(AlamoFireManagerProtocol.self)
        register { AlamoFireRequests() }.implements(AlamoFireRequestsProtocol.self)
        register { UserDefault() }.implements(UserDefaultProtocol.self)
    }
    
    
}
