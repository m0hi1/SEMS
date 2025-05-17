# Keep the Keep and KeepClassMembers annotations
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers