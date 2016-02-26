//
//  AlertMessageManager.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 1. 5..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

class AlertMessageManager {
    var title: String = ""
    var message: String = ""
    var acceptMessage: String = ""
    var buttons: [String] = []
    
    func clickNoticeButton(point: String) -> (title: String, message: String, buttons: [String]) {
        return ("포인트 10 감소 합니다.", "잔여포인트 : \(point)", ["취소", "확인"])
    }
    
    func ifLessPointThan10() -> (title: String, message: String) {
        return ("알림", "포인트가 부족합니다! 사람들이 공감할수 있는 댓글을 달아주세요~")
    }
    
    func clickCellFromUnivSearchVC(univ: String) -> (title: String, message: String) {
        return ("알림", "\(univ)로 설정하였습니다~")
    }
    
    func ifNoSelectedPhoto() -> (title: String, message: String) {
        return ("알림", "사진을 선택해주세요 :-)")
    }
    
    func isSuccessPost() -> (title: String, message: String, buttons: [String]) {
        return ("알림", "속닥등록에 성공하셨습니다 :-)", ["확인"])
    }
    
    func isFailToPost() -> (title: String, message: String) {
        return ("알림", "다시 시도해주시길 바랍니다 :(")
    }
    
    func isSuccessPointReturn() -> (title: String, message: String) {
        return ("알림", "확성기를 취소하였습니다.")
    }
    
    func isFailToSearch() -> (title: String, message: String) {
        return ("알림", "검색 결과가 없습니다 :[")
    }
    
    func isNoContent() -> (title: String, message: String) {
        return ("알림", "글이 없습니다.")
    }
    
    func isEmptyPostContentsTextFiled() -> (title: String, message: String) {
        return ("알림", "속마음을 적어주세요 :]")
    }
    
    init() {
        
    }
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    init(title: String, message: String, acceptMessage: String) {
        self.title = title
        self.message = message
        self.acceptMessage = acceptMessage
    }
    
    init(title: String, message: String, acceptMessage: String, buttons: [String]) {
        self.title = title
        self.message = message
        self.acceptMessage = acceptMessage
        self.buttons = buttons
    }
}