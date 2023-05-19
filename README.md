# kurux_frontend_prototype
Flutter Application for KuruX's Frontend

The App is created using - flutter create . 

# Installation Instructions

apart from flutter/dart sdk , the application also uses http module

install http module using - dart pub add http ( This will also add the dependency in the project yaml file )

# How to run

Also , flutter web app doesn't support non CORS API calls ( actually modern browsers dont support this )

instead of running the app using this - flutter run -d chrome
Run the app by disabling web safety - flutter run -d chrome --web-browser-flag "--disable-web-security"

# Edit
Backend now supports cors ,  so flutter run will work now

# Deployment into vercel 
The following configurations needed to be made when deploying to vercel

Build command: flutter/bin/flutter build web --release
Output directory: build/web
Install command: if cd flutter; then git pull && cd .. ; else git clone https://github.com/flutter/flutter.git; fi && ls && flutter/bin/flutter doctor && flutter/bin/flutter clean && flutter/bin/flutter config --enable-web

