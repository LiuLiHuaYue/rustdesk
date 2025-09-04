          #±äÁ¿Ãû {{NEW_APP_NAME}}
		  #WINDOWS
          magick ./res/icon.png -define icon:auto-resize=256,64,48,32,16 ./res/icon.ico
          cp ./res/icon.ico ./res/tray-icon.ico
          magick ./res/icon.png -resize 32x32 ./res/32x32.png
          magick ./res/icon.png -resize 64x64 ./res/64x64.png
          magick ./res/icon.png -resize 128x128 ./res/128x128.png
          magick ./res/128x128.png -resize 200% ./res/128x128@2x.png
		  #ANDROID
		  magick ./res/icon.png -define icon:auto-resize=256,64,48,32,16 ./res/icon.ico
          magick ./res/icon.png -define icon:auto-resize=256,64,48,32,16 ./res/tray-icon.ico
          cp ./res/icon.ico ./res/tray-icon.ico
          magick ./res/icon.png -resize 32x32 ./res/32x32.png
          magick ./res/icon.png -resize 64x64 ./res/64x64.png
          magick ./res/icon.png -resize 128x128 ./res/128x128.png
          magick ./res/128x128.png -resize 200% ./res/128x128@2x.png
          sed -i '/android: true/a \ \ adaptive_icon_background: "#ffffff"' ./flutter/pubspec.yaml
          sed -i '/adaptive_icon_background/a \ \ adaptive_icon_foreground: "../res/icon.png"' ./flutter/pubspec.yaml
          sed -i '/adaptive_icon_foreground:/a \ \ adaptive_icon_foreground_inset: 32' ./flutter/pubspec.yaml
          sed -i '/ic_launcher_background/d' ./flutter/android/app/src/main/res/values/colors.xml
		  magick ./res/icon.png ./flutter/assets/icon.svg
          magick ./res/128x128.png -resize 200% ./flutter/assets/128x128@2x.png || true
          cp ./flutter/assets/icon.svg ./res/scalable.svg
		  #LINUX
		  magick ./res/icon.png -define icon:auto-resize=256,64,48,32,16 ./res/icon.ico
          magick ./res/icon.png -define icon:auto-resize=256,64,48,32,16 ./res/tray-icon.ico
          cp ./res/icon.ico ./res/tray-icon.ico
          magick ./res/icon.png -resize 32x32 ./res/32x32.png
          magick ./res/icon.png -resize 64x64 ./res/64x64.png
          magick ./res/icon.png -resize 128x128 ./res/128x128.png
          magick ./res/128x128.png -resize 200% ./res/128x128@2x.png
		  magick ./res/icon.png ./flutter/assets/icon.svg
		  magick ./res/128x128.png -resize 200% ./flutter/assets/128x128@2x.png || true
          cp ./flutter/assets/icon.svg ./res/scalable.svg
		  #MACOS
		  mkdir -p ./res
          mkdir -p ./flutter/assets
          mkdir -p ./flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset
          mkdir -p ./macos/Runner/Assets.xcassets/AppIcon.appiconset
          mkdir -p ./rustdesk/data/flutter_assets/assets
		  magick ./res/icon.png -resize 32x32 ./res/32x32.png
          magick ./res/icon.png -resize 64x64 ./res/64x64.png
          magick ./res/icon.png -resize 128x128 ./res/128x128.png
		  cp ./res/icon.png ./flutter/assets/icon.png
          cp ./res/icon.png ./rustdesk/data/flutter_assets/assets/icon.png
		  magick ./res/icon.png -flatten ./temp_icon.pbm
          potrace --svg -o ./flutter/assets/icon.svg ./temp_icon.pbm
          cp ./flutter/assets/icon.svg ./rustdesk/data/flutter_assets/assets/icon.svg
          rm ./temp_icon.pbm
		  magick ./res/icon.png -resize 16x16 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png"
          magick ./res/icon.png -resize 32x32 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png"
          magick ./res/icon.png -resize 64x64 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png"
          magick ./res/icon.png -resize 128x128 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png"
          magick ./res/icon.png -resize 256x256 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png"
          magick ./res/icon.png -resize 512x512 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png"
          magick ./res/icon.png -resize 1024x1024 "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png"
		  magick ./res/icon.png -resize 128x128 ./res/mac-icon.png
          magick ./res/icon.png -resize 22x22 -colorspace gray -alpha set -background none -channel A -evaluate set 100% ./res/mac-tray-dark-x2.png
          magick ./res/icon.png -resize 22x22 -negate -colorspace gray -alpha set -background none -channel A -evaluate set 100% ./res/mac-tray-light-x2.png
          mkdir -p ./iconset.iconset
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png" "./iconset.iconset/icon_16x16.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png" "./iconset.iconset/icon_16x16@2x.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png" "./iconset.iconset/icon_32x32.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png" "./iconset.iconset/icon_32x32@2x.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png" "./iconset.iconset/icon_128x128.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png" "./iconset.iconset/icon_128x128@2x.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png" "./iconset.iconset/icon_256x256.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png" "./iconset.iconset/icon_256x256@2x.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png" "./iconset.iconset/icon_512x512.png"
          cp "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png" "./iconset.iconset/icon_512x512@2x.png"
          npx icon-gen --input ./flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png --output ./flutter/macos/Runner --icns
          rm -rf ./iconset.iconset
		  echo '{
            "images": [
              {"size":"16x16","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_16.png","scale":"1x"},
              {"size":"16x16","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_32.png","scale":"2x"},
              {"size":"32x32","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_32.png","scale":"1x"},
              {"size":"32x32","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_64.png","scale":"2x"},
              {"size":"128x128","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_128.png","scale":"1x"},
              {"size":"128x128","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_256.png","scale":"2x"},
              {"size":"256x256","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_256.png","scale":"1x"},
              {"size":"256x256","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_512.png","scale":"2x"},
              {"size":"512x512","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_512.png","scale":"1x"},
              {"size":"512x512","idiom":"mac","{{NEW_APP_NAME}}":"app_icon_1024.png","scale":"2x"}
            ],
            "info": {
              "version": 1,
              "author": "xcode"
            }
          }' > "flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json"
		  cp -r flutter/macos/Runner/Assets.xcassets/AppIcon.appiconset/* macos/Runner/Assets.xcassets/AppIcon.appiconset/