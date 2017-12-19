# How to setup test HTTPS (TLS) environment on macOS

## Overview
When we need to test apps communicating to a server over HTTPS, Apple [recommends](https://developer.apple.com/library/content/qa/qa1948/_index.html) the following aproach:

1. Create your own CA for testing
2. Use that CA to create a digital identity for your server
3. Install that CA’s root certificate on your test devices

## Creating Your Own Test Certificate Authority
### Creating a Certificate Authority
```bash
.\create-ca.sh
```

### Issuing a Digital Identity
```bash
.\issue-di.sh localhost
```

## Server Settings
### NGINX installation
### NGINX TSL/HTTPS settings
TODO


## Installing CA root certificate on Test Device
### macOS
To install a CA’s root certificate on macOS, use the Keychain Access utility to add the root certificate (ca.cer) to the System keychain and then explicitly mark it as trusted.

### iOS Simulator
The quickest way to install a CA’s root certificate on the simulator is to drag the root certificate to the main simulator window. This will kick off the install process.

When CA's root certificate is completed you must specifically enable the root certificate in Settings > General > About > Certificate Trust Settings.

### Android Emulator
TODO

## References
1. [Apple Developer Technical Q&A QA1948. HTTPS and Test Servers.](https://developer.apple.com/library/content/qa/qa1948/_index.html)
