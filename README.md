# 500px

# How to use
In order for this application to run a `500px/Settings.plist` must be created which will contain the private keys to access 500px APIs. This file is not supposed to be committed to the repo due to the sensitivity of the private keys and the dynamic nature of this application.
The format of the Settings.plist should be as follows:
```
<plist version="1.0">
<dict>
	<key>CONSUMER_KEY</key>
	<dict>
		<key>dev</key>
		<string>developmentKeyHere</string>
		<key>prod</key>
		<string>productionKeyHere</string>
	</dict>
</dict>
</plist>
```
