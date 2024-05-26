## Core Architecture
This implementation is based on the clean acrhitecture principles. The project is composed of three modules in addition to the app project. Each module mirrors the app's features. 
Each module is broken down into targets where each target mirrors a layer in the clean architecture, respecting the inter-layer dependency graph. 

## Navigation architecture
This project makes use of the coordinator pattern to organize the flow of screens in the app. Module packages provide stand-alone screens, while it's up to the app to organize which and how each screen will appear after the other.

## Presentation architecture
Presentation and interaction is implemented following by view models (from MVVM). 

## Concurrency
Swift concurrency is used, making sure to abide with structured concurrency principles

## Testability
Components across layers are well abstracted (using protocols and closures) and are unit-test friendly.

## Environment
This project is built using Xcode 15.4, and back deploys to iOS 16.


Module structre (target break-down):
- Domain
  - Hosts use cases which represents what the user can do with the app.
  - A use case showcases the expectations of the user without getting into details of data fetching nor UI intricacies.
- Data
  - Hosts repositories and data sources that satisfy the needs of the said use cases.
- UI
  - Provides the screen UI used in the app.
- DI
  - Provides dependency containers for the the app to conveniently build the needed flows.
- Umbrella targets for convenience to improve dev ux in the app target

## Progress
- [x] Login
- [x] Verify OTP
- [x] Persist logged-in state 
- [x] Load incidents list
- [x] Filter incidents list
- [ ] OTP input edge cases
- [ ] Secure persistence of access tokens (e.g. using KeychainAccess)
- [ ] Local data persistence
- [ ] Add incident
- [ ] Update incident status
- [ ] Worker tracking
- [ ] Dashboard

## Video

https://github.com/ahmedk92/ElmTask/assets/11476927/3ecbecbb-06b1-441c-96e6-0177835201e7

