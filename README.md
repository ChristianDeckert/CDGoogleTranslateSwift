# CDGoogleTranslateSwift
A google translate wrapper written in Swift

Currently suppports german, english, french, italian and spanish.

#### Usage
```swift
GTService.shared.translate(text: "die Wälder", to: .en) { result, error in
    let translation = result?.translation // returns the woods
    //let detectedLanguage = result?.detectedLanguage // returns "de"
    debugPrint(String(describing: error?.localizedDescription ?? translation))
}
```

#### CocoaPods
```
pod 'CDGoogleTranslateSwift', :git => 'https://github.com/ChristianDeckert/CDGoogleTranslateSwift.git', :branch => 'master'
```
