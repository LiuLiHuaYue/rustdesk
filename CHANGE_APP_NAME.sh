          #±äÁ¿Ãû MAOTAI
		  #WINDOWS
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "MAOTAI" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|MAOTAI|' {} \;
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
		  sed -i -e "s|translate('About RustDesk')|translate('About MAOTAI')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
		  #ANDROID
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./Cargo.toml
          sed -i 's|name = "RustDesk"|name = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "MAOTAI" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"Copyright ? 2025 Purslane Ltd. All rights reserved."|"Copyright ? 2025"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"MAOTAI"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|MAOTAI|' {} \;
          sed -i -e 's|RustDesk|MAOTAI|' ./flutter/android/app/src/main/res/values/strings.xml
          sed -i -e "s|title: 'RustDesk'|title: 'MAOTAI'|" ./flutter/lib/main.dart
          sed -i -e "s|return 'RustDesk';|return 'MAOTAI';|" ./flutter/lib/web/bridge.dart
          sed -i 's|android:label="RustDesk"|android:label="MAOTAI"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|android:label="RustDesk Input"|android:label="MAOTAI Input"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|RustDesk is Open|MAOTAI is Open|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/BootReceiver.kt
          sed -i 's|Show Rustdesk|Show MAOTAI|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/FloatingWindowService.kt
          sed -i 's|"RustDesk"|"MAOTAI"|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|"RustDesk Service|"MAOTAI Service|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|RustDesk|MAOTAI|' ./flutter/lib/main.dart
          sed -i 's|"RustDesk"|"MAOTAI"|' ./flutter/lib/desktop/widgets/tabbar_widget.dart
          sed -i 's|"RustDesk"|"MAOTAI"|' ./libs/hbb_common/src/config.rs
		  sed -i -e "s|title: Text(translate('About RustDesk')),|title: Text(translate('About MAOTAI')),|" ./flutter/lib/mobile/pages/settings_page.dart
		  sed -i -e "s|return Text(bind.mainGetAppNameSync());|return Text('MAOTAI');|" ./flutter/lib/mobile/pages/home_page.dart
		  #LINUX
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "MAOTAI"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "MAOTAI.exe"|' ./libs/portable/Cargo.toml
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|MAOTAI|' {} \;
          sed -i -e '/-p tmpdeb\/usr\/lib\/rustdesk/d' ./build.py
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf MAOTAI.deb|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf MAOTAI.deb|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|id: rustdesk|id: MAOTAI|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|name: rustdesk|name: MAOTAI|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|id: rustdesk|id: MAOTAI|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|name: rustdesk|name: MAOTAI|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|<id>com.rustdesk.RustDesk</id>|<id>com.MAOTAI.MAOTAI</id>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<developer id="com.rustdesk">|<developer id="com.MAOTAI">|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<name>RustDesk</name>|<name>MAOTAI</name>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<launchable type="desktop-id">com.rustdesk.RustDesk.desktop</launchable>|<launchable type="desktop-id">com.MAOTAI.MAOTAI.desktop</launchable>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|RustDesk is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|MAOTAI is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's#"bsdtar -Oxf rustdesk.deb data.tar.xz | bsdtar -xf -"#"bsdtar -Oxf MAOTAI.deb data.tar.xz | bsdtar -xf -"#' ./flatpak/rustdesk.json
		  sed -i -e 's|"path": "rustdesk.deb"|"path": "MAOTAI.deb"|' ./flatpak/rustdesk.json
		  #MACOS
          sed -i -e 's|<key>CFBundleName</key>.*<string>.*</string>|<key>CFBundleName</key>\n\t<string>MAOTAI</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleDisplayName</key>.*<string>.*</string>|<key>CFBundleDisplayName</key>\n\t<string>MAOTAI</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleIdentifier</key>.*<string>.*</string>|<key>CFBundleIdentifier</key>\n\t<string>com.MAOTAI.app</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|PRODUCT_NAME = .*|PRODUCT_NAME = MAOTAI|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|PRODUCT_BUNDLE_IDENTIFIER = .*|PRODUCT_BUNDLE_IDENTIFIER = com.MAOTAI.app|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|MAOTAI|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|MAOTAI|' ./Cargo.toml
          sed -i -e 's|Purslane Ltd|MAOTAI|' ./libs/portable/Cargo.toml
          sed -i -e 's/PRODUCT_NAME = "RustDesk"/PRODUCT_NAME = "MAOTAI"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          sed -i -e 's/PRODUCT_BUNDLE_IDENTIFIER = ".*"/PRODUCT_BUNDLE_IDENTIFIER = "com.MAOTAI.app"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          if [ -f "./flutter/macos/CMakeLists.txt" ]; then
            sed -i -e 's/set(BINARY_NAME ".*")/set(BINARY_NAME "MAOTAI")/' ./flutter/macos/CMakeLists.txt
          fi
          sed -i -e 's/target '"'"'Runner'"'"' do/target '"'"'Runner'"'"' do/' ./flutter/macos/Podfile
          cp ./src/lang/en.rs ./src/lang/en.rs.bak
          cp ./src/lang/nl.rs ./src/lang/nl.rs.bak
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|MAOTAI|' {} \;
          sed -i -e 's|RustDesk|MAOTAI|' ./src/lang/nl.rs
          sed -i -e 's/("Slogan_tip", "Made with heart in this chaotic world!")/("Slogan_tip", "Powered by MAOTAI")/' ./src/lang/en.rs
          sed -i -e 's/("About RustDesk", "")/("About RustDesk", "About MAOTAI")/' ./src/lang/en.rs
          sed -i -e 's/("Slogan_tip", "Ontwikkeld met het hart voor deze chaotische wereld!")/("Slogan_tip", "Powered by MAOTAI")/' ./src/lang/nl.rs
          sed -i -e 's/("Your Desktop", "Uw Bureaublad")/("Your Desktop", "Uw MAOTAI")/' ./src/lang/nl.rs
          sed -i -e 's/("About RustDesk", "Over RustDesk")/("About RustDesk", "Over MAOTAI")/' ./src/lang/nl.rs
          sed -i -e 's/("About", "Over")/("About", "Over MAOTAI")/' ./src/lang/nl.rs