//
//  ReminderE.swift
//  GRUPO_FLG_3_M1
//
//  Created by Fábio Oliveira on 20/11/2023.
//

import Foundation

struct ReminderE {
    var id:Int32
    var firstName: String
    var lastName: String
    var fullName: String
    var title: String
    var family: String
    var image: String
    var imageUrl: String
}

#if DEBUG
extension Reminder {
    static var sampleDataE = [
        ReminderE(
                id: 0,
                firstName: "Daenerys",
                lastName: "Targaryen",
                fullName: "Daenerys Targaryen",
                title: "Mother of Dragons",
                family: "House Targaryen",
                image: "daenerys.jpg",
                imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg"
                ),
        ReminderE(
                id: 1,
                firstName: "Samwell",
                lastName: "Tarly",
                fullName: "Samwell Tarly",
                title: "Maester",
                family: "House Tarly",
                image: "sam.jpg",
                imageUrl: "https://thronesapi.com/assets/images/sam.jpg"
                ),
        ReminderE(
                id: 2,
                firstName: "Jon",
                lastName: "Snow",
                fullName: "Jon Snow",
                title: "King of the North",
                family: "House Stark",
                image: "jon-snow.jpg",
                imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"
                ),
        ReminderE(
                id: 3,
                firstName: "Arya",
                lastName: "Stark",
                fullName: "Arya Stark",
                title: "No One",
                family: "House Stark",
                image: "arya-stark.jpg",
                imageUrl: "https://thronesapi.com/assets/images/arya-stark.jpg"
                ),
        ReminderE(
                id: 4,
                firstName: "Sansa",
                lastName: "Stark",
                fullName: "Sansa Stark",
                title: "Lady of Winterfell",
                family: "House Stark",
                image: "sansa-stark.jpeg",
                imageUrl: "https://thronesapi.com/assets/images/sansa-stark.jpeg"
                )

    ]
}
#endif
