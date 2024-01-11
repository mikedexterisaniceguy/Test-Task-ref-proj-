import UIKit
import Foundation

// Basic program that calculates a statement of a customer's charges at a car rental store.
//
// A customer can have multiple "Rental"s and a "Rental" has one "Car"
// As an ASCII class diagram:
//          Customer 1 ----> * Rental
//          Rental   * ----> 1 Car
//
// The charges depend on how long the car is rented and the type of the car (economy, muscle or supercar)
//
// The program also calculates frequent renter points.
//
//
// Refactor this class how you would see fit.
//
// The actual code is not that important, as much as its structure. You can even use "magic" functions (e.g. foo.sort()) if you want

enum CarType {
    case economy
    case muscle
    case supercar
}

final class Car {
    var type: CarType
    private let title: String
    
    var getTitle: String {
        title
    }
    
    init(title: String, type: CarType) {
        self.title = title
        self.type = type
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class Rental {
    let car : Car
    private let daysRented: Int
    
    var getDaysRented: Int {
        daysRented
    }
    
    var getCar: Car {
        car
    }
    
    init(car: Car, daysRented: Int) {
        self.car = car
        self.daysRented = daysRented
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class Customer {
    private let name: String
    private var rentals: [Rental] = []
    
    var customerName: String {
        name
    }
    
    init(
        name: String,
        rentals: [Rental] = [Rental]()
    ) {
        self.name = name
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Customer {
    func addRental(arg: Rental) {
        rentals.append(arg)
    }
    
    func billingStatement() -> String {
        var totalAmount = 0
        var frequentRenterPoints = 0
        var result = "Rental Record for " + customerName + "\n"
        
        rentals.map { each in
            var thisAmount = 0
            
            //determine amounts for each line
            switch each.car.type {
            case .economy:
                thisAmount += 80
                if (each.getDaysRented > 2) {
                    thisAmount += (each.getDaysRented - 2) * 30
                }
            case .supercar:
                thisAmount += each.getDaysRented * 200
            case .muscle:
                thisAmount += 200
                if (each.getDaysRented > 3) {
                    thisAmount += (each.getDaysRented - 3) * 50
                }
            }
            
            // add frequent renter points
            frequentRenterPoints += 1
            
            // add bonus for a two day new release rental
            if each.car.type == .supercar && each.getDaysRented > 1 {
                frequentRenterPoints += 1
            }
            
            //show figures for this rental
            result += "\t\(each.getCar.getTitle) \t\(String(thisAmount))\n"
            totalAmount += thisAmount
        }
        //add footer lines
        result += "Final rental payment owed " + String(totalAmount) + "\n"
        result += "You received an additional " + String(frequentRenterPoints) + " frequent customer points"
        return result
    }
}



let rental1 = Rental(car: Car(title: "Mustang", type: .muscle), daysRented: 5)
let rental2 = Rental(car: Car(title: "Lambo", type: .supercar), daysRented: 20)
let customer = Customer(name: "Liviu")
customer.addRental(arg: rental1)
customer.addRental(arg: rental2)


print(customer.billingStatement())

