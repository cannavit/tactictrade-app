# tactictrade

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Deploy in Play Store using GitHub

    https://danielllewellyn.medium.com/flutter-github-actions-for-a-signed-apk-fcdf9878f660

    cp  ~/upload-keystore.jks ./android/

    echo "android/*.jks" >> .gitignore

    export KEY_PASSWORD=Milan.2020
    export KEY_PASSWORD=Milan.2020

    flutter clean
    flutter build appbundle


    heroku config -s -a django-backend-steging > .env.staging


    


## Encode file upload-keystore.jks

base64 -i ~/.android/debug.keystore -o <outfile>
  # flutter build appbundle --build-name=1.0.11 --build-number=11

# keytool -list -v \ -alias androiddebugkey -keystore ~/.android/debug.keystore

# $ java -jar pepk.jar --keystore=foo.keystore --alias=foo --output=output.zip --include-cert --encryptionkey=
# docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) yongjhih/pepk --keystore=/Users/ceciliocannavaciuolo/.android/debug.keystore  --alias=foo --output=output.zip --encryptionkey=eb10fe8f7c7c9df715022017b00c6471f8ba8170b13049a11e6c09ffe3056a104a3bbe4ac5a955f4ba4fe93fc8cef27558a3eb9d2a529a2092761fb833b656cd48b9de6a --include-cert


# java -jar pepk.jar --keystore=/Users/ceciliocannavaciuolo/.android/debug.keystore  --alias=androiddebugkey --output=output.zip --include-cert --encryptionkey=eb10fe8f7c7c9df715022017b00c6471f8ba8170b13049a11e6c09ffe3056a104a3bbe4ac5a955f4ba4fe93fc8cef27558a3eb9d2a529a2092761fb833b656cd48b9de6a