# Touch Bar Preview for macOS
[![latest release](https://img.shields.io/github/release/touchbar/Touch-Bar-Preview.svg)](https://github.com/touchbar/Touch-Bar-Preview/releases/latest) [![license](https://img.shields.io/github/license/touchbar/Touch-Bar-Preview.svg)](https://github.com/touchbar/Touch-Bar-Preview/blob/master/LICENSE) [![Total downloads](https://img.shields.io/github/downloads/touchbar/Touch-Bar-Preview/total.svg)](https://github.com/touchbar/Touch-Bar-Preview/releases/latest) ![minimal system requirements](https://img.shields.io/badge/required-macOS%2010.12.2-blue.svg) [![donate](https://img.shields.io/badge/donate-buy%20me%20a%20coffee-yellow.svg)](https://www.paypal.me/alexkaessner)

<img height=256 alt="app icon" src="Touch Bar Preview/Touch Bar Preview/Assets.xcassets/AppIcon.appiconset/App-Icon-256@2x.png">

A small open source app to display your designs on the Touch Bar of the new MacBook Pro.

## Install

[Download](https://github.com/touchbar/Touch-Bar-Preview/releases/latest), unzip, and drag the app to Applications folder. Touch Bar Preview requires macOS 10.12.2 or higher.

## Instructions
**To use Touch Bar Preview just drag and drop a image file (PNG, JPEG) into the app.**
The image should be 2170px wide and 60px high. Since the Touch Bar is a high-resolution Retina display, this is equivalent to 1085pt by 30pt.

The app automatically overlaps the System button (esc) and Control Strip on top of your design. So you don't have to exclude them in your design! Your design will get the required offset to be perfectly aligned.
If your image is bigger or smaller than the required size, the image is currently stretched to fit into the app region.

### Why is it not possible to hide the ESC and System Buttons on the right side?
As Apple states in the [developer documentation](https://developer.apple.com/documentation/appkit/nstouchbar) of the Touch Bar:
>On the right side of the Touch Bar, the system supplies the always-available *Control Strip*. The Control Strip gives the user access to standard controls for display brightness, sound volume, Siri, and so on. Your app’s bars appear to the left of the Control Strip. The user can choose to hide the Control Strip, which gives the frontmost app the entire Touch Bar width.

Read more about the Touch Bar in the [Apple HIG](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/OSXHIGuidelines/AbouttheTouchBar.html#//apple_ref/doc/uid/20000957-CH104-SW1).

## Touch Bar UI Kit
If you're searching for a Touch Bar UI Kit, take a look at my [macOS UI Kit](https://github.com/alexkaessner/macOS-UI-Kit) Bundle.

You can also find the download link in the app.

## Contributing
Feel free to create pull requests if you want to support the app!

If you have any feature request or found a bug, please create a new [issue](https://github.com/touchbar/Touch-Bar-Preview/issues).
