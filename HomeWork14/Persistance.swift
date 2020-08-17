
import Foundation

class Persistance{
    static let shared=Persistance()
    
    private let keyUserName="Persistance.UserName"
    private let keyUserSecondName="Persistance.UserSecondName"

    //читаем и сохраняем имя пользователя
    var userName: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: keyUserName)
        }
        get{
            return UserDefaults.standard.string(forKey: keyUserName)
        }
    }

    //фамилия пользователя
    var userSecondName: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: keyUserSecondName)
        }
        get{
            return UserDefaults.standard.string(forKey: keyUserSecondName)
        }
    }

}
