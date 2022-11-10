import Foundation

struct Intro: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var description : String
    
}

var intros: [Intro] = [
    .init(imageName: "cheers", title: "İçkiler hazır mı ? ", description: "Sarhoş olup, eğlencenin dibine vurmaya hazır mıyız ? 🔥🥂🍷"),
    .init(imageName: "cheers3", title: "Nasıl Oynanır?", description: "Kategoriler içerisinde 100'den farklı soru bulunur, ortama göre kategorini seç ve kartları fırlat ! ⚡️")
    ]
