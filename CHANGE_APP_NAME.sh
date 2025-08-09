          #±äÁ¿Ãû LiuLiHuaYue
		  #WINDOWS
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "LiuLiHuaYue" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|LiuLiHuaYue|' {} \;
		  sed -i -e 's|reg add {}|reg add \\\"{}\\\"|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\.{ext} /f|reg add \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\.{ext}\\\\DefaultIcon /f|reg add \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\\DefaultIcon\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell /f|reg add \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell\\\\open /f|reg add \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell\\\\open\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell\\\\open\\\\command|reg add \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\\shell\\\\open\\\\command\\\"|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\{ext} /f|reg add \\\"HKEY_CLASSES_ROOT\\\\{ext}\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\{ext}\\\\shell /f|reg add \\\"HKEY_CLASSES_ROOT\\\\{ext}\\\\shell\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\{ext}\\\\shell\\\\open /f|reg add \\\"HKEY_CLASSES_ROOT\\\\{ext}\\\\shell\\\\open\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg add HKEY_CLASSES_ROOT\\\\{ext}\\\\shell\\\\open\\\\command /f|reg add \\\"HKEY_CLASSES_ROOT\\\\{ext}\\\\shell\\\\open\\\\command\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|{subkey}|\\\"{subkey}\\\"|' ./src/platform/windows.rs
          sed -i -e 's|reg delete HKEY_CLASSES_ROOT\\\\.{ext} /f|reg delete \\\"HKEY_CLASSES_ROOT\\\\.{ext}\\\" /f|' ./src/platform/windows.rs
          sed -i -e 's|reg delete HKEY_CLASSES_ROOT\\\\{ext} /f|reg delete \\\"HKEY_CLASSES_ROOT\\\\{ext}\\\" /f|' ./src/platform/windows.rs
		  sed -i -e "s|translate('About RustDesk')|translate('About LiuLiHuaYue')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
		  #ANDROID
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./Cargo.toml
          sed -i 's|name = "RustDesk"|name = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "LiuLiHuaYue" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"Copyright ? 2025 Purslane Ltd. All rights reserved."|"Copyright ? 2025"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"LiuLiHuaYue"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|LiuLiHuaYue|' {} \;
          sed -i -e 's|RustDesk|LiuLiHuaYue|' ./flutter/android/app/src/main/res/values/strings.xml
          sed -i -e "s|title: 'RustDesk'|title: 'LiuLiHuaYue'|" ./flutter/lib/main.dart
          sed -i -e "s|return 'RustDesk';|return 'LiuLiHuaYue';|" ./flutter/lib/web/bridge.dart
          sed -i 's|android:label="RustDesk"|android:label="LiuLiHuaYue"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|android:label="RustDesk Input"|android:label="LiuLiHuaYue Input"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|RustDesk is Open|LiuLiHuaYue is Open|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/BootReceiver.kt
          sed -i 's|Show Rustdesk|Show LiuLiHuaYue|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/FloatingWindowService.kt
          sed -i 's|"RustDesk"|"LiuLiHuaYue"|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|"RustDesk Service|"LiuLiHuaYue Service|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|RustDesk|LiuLiHuaYue|' ./flutter/lib/main.dart
          sed -i 's|"RustDesk"|"LiuLiHuaYue"|' ./flutter/lib/desktop/widgets/tabbar_widget.dart
          sed -i 's|"RustDesk"|"LiuLiHuaYue"|' ./libs/hbb_common/src/config.rs
		  sed -i -e "s|title: Text(translate('About RustDesk')),|title: Text(translate('About LiuLiHuaYue')),|" ./flutter/lib/mobile/pages/settings_page.dart
		  sed -i -e "s|return Text(bind.mainGetAppNameSync());|return Text('LiuLiHuaYue');|" ./flutter/lib/mobile/pages/home_page.dart
		  #LINUX
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "LiuLiHuaYue"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "LiuLiHuaYue.exe"|' ./libs/portable/Cargo.toml
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|LiuLiHuaYue|' {} \;
          sed -i -e '/-p tmpdeb\/usr\/lib\/rustdesk/d' ./build.py
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf LiuLiHuaYue.deb|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf LiuLiHuaYue.deb|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|id: rustdesk|id: LiuLiHuaYue|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|name: rustdesk|name: LiuLiHuaYue|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|id: rustdesk|id: LiuLiHuaYue|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|name: rustdesk|name: LiuLiHuaYue|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|<id>com.rustdesk.RustDesk</id>|<id>com.LiuLiHuaYue.LiuLiHuaYue</id>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<developer id="com.rustdesk">|<developer id="com.LiuLiHuaYue">|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<name>RustDesk</name>|<name>LiuLiHuaYue</name>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<launchable type="desktop-id">com.rustdesk.RustDesk.desktop</launchable>|<launchable type="desktop-id">com.LiuLiHuaYue.LiuLiHuaYue.desktop</launchable>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|RustDesk is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|LiuLiHuaYue is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's#"bsdtar -Oxf rustdesk.deb data.tar.xz | bsdtar -xf -"#"bsdtar -Oxf LiuLiHuaYue.deb data.tar.xz | bsdtar -xf -"#' ./flatpak/rustdesk.json
		  sed -i -e 's|"path": "rustdesk.deb"|"path": "LiuLiHuaYue.deb"|' ./flatpak/rustdesk.json
		  #MACOS
          sed -i -e 's|<key>CFBundleName</key>.*<string>.*</string>|<key>CFBundleName</key>\n\t<string>LiuLiHuaYue</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleDisplayName</key>.*<string>.*</string>|<key>CFBundleDisplayName</key>\n\t<string>LiuLiHuaYue</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleIdentifier</key>.*<string>.*</string>|<key>CFBundleIdentifier</key>\n\t<string>com.LiuLiHuaYue.app</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|PRODUCT_NAME = .*|PRODUCT_NAME = LiuLiHuaYue|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|PRODUCT_BUNDLE_IDENTIFIER = .*|PRODUCT_BUNDLE_IDENTIFIER = com.LiuLiHuaYue.app|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|LiuLiHuaYue|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|LiuLiHuaYue|' ./Cargo.toml
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./libs/portable/Cargo.toml
          sed -i -e 's/PRODUCT_NAME = "RustDesk"/PRODUCT_NAME = "LiuLiHuaYue"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          sed -i -e 's/PRODUCT_BUNDLE_IDENTIFIER = ".*"/PRODUCT_BUNDLE_IDENTIFIER = "com.LiuLiHuaYue.app"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          if [ -f "./flutter/macos/CMakeLists.txt" ]; then
            sed -i -e 's/set(BINARY_NAME ".*")/set(BINARY_NAME "LiuLiHuaYue")/' ./flutter/macos/CMakeLists.txt
          fi
          sed -i -e 's/target '"'"'Runner'"'"' do/target '"'"'Runner'"'"' do/' ./flutter/macos/Podfile
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|LiuLiHuaYue|' {} \;
          sed -i -e 's|RustDesk|LiuLiHuaYue|' ./src/lang/nl.rs
          sed -i -e 's/("Slogan_tip", "Made with heart in this chaotic world!")/("Slogan_tip", "Powered by LiuLiHuaYue")/' ./src/lang/en.rs
          sed -i -e 's/("About RustDesk", "")/("About RustDesk", "About LiuLiHuaYue")/' ./src/lang/en.rs
          sed -i -e 's/("Slogan_tip", "Ontwikkeld met het hart voor deze chaotische wereld!")/("Slogan_tip", "Powered by LiuLiHuaYue")/' ./src/lang/nl.rs
          sed -i -e 's/("Your Desktop", "Uw Bureaublad")/("Your Desktop", "Uw LiuLiHuaYue")/' ./src/lang/nl.rs
          sed -i -e 's/("About RustDesk", "Over RustDesk")/("About RustDesk", "Over LiuLiHuaYue")/' ./src/lang/nl.rs
          sed -i -e 's/("About", "Over")/("About", "Over LiuLiHuaYue")/' ./src/lang/nl.rs