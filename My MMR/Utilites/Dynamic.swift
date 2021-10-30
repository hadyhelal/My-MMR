//
//  Dynamic.swift
//  My MMR
//
//  Created by Hady Helal on 29/10/2021.
//

import Foundation

final class Dynamic<T> {
  //1
  typealias Listener = (T) -> Void
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
    
}
