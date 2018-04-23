import Foundation

public class GTService: NSObject {
    
    public typealias GTServiceBlock =  (_ result: Result?, _ error: Error?) -> Void
    
    public enum TargetLanguage: String {
        case en = "en"
        case de = "de"
        case fr = "fr"
        case it = "it"
        case es = "es"
    }
    
    public enum SourceLanguage: String {
        case auto = "auto"
        case en = "en"
        case de = "de"
        case fr = "fr"
        case it = "it"
        case es = "es"
        
        static var currentLanguage: SourceLanguage {
            guard let locale = Locale.current.identifier.components(separatedBy: "_").first?.lowercased() else { return .auto }
            
            switch locale {
            case "de": return .de
            case "en": return .en
            case "fr": return .fr
            case "it": return .it
            case "es": return .es
            default: return .auto
            }
        }
    }
    
    public struct Result {
        public let source: String
        public let translation: String
        public let detectedLanguage: String?
    }
    
    public static let shared = GTService()
    
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
    }()
    
    private lazy var sessionConfiguration: URLSessionConfiguration = {
        return URLSessionConfiguration.default
    }()
    
    private func url(sourceText: String, targetLanguage: TargetLanguage, sourceLanguage: SourceLanguage = .auto) -> String {
        return "https://translate.googleapis.com/translate_a/single?client=gtx&sl=\(sourceLanguage.rawValue)&tl=\(targetLanguage.rawValue)&dt=t&q=\(sourceText)"
    }
    
    @discardableResult public func translate(text: String, to targetLanguage: TargetLanguage, from sourceLanguage: SourceLanguage = .auto,completion: @escaping GTServiceBlock) -> Bool {
        guard !text.isEmpty else { return false }
        guard let escapedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return false }
        guard let url = URL(string: url(sourceText: escapedText, targetLanguage: targetLanguage, sourceLanguage: sourceLanguage)) else { return false }
        
        let task = urlSession.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            guard let data = data else { return }
            do {
                guard var responseArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any] else { return }
                responseArray = responseArray.filter { !($0 is NSNull) }
                self.parseAndReturn(responseArray: responseArray, source:text, completion: completion)
                
            } catch {
                DispatchQueue.main.async { completion(nil, error) }
            }
        })
        
        task.resume()
        
        return true
    }
    
    func parseAndReturn(responseArray: [Any], source: String, completion: @escaping GTServiceBlock) {
        
        let error = NSError.init(domain: "GTService", code: 1, userInfo: [NSLocalizedDescriptionKey: "invalid google translate response"])
        
        guard let resultsArray = responseArray.first as? [[Any]] else {
            DispatchQueue.main.async { completion(nil, error as Error) }
            return
        }
        guard let translation = resultsArray.first?.first as? String else {
            DispatchQueue.main.async { completion(nil, error as Error) }
            return
        }
        
        let detectedLanguage: String?
        if responseArray.count > 1 {
            detectedLanguage = responseArray[1] as? String
        } else {
            detectedLanguage = nil
        }
        
        let result = Result(source: source, translation: translation, detectedLanguage: detectedLanguage)
        DispatchQueue.main.async { completion(result, nil) }
        
    }
    
}

extension GTService: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        debugPrint("GTService error: \(String(describing: error?.localizedDescription))")
    }
}

