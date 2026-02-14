# ⚠️ Google Maps API Key Setup Required

The error logs indicate that your Google Maps API Key is correct, but it is **not authorized** to run on this app.

## 1. The Error
The log says:
> `Authorization failure.`
> `Ensure that the "Maps SDK for Android" is enabled.`
> `Ensure that the following Android Key exists:`
> `Android Application (<cert_fingerprint>;<package_name>):`
> `EE:6D:44:7F:A9:81:1C:D6:E0:09:FD:6E:D6:CB:C3:D8:CC:DB:64:98;com.example.go_roqit_app`

## 2. How to Fix (Step-by-Step)

1.  Go to the **[Google Cloud Console](https://console.cloud.google.com/apis/credentials)**.
2.  Select your Project.
3.  Find the API Key: **`AIzaSyDvuwAjadUqjxuBqNbTnZ5WhZ3HrD3ODGk`**.
4.  Click **Edit** (pencil icon).
5.  Scroll down to **API restrictions**.
    *   Ensure **"Maps SDK for Android"** is checked/selected in the dropdown list.
    *   *(If you don't see it, go to "Library" on the left menu, search for "Maps SDK for Android" and click ENABLE first)*.
6.  Scroll to **Application restrictions**.
    *   Select **Android apps**.
    *   Click **Add an item**.
    *   **Package name**: `com.example.go_roqit_app`
    *   **SHA-1 certificate fingerprint**: 
        ```
        EE:6D:44:7F:A9:81:1C:D6:E0:09:FD:6E:D6:CB:C3:D8:CC:DB:64:98
        ```
    *   *(Copy and paste the SHA-1 exactly as shown above)*.
7.  Click **Save**.

## 3. Restart
After saving, it may take up to 5 minutes to take effect.
Stop the app completely and run it again. The map should appear.
