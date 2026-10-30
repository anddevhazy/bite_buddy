# iPhone setup: Apple Health and the home-screen widget

Android needs none of this. On iPhone, two things can only be switched on in
Xcode, so do these once on your Mac. About 15 minutes.

You need: Xcode, and an Apple developer account signed in to Xcode
(Xcode → Settings → Accounts). App Groups and HealthKit don't work with a
free "Personal Team" on some accounts; if Xcode refuses, that's why.

## 1. Open the project

1. In Finder, go to `bite_buddy/frontend/ios/`.
2. Double-click **`Runner.xcworkspace`** (the white one, not `.xcodeproj`).

## 2. Turn on Apple Health for the app

1. In the left sidebar, click the blue **Runner** project at the top.
2. In the middle, under **TARGETS**, click **Runner**.
3. Click the **Signing & Capabilities** tab.
4. Click **+ Capability** (top left of that tab).
5. Type **HealthKit** and double-click it. Leave its tick boxes unticked.

## 3. Add the shared App Group (the widget reads the buddy from here)

Still on Runner's **Signing & Capabilities** tab:

1. Click **+ Capability**, type **App Groups**, double-click it.
2. In the new App Groups box, click **+**.
3. Type exactly: **`group.com.example.biteBuddy`** and press OK.
4. Make sure its tick box is ticked.

## 4. Create the widget

1. Menu bar: **File → New → Target…**
2. Pick **iOS** at the top, then **Widget Extension**, then **Next**.
3. Product Name: **`BuddyWidget`** (exactly).
4. **Untick** "Include Live Activity" and "Include Configuration App Intent".
5. Click **Finish**. If asked "Activate BuddyWidget scheme?", click
   **Don't Activate**.
6. Xcode made a folder **BuddyWidget** in the sidebar with its own Swift
   files. Delete the Swift files it made: select each `.swift` file inside
   that folder (e.g. `BuddyWidget.swift`, `BuddyWidgetBundle.swift`), press
   Delete, and choose **Move to Trash**. Keep `Assets.xcassets` and
   `Info.plist`.
7. Right-click the **BuddyWidget** folder → **Add Files to "Runner"…**,
   pick `ios/BuddyWidget/BuddyWidget.swift` (the one Claude wrote; it may
   already be in that folder on disk). In the dialog, under **Targets**,
   tick **BuddyWidget only**, untick Runner. Click **Add**.
8. Under **TARGETS**, click **BuddyWidget** → **General** tab → set
   **Minimum Deployments** to **17.0** (the widget's background needs iOS
   17; the app itself still runs on iOS 15 and up).
9. Still on the **BuddyWidget** target → **Signing & Capabilities** → **+
   Capability** → **App Groups** → tick **`group.com.example.biteBuddy`**
   (the same one as step 3).

## 5. Build and run

1. Close Xcode.
2. In Terminal:
   ```
   cd ~/dev/projects/flutter/bite_buddy/frontend
   fvm flutter run
   ```
3. Open the app once and go to **My Pet** (that saves your buddy for the
   widget).
4. On the iPhone home screen, long-press an empty spot → **+** (top left)
   → search **Bite Buddy** → add the widget.

## If something goes wrong

- **"Cycle inside Runner; building could produce unreliable results"**:
  Runner target → **Build Phases** → drag **Embed Foundation Extensions**
  up so it's directly under **Copy Bundle Resources**.
- **The widget says "Open the app to meet your buddy"**: the App Group
  name doesn't match in one of the three places (Runner, BuddyWidget, and
  `appGroupId` in `pet_widget_service.dart`). They must all be
  `group.com.example.biteBuddy`.
- **Apple Health never asks for permission**: check step 2 and that the
  phone isn't an iPad (iPads have no Apple Health).
