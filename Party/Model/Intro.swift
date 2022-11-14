import Foundation

struct Intro: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var description : String
    
}

var intros: [Intro] = [
    .init(imageName: "introImage1", title: "BEN HİÇ...",
          description: "Bu tür kartlarda yazanı yapmış olanlar içer..."),
    .init(imageName: "introImage2", title: "OYLAMA SORULARI",
          description: "Bu tür kartlarda sorulan soru için oylama yapılır, en çok oyu alan oyuncu içer."),
    .init(imageName: "introImage3", title: "DOĞRULUK MU CESARETLİLİK Mİ?",
          description: "Bu tür kartlar eğlence için var. İçip içmemek size kalmış.")
    ]

//
//var intros: [Intro] = [
//    .init(imageName: "cheers", title: "İçkiler hazır mı ? ", description: "Sarhoş olup, eğlencenin dibine vurmaya hazır mıyız ? 🔥🥂🍷"),
//    .init(imageName: "cheers3", title: "Nasıl Oynanır?", description: "Kategoriler içerisinde 100'den farklı soru bulunur, ortama göre kategorini seç ve kartları fırlat ! ⚡️")
//    ]
