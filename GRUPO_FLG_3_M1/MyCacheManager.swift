import UIKit

protocol Cacheable: AnyObject {}

class MyCacheManager<T: Cacheable> {
    private let myCache = NSCache<NSString, T>()

    internal init() {
        configureCacheClearTimer()
    }

    func addToCache(key: String, value: T) {
        myCache.setObject(value, forKey: key as NSString)
    }

    func retrieveFromCache(key: String) -> T? {
        return myCache.object(forKey: key as NSString)
    }

    private func configureCacheClearTimer() {
        let timer = Timer(timeInterval: 24 * 60 * 60, target: self, selector: #selector(clearCache), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }

    @objc private func clearCache() {
        myCache.removeAllObjects()
        print("Cache cleared")
    }
}

class CacheableObject: Cacheable {}

struct CacheManagerSingleton {
    static let shared = MyCacheManager<CacheableObject>()
}

// Função principal
func main() {
    let cacheManager = CacheManagerSingleton.shared
    let cachedObject = CacheableObject()
    cacheManager.addToCache(key: "exampleKey", value: cachedObject)

    if let retrievedObject = cacheManager.retrieveFromCache(key: "exampleKey") {
        print("Cached object: \(retrievedObject)")
    }
}
