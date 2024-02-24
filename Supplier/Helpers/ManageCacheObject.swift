//
//  ManageCacheObject.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//


import UIKit
import ObjectMapper

class ManageCacheObject {
    
    // MARK: - Set App Language
    static func setAppLanguage(lang:String) {
        UserDefaults.standard.set(lang, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_APP_LANGUAGE)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Get App Language
    static func getAppLanguage() -> String {
        if let language  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_APP_LANGUAGE)  {
            return String(language as! String)
        }else{
           return ""
        }
    }
    
    
    // MARK: - setConfig
    static func setConfig(_ config: Config){
        UserDefaults.standard.set(Mapper<Config>().toJSON(config), forKey:Constants.KEY_DEFAULT_STORAGE.KEY_CONFIG)
    }
    
    static func getConfig() -> Config{
        if let config  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_CONFIG){
            return Mapper<Config>().map(JSONObject: config)!
        }else{
            return Config.init()!
        }
    }
    
    // MARK: - setConfig
    static func setSetting(_ setting: Setting){
        UserDefaults.standard.set(Mapper<Setting>().toJSON(setting), forKey:Constants.KEY_DEFAULT_STORAGE.KEY_SETTING)
    }
    
    static func getSetting() -> Setting{
        if let settings  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_SETTING){
            dLog(Mapper<Setting>().map(JSONObject: settings)!)
            return Mapper<Setting>().map(JSONObject: settings)!
        }else{
            return Setting.init()!
        }
    }
    
    
    static func saveCurrentUser(_ user : Account) {
        UserDefaults.standard.set(Mapper<Account>().toJSON(user), forKey:Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT)
        
    }
    
    static func getCurrentUser() -> Account {
        if let user  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT){
            return Mapper<Account>().map(JSONObject: user)!
        }else{
            return Account.init()
        }
         
    }
    
   

    static func setLogin(_ isLogin: Bool){
        UserDefaults.standard.set(isLogin, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_LOGIN)
    }
    
    static func setUserId(_ userId:Int){
        UserDefaults.standard.set(userId, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_ACCOUNT_ID)
    }
    
    //Mark - check setting biometris
    
    static func setBiometric(_ biometric:String){
        UserDefaults.standard.set(biometric, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_BIOMETRIC)
    }
    
    static func getBiometric()->String{
         if let biometric  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_BIOMETRIC){
           
            return String(biometric as! String)
         }else{
            return ""
         }
 
    }
    
    
    
    

    // MARK: - PUSH_TOKEN
    static func setPushToken(_ push_token:String){
        UserDefaults.standard.set(push_token, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PUSH_TOKEN)
    }
    
    static func getPushToken()->String{
        if let push_token : String = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PUSH_TOKEN) as? String{
            return push_token
        }else{
            return ""
        }
    }
    

    static func isLogin()->Bool{
        let account = ManageCacheObject.getCurrentUser()
        if(account.id == 0){
            return false
        }
        return true
    }
        
    static func getUsername()->String{
         if let username  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PHONE){
            
            return String(username as! String)
         }else{
            return ""
         }
 
    }
    
    static func setUsername(_ username:String){
        UserDefaults.standard.set(username, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PHONE)
    }
    
    static func getUsernameLogin()->String{
         if let username  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_USERNAME){
            
            return String(username as! String)
         }else{
            return ""
         }
    }
    static func setUsernameLogin(_ username:String){
        UserDefaults.standard.set(username, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_USERNAME)
    }
    
    static func getSupplierNameLogin()->String{
         if let username  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_SUPPLIER_NAME){
            
            return String(username as! String)
         }else{
            return ""
         }
    }
    static func setSupplierNameLogin(_ username:String){
        UserDefaults.standard.set(username, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_SUPPLIER_NAME)
    }
    
    static func getPassword()->String{
         if let password  = UserDefaults.standard.object(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PASSWORD){
            return String(password as! String)
         }else{
            return ""
         }
 
    }
    
    static func setPassword(_ password:String){
        UserDefaults.standard.set(password, forKey:Constants.KEY_DEFAULT_STORAGE.KEY_PASSWORD)
    }
    
   
    static func setIsPlaySound(_ isPlaySound: Bool){
        UserDefaults.standard.set(isPlaySound, forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PLAY_SOUND)
    }
    
    static func isPlaySound()->Bool{
        let isPlaySound : Bool = UserDefaults.standard.bool(forKey: Constants.KEY_DEFAULT_STORAGE.KEY_PLAY_SOUND)
       return isPlaySound
    }
    
    
}
