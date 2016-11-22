import Vapor
import Ji
import Foundation

class StockPriceGetter{
    var stockNum:Int
    var stockUrl:URL
    var hisStockURL:URL
    
    init(number:Int) {
        self.stockNum = number
        stockUrl = URL(string: "https://tw.stock.yahoo.com/q/q?s=\(number)")!
        hisStockURL = URL(string: "http://www.cnyes.com/twstock/ps_historyprice/\(number).htm")!
    }
    
    
    func getHistoryPrice(startDate:String,endDate:String) -> [String:String] {
        var reDic:[String:String] = [:]
        let sema = DispatchSemaphore.init(value: 0)
        print(startDate)
        print(endDate)
        
        let session = URLSession(configuration: .default)
        var request: URLRequest = URLRequest(url: hisStockURL)
        request.httpMethod = "POST"
        request.httpBody = "ctl00$ContentPlaceHolder1$startText=\(startDate)&ctl00$ContentPlaceHolder1$endText=\(endDate)".data(using: String.Encoding.utf8)
        
        
        let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let jiDoc = Ji(htmlData: data!)!
            let endPriceNodes = jiDoc.xPath("//div[@id='main3']/div[@class='mbx bd3']/div[@class='tab']/table/tr/td[5]")
            let timeNodes = jiDoc.xPath("//div[@id='main3']/div[@class='mbx bd3']/div[@class='tab']/table/tr/td[1]")
            
            for index in 0...endPriceNodes!.count-1{
                reDic["\(timeNodes![index].content!)"] = "\(endPriceNodes![index].content!)"
            }
            //reDic = ["Yo":"Hoho"]
            sema.signal()
            
        }
        dataTask.resume()
        sema.wait()
        
        return reDic
        
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
