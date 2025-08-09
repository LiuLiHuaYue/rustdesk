		  #变量名 LiuLiHuaYue
          #WINDOWS
		  sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e 's|Purslane Ltd.|LiuLiHuaYue|' ./res/setup.nsi
          sed -i -e 's|PURSLANE|LiuLiHuaYue|' ./res/msi/preprocess.py
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./res/msi/preprocess.py
          sed -i -e 's|"Copyright © 2025 Purslane Ltd. All rights reserved."|"Copyright © 2025 LiuLiHuaYue. All rights reserved."|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./flutter/windows/runner/Runner.rc
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./Cargo.toml
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./libs/portable/Cargo.toml
		  #ANDROID
		  #LINUX
		  sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./Cargo.toml
          sed -i -e 's|Purslane Ltd|LiuLiHuaYue|' ./libs/portable/Cargo.toml
		  #MACOS