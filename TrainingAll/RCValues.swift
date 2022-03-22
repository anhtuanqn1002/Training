//
//
//import FirebaseRemoteConfig
//
//enum ColorValue: String {
//    case mainColor = "main_color"
//}
//
//final class RCValues {
//    static let shared = RCValues()
//    let remoteConfig = RemoteConfig.remoteConfig()
//    
//    private init() {
//        loadDefaultValues()
//    }
//    
//    func getValue(_ key: ColorValue) -> RemoteConfigValue {
//        return remoteConfig[key.rawValue]
//    }
//    
//    func loadDefaultValues() {
//        RemoteConfig.remoteConfig().setDefaults(fromPlist: "RemoteConfigDefaults")
//    }
//    
//    func fetchCloudValues() {
//        #if DEBUG
//        // 1
//        // WARNING: Don't actually do this in production!
//        let fetchDuration: TimeInterval = 0
//        #else
//        let fetchDuration: TimeInterval = 43200    // 43200 seconds = 12 hours
//        #endif
//        remoteConfig.fetch(withExpirationDuration: fetchDuration) { [weak self] status, error in
//            if let error = error {
//                print("Uh-oh. Got an error fetching remote values \(error)")
//                return
//            }
//            
//            // 2
//            self?.remoteConfig.activate { error in
//                
//            }
//            print("Retrieved values from the cloud!")
//        }
//        
//    }
//}
