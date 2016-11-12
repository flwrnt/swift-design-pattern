//
//  Const.swift
//  design-pattern
//
//  Created by Flwrnt on 09/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

struct Const {
    static let userAgent = "weecop-app-ios-1.0"
    
    struct Url {
        static let isConnected = "https://www.weecop.fr/User/IsConnected"
        static let login = "https://www.weecop.fr/User/Login?ajax"
        static let notifications = ""
        static let register = "https://www.weecop.fr/User/Register?ajax"
        static let user = "https://www.weecop.fr/User/"
        static let passwordForgotten = "https://www.weecop.fr/User/PasswordForgotten"
        static let disconnect = "https://www.weecop.fr/User/Disconnect?security="
        static let partners = "https://www.weecop.fr/User/Partners"
        static let refundFriend = "https://www.weecop.fr/User/RefundFriend"
        static let talk = "http://talk.weecop.fr"
        static let facebook = "https://www.facebook/Weecop"
        static let contact = "https://www.weecop.fr/Contact"
    }
    
    struct Api {
        static let partnersInfo = "http://api.weecop.fr/v1/Map/"
        static let registerDevice = "https://api.weecop.fr/v2/Native/RegisterDevice"
        static let event = "https://api.weecop.fr/v2/Notifications/<notif_token>/"
    }
    
    struct Param {
        static let email = "auth_email"
        static let password = "auth_password"
        static let token = "auth_deviceToken"
        static let deviceUid = "auth_deviceUid"
        static let platform = "platform"
        static let version = "versionCode"
    }
    
    struct DateFormat {
        static let usa = "yyyy-MM-dd HH:mm:ss"
    }
    
    struct SegueID {
        static let login = "LoginView"
        static let web = "WebViewController"
        static let partners = "mapView"
        static let notificationDetails = "readNotification"
    }
    
    struct File {
        static let token = "token.txt"
        static let deviceUid = "deviceUid.txt"
    }
    
    struct Observer {
        static let displayNotification = "displayNotification"
        static let launchRemoteNotification = "launchRemoteNotification"
    }
    
    struct City {
        struct Tours {
            static let latitude = 47.385034
            static let longitude = 0.685186
        }
    }
    
    struct Keychain {
        static let username = "weecop-username"
    }
    
    struct ViewControllerIdentifier {
        static let root = "HomeVC"
        static let login = ""
        static let notificationDetails = "NotificationDetailsVC"
    }
    
    struct Err {
        static let connexionInterrupted = "La connexion Internet semble interrompue."
    }
}
