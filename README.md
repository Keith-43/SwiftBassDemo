# SwiftBassDemo
This app uses the BASS audio library to render a real-time spectrum of a music file or live microphone input.

This is a Swift Xcode project incorporating the BASS audio library.  It is multiplatform (meaning it works on both macOS and iOS devices).  The app has BASS code to play an included mp3 music file and render it's real-time spectrum.  (The license-free music file is "The Elevator Bossa Nova" from Bensound.com ).  Changing the MicOn variable to true enables live microphone input.

The BASS audio library is free for non-commercial usage.  For commercial usage, see https://www.un4seen.com for licensing information.

-------------------
Here's how I created this project.  (I used the newest versions of macOS 13.2.1, iOS 16.3.1, Xcode 14.2 and BASS 2.4.17 on 7 March 2023.)  

Step 1:  
In Xcode, create a new Multiplatform App named SwiftBassDemo.  Build and run it to get a window displaying "Hello, world!". This creates a SwiftBassDemo project which contains (in the Finder window used by Xcode) the file structure:

	SwiftBassDemo (project folder)
		SwiftBassDemo (app folder)
			Assets.xcassets
			ContentView.swift
			Preview Content (folder)
			SwiftBassDemo.entitlements
			SwiftBassDemoApp.swift
		SwiftBassDemo.xcodeproj

Step 2:  
Go to https://www.un4seen.com and download the macOS  and iOS versions of the BASS audio library.  This puts two folders named bass24-osx and bass24-ios into your Downloads folder.  From the former, copy the two files named bass.h and libbass.dylib into your SwiftBassDemo project folder. From the latter, copy the bass.xcframework folder into your SwiftBassDemo project folder.  (Remember to tell Xcode about these new files by using the File | Add Files to "SwiftBassDemo" command.)

Step 3:  
In Xcode's Project Navigator pane (typically on the far left of the Xcode window), select the SwiftBassDemo project at the top.  In the pane to the immediate right-hand side of the Project Navigator pane, select the SwiftBassDemo under TARGETS.  In the General section, there is a category labelled "Frameworks, Libraries, and Embedded Content”.  Confirm that the bass.xcframework and libbass.dylib items were added there (automatically done by Step 2 above.)  If not, add them.  For both items, in the Embed subcolumn, change the option from "Do Not Embed" to "Embed & Sign".  For the bass.xcframework item, in the Filters subcolumn change the "Always Used" to "iOS".  For the libbass.dylib item, in the Filters subcolumn, change the "Always Used" to "macOS".

Step 4:  
Create a text file named bridging-header.h with the following text:  
	#ifndef bridging_header_h  
	#define bridging_header_h  
	#include "bass.h"  
	#endif /* bridging_header_h */  
Place this file into your project folder.  (Remember to tell Xcode about this new file by using the File | Add Files to "SwiftBassDemo" command.)

The project folder in your Finder window should now look like:

	SwiftBassDemo (project folder)
		bass.h
		bass.xcframework (folder)
		bridging-header.h
		libbass.dylib
		SwiftBassDemo (app folder)
		SwiftBassDemo.xcodeproj

Step 5:  
In the SwiftBassDemo PROJECT | Build Settings | Swift Compiler - General,  set "Objective-C Bridging Header" to "bridging-header.h" in both the Debug and Release subheadings.

Step 6:  
In Xcode's Project Navigator pane (typically on the far left of the Xcode window), select the SwiftBassDemo project at the top.  In the pane to the immediate right-hand side of the Project Navigator pane, select the SwiftBassDemo under TARGETS.  In the Build Phases section, there is a category labelled "Embedded Frameworks”.  Within this category, confirm that both the bass.xcframework and libbass.dylib are named.  If not, add them.  In the Filters subcolumn, confirm that "Allow any platform" has been changed to "iOS" for the former item and to "macOS" for the latter item.  Confirm that the "Code Sign On Co..." box is checked for both items. 

Step 7:
Following the above steps will produce an app that works as desired.  However, if you want to distribute your app on Apple's App Store, you will need to remove the i386 32-bit code from the libbass.dylib file so that your app passes Apple's verification test.  To do this, use the Terminal app in your Applications | Utilities folder, change it's target directory (using the "cd" command) to your bass24-osx folder (from steps 1 and 2), and enter the command "make 64bit".  This creates a folder named "64bit" which contains a new libbass.dylib file.  Replace the file in your SwiftBassDemo project forlder with this new one.  In Xcode, run your SwiftBassDemo project again, and it should now pass Apple's verification test.

Step 8:  
To enable live microphone input, check the "Resource Access: Audio Input" box in the SwiftBassDemo TARGET, "Signing & Capabilites" heading, "All" subheading, "Hardened Runtime" section.  
Also, you must add a "Privacy - Microphone Usage Description" (such as "This app analyzes audio from the microphone."  Add this in the SwiftBassDemo TARGET, Info heading, "Custom Application Target Properties" section.
