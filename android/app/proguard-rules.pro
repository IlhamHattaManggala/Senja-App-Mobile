# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# ML Kit
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Facebook Login
-keep class com.facebook.** { *; }
-dontwarn com.facebook.**
    
# Needed for Firebase Cloud Messaging
-keep class com.google.firebase.messaging.FirebaseMessagingService { *; }
-keep class com.google.firebase.iid.FirebaseInstanceIdReceiver { *; }
-keep class com.google.firebase.iid.FirebaseInstanceIdService { *; }

# Optional but safe fallback
-keepattributes Signature
-keepattributes *Annotation*

# TensorFlow Lite - Keep GPU delegate and related classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**