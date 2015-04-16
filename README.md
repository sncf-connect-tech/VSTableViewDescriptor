#GGLocalizationSystem

GGLocalizationSystem allows to change the current language of iOS app on runtime.
When you change the language of the app, GGLocalizationSystem sets the bundle linked with the new language.

```objective-c
[[GGLocalizationSystem sharedLocalSystem] setLanguage:@"en"];
```

### Strings

Use `.strings` files for localizing texts.

```objective-c
GGLocalizeString(@"hello_world");
```

### Data

To localize other data like `.plist` file:

```objective-c
NSString* path = [[[GGLocalizationSystem sharedLocalSystem] bundle] pathForResource:@"myFile" ofType:@"plist"];
NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
```

### Installing

If you're using [CocoPods](http://cocopods.org) it's as simple as adding this to your `Podfile`:

	pod 'GGLocalizationSystem', '~> 1.0'