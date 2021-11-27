## Getting started

Before starting used Xcode version `13.1`


## `Project Structure`

For this project use  [The Composable Architecture](https://github.com/pointfreeco) for Presentaion Layer.
and combined SwiftUI and Combine
There are 4 other Module 
That I explain more in below.


### `REO App`

Main executable target of our application.
| Directory             | Description                                                                |
| ----------------- | ------------------------------------------------------------------ |
| `Module` | Here you can implementation for all Modules and setup and Design App. |
| `App` | the main dependency injection environment and App state is here . |
| `Resource` | Containt Branding (Theme and Asset, ect..)|

`Resource`:  I would be great if we have another module as Branding and we can even use SwiftGen to generating theme and images and asset.


### `Network`

All files are related to the Network, and calling any network is there (gRPC, Graphql, REST, etc.). This target should only be used in [Repository](#repository) and nowhere else.


### `Core`

Contain Pure and dummy entities and use-cases:

-   Data models that we use throughout the app such as `Property,` `PropertyList,` etc.
-   Services that are used to talk to our own API or outside world.

### `Repostory`

This module acts like Brain. App just talks with Repository for any services need. It feeds the app with modules that it accesses.
For example, for API calls, this module implements the default use-cases, and the only app calls this module for network calls or etc...


About the Test Targets: I tried to coverage the most important part of the any module with Test 
the only reason for this acting, it's test project and time limitation.
Absoluty we have to cover all the code and logic with Test.
