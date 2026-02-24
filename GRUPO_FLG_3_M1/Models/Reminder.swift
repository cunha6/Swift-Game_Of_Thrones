/*
 See LICENSE folder for this sample’s licensing information.
 */
import UIKit
import Foundation

struct Reminder {
    var id:Int32
    var firstName: String
    var lastName: String
    var fullName: String
    var title: String
    var family: String
    var image: UIImage
    var imageUrl: String
    var isComplete: Bool = false
}

#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(
                id: 0,
                firstName: "Daenerys",
                lastName: "Targaryen",
                fullName: "Daenostoerys Targaryen",
                title: "Mother of Dragons",
                family: "House Targaryen",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg"
                ),
        Reminder(
                id: 1,
                firstName: "Samwell",
                lastName: "Tarly",
                fullName: "Samwell Tarly",
                title: "Maester",
                family: "House Tarly",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/sam.jpg"
                ),
        Reminder(
                id: 2,
                firstName: "Jon",
                lastName: "Snow",
                fullName: "Jon Snow",
                title: "King of the North",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"
                ),
        Reminder(
                id: 3,
                firstName: "Arya",
                lastName: "Stark",
                fullName: "Arya Stark",
                title: "No One",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/arya-stark.jpg"
                ),
        Reminder(
                id: 4,
                firstName: "Sansa",
                lastName: "Stark",
                fullName: "Sansa Stark",
                title: "Lady of Winterfell",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/sansa-stark.jpeg"
                ),
        Reminder(
                id: 5,
                firstName: "Brandon",
                lastName: "Stark",
                fullName: "Brandon Stark",
                title: "Lord of Winterfell",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/bran-stark.jpg"
                ),
        Reminder(
                id: 6,
                firstName: "Ned",
                lastName: "Stark",
                fullName: "Ned Stark",
                title: "Lord of Winterfell",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/ned-stark.jpg"
                ),
        Reminder(
                id: 7,
                firstName: "Robert",
                lastName: "Baratheon",
                fullName: "Robert Baratheon",
                title: "Lord of the Seven Kingdoms",
                family: "House Baratheon",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/robert-baratheon.jpeg"
                ),
        Reminder(
                id: 8,
                firstName: "Jamie",
                lastName: "Lannister",
                fullName: "Jamie Lannister",
                title: "Lord Commander of the Kingsguard",
                family: "House Lannister",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/jaime-lannister.jpg"
                ),
        Reminder(
                id: 9,
                firstName: "Cersei",
                lastName: "Lannister",
                fullName: "Cersei Lannister",
                title: "Lady of Casterly Rock",
                family: "House Lannister",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/cersei.jpg"
                ),
        Reminder(
                id: 10,
                firstName: "Cateyln",
                lastName: "Stark",
                fullName: "Cateyln Stark",
                title: "Lady of Winterfell",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/catelyn-stark.jpg"
                ),
        Reminder(
                id: 11,
                firstName: "Robb",
                lastName: "Stark",
                fullName: "Robb Stark",
                title: "Lady of Winterfell",
                family: "House Stark",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/robb-stark.jpg"
                ),
        Reminder(
                id: 12,
                firstName: "Theon",
                lastName: "Greyjoy",
                fullName: "Theon Greyjoy",
                title: "Captain of Sea Bitch",
                family: "House Greyjoy",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/theon.jpg"
                ),
        Reminder(
                id: 13,
                firstName: "Joffrey",
                lastName: "Baratheon",
                fullName: "Joffrey Baratheon",
                title: "Lord of the Seven Kingdoms, Protector of the Realm",
                family: "House Lanister",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/joffrey.jpg"
                ),
        Reminder(
                id: 14,
                firstName: "Tyrion",
                lastName: "Lannister",
                fullName: "Tyrion Lannister",
                title: "Hand of the Queen",
                family: "House Lanister",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/tyrion-lannister.jpg"
                ),
        Reminder(
                id: 15,
                firstName: "Sandor",
                lastName: "Clegane",
                fullName: "The Hound",
                title: "The Hound",
                family: "House Clegane",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/the-hound.jpg"
                ),
        Reminder(
                id: 16,
                firstName: "Petyr",
                lastName: "Baelish",
                fullName: "Petyr Baelish",
                title: "Littlefinger",
                family: "House Baelish",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/littlefinger.jpg"
                ),
        Reminder(
                id: 17,
                firstName: "Davos",
                lastName: "Seaworth",
                fullName: "Davos Seaworth",
                title: "Hand of the King",
                family: "House Seaworth",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/davos-seaworth.png"
                ),
        Reminder(
                id: 18,
                firstName: "Stannis",
                lastName: "Baratheon",
                fullName: "Stannis Baratheon",
                title: "Lord of Dragonstone",
                family: "House Baratheon",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/stannis.jpg"
                ),
        Reminder(
                id: 19,
                firstName: "Varys",
                lastName: "Unknown",
                fullName: "Varys Unknown",
                title: "Master of Whisperers",
                family: "Unknown",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/varys.jpg"
                ),
        Reminder(
                id: 20,
                firstName: "Khal",
                lastName: "Drogo",
                fullName: "Khal Drogo",
                title: "Khal",
                family: "House Targaryen",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/khal-drogo.jpg"
                ),
        Reminder(
                id: 21,
                firstName: "Margaery",
                lastName: "Tyrell",
                fullName: "Margaery Tyrell",
                title: "Queen of the Seven Kingdoms",
                family: "House Tyrell",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/margaery-tyrell.jpg"
                ),
        Reminder(
                id: 22,
                firstName: "Ygritte",
                lastName: "None",
                fullName: "Ygritte",
                title: "Spearwife",
                family: "Free Folk",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/ygritte.jpg"
                ),
        Reminder(
                id: 23,
                firstName: "Brienne",
                lastName: "Tarth",
                fullName: "Brienne of Tarth",
                title: "Lady Brienne",
                family: "Tarth",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/brienne-tarth.jpeg"
                ),
        Reminder(
                id: 24,
                firstName: "Missandei",
                lastName: "None",
                fullName: "Missandei",
                title: "Queen's Personal Advisor",
                family: "Naathi",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/missandei.jpeg"
                ),
        Reminder(
                id: 25,
                firstName: "Gilly",
                lastName: "None",
                fullName: "Gilly",
                title: "The Rabbit Keeper",
                family: "None",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/gilly.jpg"
                ),
        Reminder(
                id: 26,
                firstName: "Viserys",
                lastName: "Targaryan",
                fullName: "Viserys Targaryan",
                title: "King Viserys III",
                family: "Targaryan",
                image: UIImage(named: "image.jpg")!,
                imageUrl: "https://thronesapi.com/assets/images/viserys-targaryan.jpg"
                ),
        Reminder(
                  id: 27,
                  firstName: "Rickon",
                  lastName: "Stark",
                  fullName: "Rickon Stark",
                  title: "Prince",
                  family: "Stark",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/rickon.jpg"
        ),

        Reminder(
                  id: 28,
                  firstName: "Roose",
                  lastName: "Bolton",
                  fullName: "Roose Bolton",
                  title: "Lord of Dreadfort",
                  family: "Bolton",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/roose-bolton.jpg"
        ),

        Reminder(
                  id: 29,
                  firstName: "Daario",
                  lastName: "Naharis",
                  fullName: "Daario",
                  title: "Commander of the Second Sons",
                  family: "Naharis",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/daario.jpg"
        ),

        Reminder(
                  id: 30,
                  firstName: "Shae",
                  lastName: "",
                  fullName: "Shae",
                  title: "Mistress",
                  family: "Lorathi",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/shae.jpg"
        ),

        Reminder(
                  id: 31,
                  firstName: "Tommen",
                  lastName: "Baratheon",
                  fullName: "Tommen Baratheon",
                  title: "Prince",
                  family: "Baratheon",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/tommen.jpg"
        ),

        Reminder(
                  id: 32,
                  firstName: "Gendry",
                  lastName: "Baratheon",
                  fullName: "Gendry Baratheon",
                  title: "Lord of Storm's End",
                  family: "Baratheon",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/gendry.jpg"
        ),

        Reminder(
                  id: 33,
                  firstName: "Jorah",
                  lastName: "Mormont",
                  fullName: "Jorah Mormont",
                  title: "Knight",
                  family: "Mormont",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/jorah-mormont.jpg"
        ),

        Reminder(
                  id: 34,
                  firstName: "Robert",
                  lastName: "Baratheon",
                  fullName: "Robert Baratheon",
                  title: "King",
                  family: "Baratheon",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/king-robert.jpg"
        ),

        Reminder(
                  id: 35,
                  firstName: "Ramsey",
                  lastName: "Bolton",
                  fullName: "Ramsey Bolton",
                  title: "The Bastard of Bolton",
                  family: "Bolton",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/ramsey-bolton.jpg"
        ),

        Reminder(
                  id: 36,
                  firstName: "Talisa",
                  lastName: "Stark",
                  fullName: "Talisa Stark",
                  title: "Queen Consort",
                  family: "Stark",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/talisa-stark.jpg"
        ),

        Reminder(
                  id: 37,
                  firstName: "Jeor",
                  lastName: "Mormont",
                  fullName: "Jeor Mormont",
                  title: "Lord Commander of the Knight's Watch",
                  family: "Mormont",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/lord-commander-mormont.jpg"
        ),

        Reminder(
                  id: 38,
                  firstName: "The High",
                  lastName: "Sparrow",
                  fullName: "The High Sparrow",
                  title: "High Septon",
                  family: "Sparrow",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/the-high-sparrow.jpg"
        ),

        Reminder(
                  id: 39,
                  firstName: "Oberyn",
                  lastName: "Martell",
                  fullName: "Oberyn Martell",
                  title: "Red Viper of Dorne",
                  family: "Viper",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/red-viper.jpg"
        ),

        Reminder(
                  id: 40,
                  firstName: "Melisandre",
                  lastName: "The Red Woman",
                  fullName: "Melisandre",
                  title: "Melisandre of Asshai",
                  family: "Unkown",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/melisandre.jpg"
        ),

        Reminder(
                  id: 41,
                  firstName: "Jaqen",
                  lastName: "H'ghar",
                  fullName: "Jaqen H'ghar",
                  title: "Faceless Men of Braavos",
                  family: "Lorath",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/jaqen-hghar.jpg"
        ),

        Reminder(
                  id: 42,
                  firstName: "Tywin",
                  lastName: "Lannister",
                  fullName: "Tywin Lannister",
                  title: "Lord Paramount of Westerlands",
                  family: "Lannister",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/tywin-lannister.jpg"
        ),

        Reminder(
                  id: 43,
                  firstName: "Ellaria",
                  lastName: "Sand",
                  fullName: "Ellaria Sand",
                  title: "Paramour of Prince Oberyn Martell",
                  family: "Sand",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/ellaria-sand.jpg"
        ),

        Reminder(
                  id: 44,
                  firstName: "Tormund",
                  lastName: "Giantsbane",
                  fullName: "Tormund Giantsbane",
                  title: "Free Folk Warrior",
                  family: "Free Folk",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/tormund-giantsbane.jpg"
        ),

        Reminder(
                  id: 45,
                  firstName: "Yara",
                  lastName: "Greyjoy",
                  fullName: "Yara Greyjoy",
                  title: "Lady of the Iron Islands",
                  family: "Greyjoy",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/yara-greyjoy.jpg"
        ),

        Reminder(
                  id: 46,
                  firstName: "Euron",
                  lastName: "Greyjoy",
                  fullName: "Euron Greyjoy",
                  title: "King of the iron Islands",
                  family: "Greyjoy",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/euron-greyjoy.jpg"
        ),

        Reminder(
                  id: 47,
                  firstName: "Wylis",
                  lastName: "Hodor",
                  fullName: "Hodor",
                  title: "Servant of House Stark",
                  family: "Stark",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/hodor.jpg"
        ),

        Reminder(
                  id: 48,
                  firstName: "",
                  lastName: "Pycelle",
                  fullName: "Pycelle",
                  title: "Grand Maester of the Seven Kingdoms",
                  family: "",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/pycelle.jpg"
        ),

        Reminder(
                  id: 49,
                  firstName: "Grey",
                  lastName: "Worm",
                  fullName: "Grey Worm",
                  title: "Commander of the Unsullied",
                  family: "Worm",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/greyworm.jpg"
        ),

        Reminder(
                  id: 50,
                  firstName: "Olenna",
                  lastName: "Tyrell",
                  fullName: "Olenna Tyrell",
                  title: "Queen of Thorns",
                  family: "Tyrell",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/olenna-tyrell.jpg"
        ),

        Reminder(
                  id: 51,
                  firstName: "Qyburn",
                  lastName: "Grand Maester",
                  fullName: "Qyburn",
                  title: "Former maester of the Citadel",
                  family: "Qyburn",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/qyburn.jpg"
        ),

        Reminder(
                  id: 52,
                  firstName: "Lord",
                  lastName: "Bronn",
                  fullName: "Lord Bronn",
                  title: "Lord of Highgarden",
                  family: "Bronn",
                  image: UIImage(named: "image.jpg")!,
                  imageUrl: "https://thronesapi.com/assets/images/bronn.jpg"
        )
    ]
}
#endif
