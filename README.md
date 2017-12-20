# How to setup test HTTPS (TLS) environment on macOS

## Overview
When we need to test apps communicating to a server over HTTPS, Apple [recommends](https://developer.apple.com/library/content/qa/qa1948/_index.html) the following aproach:

1. Create your own certificate authority (CA) for testing
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
The quickest way to install a CA’s root certificate on the emulator is to drag the root certificate to the main emulator window. This will kick off the install process.

You can check that the certificate was installed successfully in Settings > Security & Location > Encryption & credentials > Tusted credentials (User tab).

Also to have access to your test server you should update `hosts` file on emulator:

1. Run emulator with write access to the system folder.
```bash
./emulator -avd <emulator_name> -writable-system
```  

2. Connect to emulator from terminal.
```bash
adb root
adb remount
```

3. Pull `hosts` file from emulator.
```bash
adb pull /system/etc/hosts hosts
```

4. Update `hosts` file locally.

5. Push `hosts` file from emulator.
```bash
adb push hosts /system/etc
```
6. Restart emulator in system read-only mode.

## References
1. [Apple Developer Technical Q&A QA1948. HTTPS and Test Servers.](https://developer.apple.com/library/content/qa/qa1948/_index.html)
