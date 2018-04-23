# CDGoogleTranslateSwift
A google translate wrapper written in Swift

#### Usage
```
GTService.shared.translate(text: text, to: GTService.TargetLanguage.en) { result, error in
    let translation = result?.translation
    //let detectedLanguage = result?.detectedLanguage
    debugPrint(String(describing: error?.localizedDescription ?? translation))
}
```