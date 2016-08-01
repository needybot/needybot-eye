# Needybot Eye iOS App
Swift based iOS application that runs Needybot's eye animations and UI.

#### Getting Started

This project uses [cocoapods](https://cocoapods.org/) for dependency management. Although [installing cocoapods](https://guides.cocoapods.org/using/getting-started.html) is not required for working on this project, it _is_ required if you need to add a new third party dependency. All dependencies are vendored into the repository, so be sure to add them when committing. 

Versions:
- Cocoapods: 0.38.2
- Xcode: 7.x
- Swift: 2.x

**Normally you open an xcode project by opening the NBFace.xcproject file; however, this project requires you to work out of NBFace.xcworkspace.**

```
$ git clone git@github.com:wieden-kennedy/NBFace.git
$ open NBFace/NBFace.xcworkspace
```

#### Troubleshooting

There should not be a need to update build settings during troubleshooting. Most problems can be solved by performing a clean or following the stack trace. If you get an error code from cocoapod's `/bin/sh` script, try the following: 

> In the Product menu, hold the Option key and select 'Clean Build Folder'

**Cleaning cocoapods**

This needs to be done rarely but is sometimes necessary when upgrading Swift/Xcode. Refer to the following steps as a last resort:

1. `$ pod cache clean --all`
2. `$ rm -rf Pods/`
3. `$ rm Podfile.lock`
4. `$ rm NBFace.xcworkspace`
5. `$ pod install` 

The final step will reinstall all pods and regenerate the workspace.


Contributing
------------

See our contribution guidelines [here](CONTRIBUTION_GUIDELINES.md).


License
-------

This project is release under Apache 2.0. Please see the [LICENSE](LICENSE) file for more details.
