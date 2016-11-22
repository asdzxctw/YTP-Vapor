import Foundation
import Vapor
import  Ji
import HTTP


let drop = Droplet()
//let pGetter = StockPriceGetter(number:6116)



drop.get { _ in
    return try JSON(node: [
        "現在時間":"上午貳拾壹點參捌點整"
        ])
}

drop.get("html") { request in
    return try drop.view.make("index.html")
}

drop.get("imageIndex") { request in
    return try drop.view.make("imageView.html")
}

drop.post("upload") { request in
    if let numStr = request.data["key"]?.string {
        if let num = Int(numStr) {
            if num>1000&&num<10000{
                let pGetter = StockPriceGetter(number:Int(numStr)!)
                
                return try JSON(node: pGetter.getPriceNow())
            }
        }
        
    }
    return "Error retrieving parameters."
}

drop.post("hisPrice") { request in
    if let numStr = request.data["key"]?.string {
        if let num = Int(numStr) {
            if num>1000&&num<10000{
                let pGetter = StockPriceGetter(number:Int(numStr)!)
                if let sDate = request.data["startDate"]?.string{
                   if let eDate = request.data["endDate"]?.string{
                    
                    return try JSON(node: pGetter.getHistoryPrice(startDate: sDate, endDate: eDate))
                    }
                }
            }
        }
        
    }
    return "Error retrieving parameters."
}
    
//測試用post("hisPrice")
//drop.post("hisPrice") { request in
//    if let numStr = request.data["key"]?.string {
//        if let sDate = request.data["startDate"]?.string{
//            if let eDate = request.data["endDate"]?.string{
//                    
//                return try JSON(node: [
//                        "代碼":numStr,
//                        "開始":sDate,
//                        "結束":eDate
//                    ])
//            }
//        }
//    }
//    return "Error retrieving parameters."
//}

drop.get("/stockNum",":key") { request in
    if let numStr = request.parameters["key"]?.string {
        if let num = Int(numStr) {
            if num>1000&&num<10000{
                let pGetter = StockPriceGetter(number:Int(numStr)!)
                
                return try JSON(node: pGetter.getPriceNow())
            }
        }
        
    }
    return "Error retrieving parameters."
    
}

drop.run()
