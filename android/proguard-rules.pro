# Keep Lottie Compose classes
-keep class com.airbnb.lottie.compose.** { *; }
-dontwarn com.airbnb.lottie.compose.**

# Keep all Lottie classes 
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

# Keep Incode Welcome SDK classes
-keep class com.incode.welcome_sdk.** { *; }
-dontwarn com.incode.welcome_sdk.**

# Keep Compose classes
-keep class androidx.compose.** { *; }
-dontwarn androidx.compose.**

# Keep Kotlin classes
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Keep Firebase (if you use Firebase in this project)
-keep class com.google.firebase.** { *; }
-keep interface com.google.firebase.** { *; }

# Keep Retrofit and OkHttp if used
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }
-dontwarn retrofit2.**
-dontwarn okhttp3.**

# Keep Gson if used
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep all enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Missing rules from R8 output
-dontwarn com.airbnb.lottie.compose.AnimateLottieCompositionAsStateKt
-dontwarn com.airbnb.lottie.compose.LottieAnimationKt
-dontwarn com.airbnb.lottie.compose.LottieAnimationState
-dontwarn com.airbnb.lottie.compose.LottieCancellationBehavior
-dontwarn com.airbnb.lottie.compose.LottieClipSpec
-dontwarn com.airbnb.lottie.compose.LottieCompositionResult
-dontwarn com.airbnb.lottie.compose.LottieCompositionSpec$RawRes
-dontwarn com.airbnb.lottie.compose.LottieCompositionSpec
-dontwarn com.airbnb.lottie.compose.LottieDynamicProperties
-dontwarn com.airbnb.lottie.compose.RememberLottieCompositionKt
