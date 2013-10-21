Seminar Scene App

SYSTEM REQUIREMENTS:	Mac OSX 8.5
			Xcode 5

LAUNCH INSTRUCTIONS:

Download the folder in this directory called Seminar Scene
Open Xcode
From Xcode open the folder you just downloaded.

From here you many run the project using the iOS Simulator that comes with Xcode.

If you wish to install this on a device, you must be a registered iOS Developer with Apple.
If you choose this option, you may have to make sure the code signing identity is your own.  To do so:

* Open Xcode's left window panel if it is not already.
* At the top of that panel, select the folder icon on the far left.
* A list of the folders and classes associated with this Xcode Project should now occupy the panel.
* The first item in that list should be the blue .xcodproj icon, titled "Seminar Scene \n 2 targets, IOS SDK 7.0"
* Click on that.
* The main window will now display build options for your app.
* On the top of the main window find the "Build Settings" tab.
* The first section of the main window is the settings for code signing.
* Make sure the code signing identity is your own.

WHAT THIS DOES:

This is an app intended to work by itself and in conjunction with the website also produced in this repository.  The app allows for swift event scheduling by utilizing user-set defaults to minimize the entry time for each individual event.  The app not only keeps its own records of the event entries, but enters them in the iPhone's calendar and (optionally) creates a notification to remind the user of the event.

The app is intended to receive events scheduled on the associated website.  Which events are received is controlled by subscriptions detailed by the user.
