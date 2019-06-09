# Weather

The task was to produce a universal application using the OpenWeather API with a five-day forecast for the city of Paris.
Amongst the requirements, it was that the app should be iOS 8 compatible and written in swift 2.3 or 3.0, but as I didn't have a computer with the software required, Swift 5.0 was used.


## Summary
Issue | Weather
------------ | -------------
**Architecture**: | VIPER
**Dependencies Manager**: | CocoaPods
**External Frameworks**: | RxSwift, Realm, Kingfisher
**Language**: | Swift 5.0
**Deployment Target**: | iOS 8.0
**Devices**: | Universal

## Thoughts

* **Networking**:  No external framework was used for the main request on this layer. The new swift 5 Result type, as well as Decodable (Swift 4),  were used. (*)
* **Persistency**: Realm framework was used because of its speed, easiness and because it's cross-platform (*)
* **Repositories**: RxSwift was used to deal with asynchronous tasks within the code
* **Views**: No external framework was used to deal with views.
* **Tests**: No specialized external framework was used to perform the tests, which were centered mainly on the interactors and some of the core behavior of the presenters.

(*)  Networking and persistency for images was dealt with Kingfisher, slightly breaking  the architecture was considered a more clean approach in this case.
