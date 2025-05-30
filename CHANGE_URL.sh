          #±äÁ¿Ãû http://www.baidu.com
		  #WINDOWS
		  sed -i -e 's|Homepage: https://rustdesk.com|Homepage: http://www.baidu.com|' ./build.py
          sed -i -e "s|launchUrl(Uri.parse('https://rustdesk.com'));|launchUrl(Uri.parse('http://www.baidu.com'));|" ./flutter/lib/common.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com');|launchUrlString('http://www.baidu.com');|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|const url = 'https://rustdesk.com/';|const url = 'http://www.baidu.com';|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|https://rustdesk.com/privacy.html|http://www.baidu.com/privacy.html|" ./flutter/lib/desktop/pages/install_page.dart
          sed -i -e "s|https://rustdesk.com/|http://www.baidu.com|" ./res/setup.nsi
		  #ANDROID
		  sed -i -e 's|Homepage: https://rustdesk.com|Homepage: http://www.baidu.com|' ./build.py
          sed -i -e "s|launchUrl(Uri.parse('https://rustdesk.com'));|launchUrl(Uri.parse('http://www.baidu.com'));|" ./flutter/lib/common.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com');|launchUrlString('http://www.baidu.com');|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|const url = 'https://rustdesk.com/';|const url = 'http://www.baidu.com';|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|child: Text('rustdesk.com',|child: Text('http://www.baidu.com',|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|https://rustdesk.com/privacy.html|http://www.baidu.com/privacy.html|" ./flutter/lib/desktop/pages/install_page.dart
		  #LINUX
		  sed -i -e 's|Homepage: https://rustdesk.com|Homepage: http://www.baidu.com|' ./build.py
          sed -i -e "s|launchUrl(Uri.parse('https://rustdesk.com'));|launchUrl(Uri.parse('http://www.baidu.com'));|" ./flutter/lib/common.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com');|launchUrlString('http://www.baidu.com');|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|const url = 'https://rustdesk.com/';|const url = 'http://www.baidu.com';|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|https://rustdesk.com/privacy.html|http://www.baidu.com/privacy.html|" ./flutter/lib/desktop/pages/install_page.dart
		  #MACOS
		  sed -i -e 's|https://rustdesk.com|http://www.baidu.com|' ./build.py
          sed -i -e "s|launchUrl(Uri.parse('https://rustdesk.com'));|launchUrl(Uri.parse('http://www.baidu.com'));|" ./flutter/lib/common.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com');|launchUrlString('http://www.baidu.com');|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/desktop/pages/desktop_setting_page.dart
          sed -i -e "s|const url = 'https://rustdesk.com/';|const url = 'http://www.baidu.com';|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|launchUrlString('https://rustdesk.com/privacy.html')|launchUrlString('http://www.baidu.com/privacy.html')|" ./flutter/lib/mobile/pages/settings_page.dart
          sed -i -e "s|https://rustdesk.com/privacy.html|http://www.baidu.com/privacy.html|" ./flutter/lib/desktop/pages/install_page.dart