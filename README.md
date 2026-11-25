# CCGlassBlur

A standalone jailbreak tweak project for adding a blurred background to Control Center.

## Target device

- Device: iPhone 7 (arm64)
- iOS: 15.8.8
- Jailbreak: Dopamine (rootless)
- Package identifier: `com.le17y17abd.ccglassblur`

## Build

The GitHub Actions workflow builds a rootless Debian package and uploads the resulting `.deb` as a workflow artifact.

## Initial implementation

The tweak hooks `CCUIModularControlCenterOverlayViewController` and inserts a non-interactive system-material blur view behind the controller's content.

This is an initial implementation. The private Control Center class and view hierarchy must still be validated on the target iOS 15.8.8 device. Do not treat the tweak as device-tested until it has been installed and checked on the iPhone.
