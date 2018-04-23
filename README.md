# CDGoogleTranslateSwift
A google translate wrapper written in Swift

Currently suppports german, english, french, italian and spanish.

#### Usage
```
GTService.shared.translate(text: text, to: GTService.TargetLanguage.en) { result, error in
    let translation = result?.translation
    //let detectedLanguage = result?.detectedLanguage
    debugPrint(String(describing: error?.localizedDescription ?? translation))
}
```

#### CocoaPods
```
pod 'CDGoogleTranslateSwift', :git => 'https://github.com/ChristianDeckert/CDGoogleTranslateSwift.git', :branch => 'master'
```
