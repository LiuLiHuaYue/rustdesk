          #±äÁ¿Ãû HyDeskPro
		  #WINDOWS
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "HyDeskPro" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|HyDeskPro|' {} \;
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
		  sed -i -e "s|translate('About RustDesk')|translate('About HyDeskPro')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
		  #ANDROID
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./Cargo.toml
          sed -i 's|name = "RustDesk"|name = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./libs/portable/Cargo.toml
          sed -i -e 's|"RustDesk Remote Desktop"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|VALUE "InternalName", "rustdesk" "\0"|VALUE "InternalName", "HyDeskPro" "\0"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"Copyright ? 2025 Purslane Ltd. All rights reserved."|"Copyright ? 2025"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"rustdesk.exe"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|"RustDesk"|"HyDeskPro"|' ./flutter/windows/runner/Runner.rc
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|HyDeskPro|' {} \;
          sed -i -e 's|RustDesk|HyDeskPro|' ./flutter/android/app/src/main/res/values/strings.xml
          sed -i -e "s|title: 'RustDesk'|title: 'HyDeskPro'|" ./flutter/lib/main.dart
          sed -i -e "s|return 'RustDesk';|return 'HyDeskPro';|" ./flutter/lib/web/bridge.dart
          sed -i 's|android:label="RustDesk"|android:label="HyDeskPro"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|android:label="RustDesk Input"|android:label="HyDeskPro Input"|' ./flutter/android/app/src/main/AndroidManifest.xml
          sed -i 's|RustDesk is Open|HyDeskPro is Open|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/BootReceiver.kt
          sed -i 's|Show Rustdesk|Show HyDeskPro|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/FloatingWindowService.kt
          sed -i 's|"RustDesk"|"HyDeskPro"|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|"RustDesk Service|"HyDeskPro Service|' ./flutter/android/app/src/main/kotlin/com/carriez/flutter_hbb/MainService.kt
          sed -i 's|RustDesk|HyDeskPro|' ./flutter/lib/main.dart
          sed -i 's|"RustDesk"|"HyDeskPro"|' ./flutter/lib/desktop/widgets/tabbar_widget.dart
          sed -i 's|"RustDesk"|"HyDeskPro"|' ./libs/hbb_common/src/config.rs
		  sed -i -e "s|title: Text(translate('About RustDesk')),|title: Text(translate('About HyDeskPro')),|" ./flutter/lib/mobile/pages/settings_page.dart
		  sed -i -e "s|return Text(bind.mainGetAppNameSync());|return Text('HyDeskPro');|" ./flutter/lib/mobile/pages/home_page.dart
		  #LINUX
		  sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./Cargo.toml
          sed -i -e 's|description = "RustDesk Remote Desktop"|description = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|ProductName = "RustDesk"|ProductName = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|FileDescription = "RustDesk Remote Desktop"|FileDescription = "HyDeskPro"|' ./libs/portable/Cargo.toml
          sed -i -e 's|OriginalFilename = "rustdesk.exe"|OriginalFilename = "HyDeskPro.exe"|' ./libs/portable/Cargo.toml
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|HyDeskPro|' {} \;
          sed -i -e '/-p tmpdeb\/usr\/lib\/rustdesk/d' ./build.py
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf HyDeskPro.deb|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|- bsdtar -zxvf rustdesk.deb|- bsdtar -zxvf HyDeskPro.deb|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|id: rustdesk|id: HyDeskPro|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|name: rustdesk|name: HyDeskPro|' ./appimage/AppImageBuilder-x86_64.yml
		  sed -i -e 's|id: rustdesk|id: HyDeskPro|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|name: rustdesk|name: HyDeskPro|' ./appimage/AppImageBuilder-aarch64.yml
		  sed -i -e 's|<id>com.rustdesk.RustDesk</id>|<id>com.HyDeskPro.HyDeskPro</id>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<developer id="com.rustdesk">|<developer id="com.HyDeskPro">|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<name>RustDesk</name>|<name>HyDeskPro</name>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|<launchable type="desktop-id">com.rustdesk.RustDesk.desktop</launchable>|<launchable type="desktop-id">com.HyDeskPro.HyDeskPro.desktop</launchable>|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's|RustDesk is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|HyDeskPro is a full-featured open source remote control alternative for self-hosting and security with minimal configuration.|' ./flatpak/com.rustdesk.RustDesk.metainfo.xml
		  sed -i -e 's#"bsdtar -Oxf rustdesk.deb data.tar.xz | bsdtar -xf -"#"bsdtar -Oxf HyDeskPro.deb data.tar.xz | bsdtar -xf -"#' ./flatpak/rustdesk.json
		  sed -i -e 's|"path": "rustdesk.deb"|"path": "HyDeskPro.deb"|' ./flatpak/rustdesk.json
		  #MACOS
          sed -i -e 's|<key>CFBundleName</key>.*<string>.*</string>|<key>CFBundleName</key>\n\t<string>HyDeskPro</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleDisplayName</key>.*<string>.*</string>|<key>CFBundleDisplayName</key>\n\t<string>HyDeskPro</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|<key>CFBundleIdentifier</key>.*<string>.*</string>|<key>CFBundleIdentifier</key>\n\t<string>com.HyDeskPro.app</string>|' ./flutter/macos/Runner/Info.plist
          sed -i -e 's|PRODUCT_NAME = .*|PRODUCT_NAME = HyDeskPro|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|PRODUCT_BUNDLE_IDENTIFIER = .*|PRODUCT_BUNDLE_IDENTIFIER = com.HyDeskPro.app|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|HyDeskPro|' ./flutter/macos/Runner/Configs/AppInfo.xcconfig
          sed -i -e 's|Purslane Ltd.|HyDeskPro|' ./Cargo.toml
          sed -i -e 's|Purslane Ltd|HyDeskPro|' ./libs/portable/Cargo.toml
          sed -i -e 's/PRODUCT_NAME = "RustDesk"/PRODUCT_NAME = "HyDeskPro"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          sed -i -e 's/PRODUCT_BUNDLE_IDENTIFIER = ".*"/PRODUCT_BUNDLE_IDENTIFIER = "com.HyDeskPro.app"/' ./flutter/macos/Runner.xcodeproj/project.pbxproj
          if [ -f "./flutter/macos/CMakeLists.txt" ]; then
            sed -i -e 's/set(BINARY_NAME ".*")/set(BINARY_NAME "HyDeskPro")/' ./flutter/macos/CMakeLists.txt
          fi
          sed -i -e 's/target '"'"'Runner'"'"' do/target '"'"'Runner'"'"' do/' ./flutter/macos/Podfile
          find ./src/lang -name "*.rs" -exec sed -i -e 's|RustDesk|HyDeskPro|' {} \;
          sed -i -e 's|RustDesk|HyDeskPro|' ./src/lang/nl.rs
          sed -i -e 's/("Slogan_tip", "Made with heart in this chaotic world!")/("Slogan_tip", "Powered by HyDeskPro")/' ./src/lang/en.rs
          sed -i -e 's/("About RustDesk", "")/("About RustDesk", "About HyDeskPro")/' ./src/lang/en.rs
          sed -i -e 's/("Slogan_tip", "Ontwikkeld met het hart voor deze chaotische wereld!")/("Slogan_tip", "Powered by HyDeskPro")/' ./src/lang/nl.rs
          sed -i -e 's/("Your Desktop", "Uw Bureaublad")/("Your Desktop", "Uw HyDeskPro")/' ./src/lang/nl.rs
          sed -i -e 's/("About RustDesk", "Over RustDesk")/("About RustDesk", "Over HyDeskPro")/' ./src/lang/nl.rs
          sed -i -e 's/("About", "Over")/("About", "Over HyDeskPro")/' ./src/lang/nl.rs