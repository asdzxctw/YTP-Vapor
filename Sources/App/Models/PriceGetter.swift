import Vapor
import Ji
import Foundation

class StockPriceGetter{
    var stockNum:Int
    var stockUrl:URL
    
    init(number:Int) {
        self.stockNum = number
        stockUrl = URL(string: "https://tw.stock.yahoo.com/q/q?s=\(number)")!
    }
    
    func getPriceNow() -> [String:String] {
        var reDic:[String:String]!
        var resultArray:[String] = []
        
        let jiDoc = Ji(htmlURL: stockUrl)
        let stockNode = jiDoc?.xPath("/html/body/center/table/tr/td/table/tr[2]/td")
        
        for element in stockNode!{
            resultArray.append("\(element.content!)")
        }
        
        if resultArray.count > 5 {
            resultArray.removeLast()
            reDic = [
                "股票代號":"\(self.stockNum)",
                "時間":resultArray[1],
                "成交":resultArray[2],
                "買進":resultArray[3],
                "賣出":resultArray[4],
                "漲跌":"\(Double(resultArray[2])!-Double(resultArray[7])!)",
                "張數":resultArray[6],
                "昨收":resultArray[7],
                "開盤":resultArray[8],
                "最高":resultArray[9],
                "最低":resultArray[10],
                
            ]
            
            return reDic
        }else{
            return ["訊息":"找不到股票呢QQ"]
        }
        
        
        
    }
    
}
