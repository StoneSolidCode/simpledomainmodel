//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
//    1 USD = .5 GBP / 2 USD = 1 GBP
//    1 USD = 1.5 EUR / 2 USD = 3 EUR
//    1 USD = 1.25 CAN / 4 USD = 5 CAN
    if (currency == to) {
        return Money(amount: amount, currency: currency)
    } else if to == "USD" {
        if currency == "GBP" {
            return Money(amount: amount * 2, currency: "USD")
        } else if currency == "EUR" {
            return Money(amount: amount * 2 / 3, currency: "USD")
        } else if currency == "CAN" {
            return Money(amount: amount * 4 / 5, currency: "USD")
        }
    } else if to == "GBP" {
        if currency == "USD" {
            return Money(amount: amount / 2, currency: "GBP")
        } else if currency == "EUR" {
            return Money(amount: amount / 3, currency: "GBP")
        } else if currency == "CAN" {
            return Money(amount: amount * 2 / 5, currency: "GBP")
        }
    } else if to == "CAN" {
        if currency == "USD" {
            return Money(amount: amount * 5 / 4, currency: "CAN")
        } else if currency == "EUR" {
            return Money(amount: amount * 1 / 3, currency: "CAN")
        } else if currency == "GBP" {
            return Money(amount: amount * 5 / 2, currency: "CAN")
        }
    } else if to == "EUR" {
        if currency == "GBP" {
            return Money(amount: amount * 3, currency: "EUR")
        } else if currency == "USD" {
            return Money(amount: amount * 3 / 2, currency: "EUR")
        } else if currency == "CAN" {
            return Money(amount: amount * 6 / 5, currency: "EUR")
        }
    } else {
        return Money(amount: 0, currency: "Error")
    }
    return Money(amount: 0, currency: "Error")
  }
  
  public func add(_ to: Money) -> Money {
    let converted = self.convert(to.currency)
    return Money(amount: converted.amount + to.amount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    let converted = self.convert(from.currency)
    return Money(amount: converted.amount - self.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job

open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
//
//    func get() -> String{
//        switch self {
//        case .Hourly(let num):
//            return String(num)
//        case .Salary(let num):
//            return String(num)
//    }
  }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }

  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let num): return Int(num) * hours
    case .Salary(let num): return Int(num)
    default: return 0
    }
  }

  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let num): self.type = JobType.Hourly((Double(num) + amt))
    case .Salary(let num): self.type = JobType.Salary((Int(num) + Int(amt)))
    default: let i = 0
    }
    
  }
}

////////////////////////////////////
// Person
////
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return nil }
    set(value) {
        _job = value
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
        _spouse = value
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    let str : String = "[Person: firstName:" + self.firstName
    let str2 = " lastName:" + self.lastName
    let str3 = " age:" + String(self.age) + " job:" + String("nil") + " spouse:"
    let str4 = String(spouse?.firstName ?? "nil") + "]"
    return str + str2 + str3 + str4
  }
}

//////////////////////////////////////
//// Family
////
//open class Family {
//  fileprivate var members : [Person] = []
//
//  public init(spouse1: Person, spouse2: Person) {
//  }
//
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}





