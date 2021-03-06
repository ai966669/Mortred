//
//  MFirstPageTableView.swift
//  Tickets
//
//  Created by ai966669 on 16/5/4.
//  Copyright © 2016年 ai966669. All rights reserved.
//

import UIKit
class Banner:NSObject {
    var image:String=""
    var id = -1
    var status = 1
    var url = ""
}
class TicketDescription{
    var title=""
    var content=""
}
class Ticket:NSObject {
    var bussiness = "";
    var end_time = "";
    var id = -1;
    var image = ""
    var origin_storage = -1;
    var price : Double = 10;
    var start_time = ""
    var status = 1;
    var storage = -1
    var title = ""
    var coverImg=""
    var score = 100
    var rules="" //兑换条件
    var descriptions:[TicketDescription]=[]
}
class MFirstPageTableView: TopModel {
    var banners:[Banner]!
    var tickets:[Ticket]!
    func getDataForTicketsList(pageSize:Int,doLater:()->Void){
        let param = TopModel.specialProcess(["page":1,"pageSize":pageSize]);
        TopModel.universalRequest(requestMethod: Method.GET, dic: param, urlMethod: TKConfig.URLCouponCouponList, success: { (model) in
            
            if let rInDic = model!["result"]   as? Dictionary<String,AnyObject>{
                if let dataArr = rInDic["couponList"] as? NSArray {
                    if let ticketArr:[Ticket] = D3Json.jsonToModelList(dataArr, clazz: Ticket.self){
                        self.tickets = ticketArr
                    }
                }
            }
            doLater()
            SVProgressHUD.showInfoWithStatus("成功")
        }) { (code) in
            SVProgressHUD.showInfoWithStatus("失败")
        }
    }
    func getDataForBanner(doLater:()->Void){
        let param = TopModel.specialProcess([:]);
        TopModel.universalRequest(requestMethod: Method.GET, dic: param, urlMethod: TKConfig.URLBannerBannerList, success: { (model) in
            if let rInDic = model!["result"]  as? Dictionary<String,AnyObject>{
                if let dataArr = rInDic["bannerList"] as? NSArray {
                    if let bannerArr:[Banner] = D3Json.jsonToModelList(dataArr, clazz: Banner.self){
                        self.banners = bannerArr
                    }
                }else{
                    
                }
            }
            doLater()
            SVProgressHUD.showInfoWithStatus("成功")
        }) { (code) in
            SVProgressHUD.showInfoWithStatus("失败")
        }
        
    }
}
