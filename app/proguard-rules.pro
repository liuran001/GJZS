# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in F:\Android\sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-keepclassmembers class * implements java.io.Serializable{*;}

-keep class com.omarea.krscript.model.**{*;}

# 方法名等混淆指定配置
-obfuscationdictionary proguard-dic.txt
# 类名混淆指定配置
-classobfuscationdictionary proguard-dic.txt
# 包名混淆指定配置
-packageobfuscationdictionary proguard-dic.txt
