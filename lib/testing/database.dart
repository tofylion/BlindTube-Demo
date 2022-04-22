//All the database in a human-readable format.

import 'package:blindtube/structure/creator.dart';
import 'package:blindtube/structure/server.dart';

class Database {
  static late Creator user;

  static void initialiseUser(String name) {
    user = Creator(id: -1, name: name);
  }

  static void populateDatabase() {
    //Adding all creators to the database and saving the id of each one
    int apple = Server.addCreator(
      name: 'Apple',
      picPath: 'assets/images/apple.jpg',
      subscribers: 15700000,
    );

    int meraba3a = Server.addCreator(
      name: 'شايفنها مربعة',
      picPath: 'assets/images/shayfenha_meraba3a.jpg',
      subscribers: 2010,
    );
    int openai = Server.addCreator(
      name: 'OpenAI',
      subscribers: 194000,
      picPath: 'assets/images/openai.jpg',
    );
    int fireship = Server.addCreator(
      name: 'Fireship',
      subscribers: 1260000,
      picPath: 'assets/images/fireship.jpg',
    );

    //Adding all the videos and their info to the database
    Server.uploadVideo(
      title: 'VS Code in 100 Seconds',
      videoPath: 'assets/videos/vs-code-100-seconds.mp4',
      publishDateTime: DateTime.parse('2021-11-26'),
      length: const Duration(minutes: 2, seconds: 33),
      picPath: 'assets/images/vs code 100 seconds.jpg',
      description:
          """Visual Studio Code is an open-source lightweight code editor maintained by Microsoft. Get the full VS Code Magic Tricks course to write better code faster https://fireship.io/courses/vscode-tr...

🔥 Black Friday - Upgrade to PRO 🔥

Discount 33.330000000000003%
Free Sticker
Free T-Shirt (lifetime members)

Use code: 1LDSQD4q
👉 https://fireship.io/pro

#learntocode #vscode #100SecondsOfCode

🔗 Resources

Open VS Code now https://vscode.dev
VS Code Docs https://code.visualstudio.com/docs
Also checkout VIM https://youtu.be/-txKSRn0qeA

🎨 My Editor Settings

- Atom One Dark 
- vscode-icons
- Fira Code Font

🔖 Topics Covered

- What is VS Code?
- VS Code tour
- VS Code as IDE
- Best code editor for beginners""",
      views: 515158,
      creator: fireship,
      likes: 28000,
      tags: {'vscode', 'programming', 'educational', 'technology'},
    );

    Server.uploadVideo(
      title: 'The whole working-from-home thing — Apple',
      videoPath: 'assets/videos/working-from-home-thing.mp4',
      publishDateTime: DateTime.parse('2020-07-13'),
      length: const Duration(
        minutes: 6,
        seconds: 55,
      ),
      picPath: 'assets/images/working-from-home thing.jpg',
      description:
          '''The Underdogs are back, navigating their new normal with lots of unknowns but one reliable constant: Apple helps unleash their creativity and productivity even when they\'re working from home.

It\'s still a world of deadlines, meetings, group chats, conference calls, coworkers, and bosses. But it\'s also a world of kids, a dog, and a hairless cat. And it\'s a world where collaboration never misses a beat, whether the team uses iPad, iPhone, iMac, MacBook, or all of the above. Working from home (or working from anywhere) isn\'t new, but what you can make happen together is.

This is Apple at Work (from Home)''',
      views: 15700000,
      creator: apple,
      tags: {'Home', 'technology', 'apple', 'work', 'creative', 'fun', 'ad'},
    );

    Server.uploadVideo(
      title: 'DALL·E 2 Explained',
      videoPath: 'assets/videos/dalle-explained.mp4',
      publishDateTime: DateTime.parse('2022-04-06'),
      length: const Duration(minutes: 2, seconds: 46),
      picPath: 'assets/images/dalle explained.jpg',
      description:
          """DALL·E 2 is a new AI system that can create realistic images and art from a description in natural language.

Learn more: openai.com/dall-e-2""",
      views: 140166,
      creator: openai,
      likes: 7400,
      tags: {'ai', 'creative', 'educational', 'openai', 'technology'},
    );

    Server.uploadVideo(
      title: "أهلا بيك في شايفنها مربعة",
      videoPath: "assets/videos/mraba3a.mp4",
      publishDateTime: DateTime.parse('2021-12-28'),
      length: const Duration(minutes: 5, seconds: 37),
      picPath: 'assets/images/mraba3a.jpg',
      description:
          """أنا محمد الألفطي، شاب بيحب الكرة بجنون و من صغري بتابع كل الدوريات بس للأسف صحابي مكانوش بيحبوا الكرة زيي عشان كدا قررت اعمل القناة ديه عشان اتكلم في الكرة مع ناس بتشاركني نفس الشغف و بتشوف الكرة بطريقة مختلفة زيي 

كل اسبوع بتابع كل الدوريات و بحب اقعد اتكلم علي الماتشات من غير تعصب و من غير تحيز. يوم السبت بالنسبة لي بوم مقدس بقعد اتابع فيه كل الدوريات الاورربية  و بحب انزل فيديو او اتنين بعد كل جولة عشان اتناقش مع الناس في احداث الجولة بكل تفاصيلها

اما بالنسبة لدوري الأبطال فده له معزة خاصة بالرغم من انه بيجي في نص الأسبوع الا انه بيجيب معاه متعة ملهاش مثيل لأن ماتشاته بتبقي ممتعة جدا عكس اغلب الدوريات الايام ديه

 حتي الدوري المصري اللي تاعبنا من قلة التنظيم و سوء التخطيط بس برضه بتحبه و بتتفرج علبه عشان انتمائك لناديك سواء كنت اهلاوي أو زملكاوي""",
      views: 1392,
      creator: meraba3a,
      likes: 30,
      tags: {'meraba3a', 'football', 'ad'},
    );
    Server.uploadVideo(
      title: 'فوازير رمضان النسخة الكروية - الحلقة التانية',
      videoPath: 'assets/videos/fawazir.mp4',
      publishDateTime: DateTime.parse('2022-04-19'),
      length: const Duration(minutes: 4, seconds: 46),
      picPath: 'assets/images/fawazir.jpg',
      description: """
شايفنها مربعة بترجعلكوا الذكريات مع فوازير رمضان و لكن المرادي النسخة الكروية
لو عرفت مين اللاعب ده اكتبلنا اسمه في كومنت

!متنساش تعمل لايك للحلقة و تشترك فى القناة عشان تنضم لعيلتنا الصغيرة
 --------------------------------------------------------------------------------------------------------------------
تابعونا على كل منصات السوشيال ميديا اللى بننزل عليها محتوى مختلف:
Facebook: https://fb.me/ShayfnhaMerabba3a
Instagram: https://www.instagram.com/shayfenhame...
TikTok: https://vm.tiktok.com/ZMeL7QFcJ/""",
      views: 1053,
      creator: meraba3a,
      likes: 1000000,
      tags: {'quiz', 'meraba3a', 'football', 'educational', 'illustration'},
    );

    Server.uploadVideo(
      title: 'Dart in 100 Seconds',
      videoPath: 'assets/videos/dart-100-seconds.mp4',
      publishDateTime: DateTime.parse('2021-10-13'),
      length: const Duration(minutes: 2, seconds: 30),
      picPath: 'assets/images/dart 100 seconds.jpg',
      description:
          """Dart is high-productivity statically-typed programming language capable of targeting multiple platforms. It's used by Flutter to produce fast client apps with an awesome developer experience. 🎯 Learn more in the Full Dart Course https://fireship.io/courses/dart/

#flutter #programming #100SecondsOfCode

🔗 Resources

Full Dart Course https://fireship.io/courses/dart/
Dart Docs https://dart.dev/

🔥 Upgrade to PRO

Upgrade to Fireship PRO at https://fireship.io/pro
Use code lORhwXd2 for 25% off your first payment. 

🎨 My Editor Settings

- Atom One Dark 
- vscode-icons
- Fira Code Font

🔖 Topics Covered

- What is the Dart Programming Language?
- Why is Dart used in Flutter?
- Dart concurrency and isolates""",
      views: 320548,
      creator: fireship,
      likes: 20000,
      tags: {
        'dart',
        'flutter',
        'programming',
        'technology',
        'educational',
        'fireship'
      },
    );
    Server.uploadVideo(
      title: 'Privacy on iPhone | Tracked | Apple',
      videoPath: 'assets/videos/privacy-on-iphone.mp4',
      publishDateTime: DateTime.parse('2021-05-20'),
      length: const Duration(minutes: 1, seconds: 8),
      picPath: 'assets/images/privacy on iphone.jpg',
      description:
          '''App Tracking Transparency lets you control which apps are allowed to track your activity across other companies\' apps and websites.

Learn more: http://apple.co/privacy

Song: “Mind Your Own Business” by Delta 5 
https://apple.co/3ohaM5L

#ApplePrivacy

Welcome to the official Apple YouTube channel. Here you\'ll find news about product launches, tutorials, and other great content. Apple'\s more than 160,000 employees are dedicated to making the best products on earth, and to leaving the world better than we found it.''',
      views: 27636028,
      creator: apple,
      likes: 124000,
      tags: {'privacy', 'apple', 'technology', 'serious', 'ad'},
    );
    Server.uploadVideo(
      title: 'Aligning AI systems with human intent',
      videoPath: 'assets/videos/ai-with-humans.mp4',
      publishDateTime: DateTime.parse('2022-02-15'),
      length: const Duration(minutes: 4, seconds: 5),
      picPath: 'assets/images/ai with humans.jpg',
      description:
          """OpenAI's mission is to ensure that artificial general intelligence benefits all of humanity.

An important part of this effort is training AI systems to align with human intentions and human values.

Learn more about our alignment research: openai.com/alignment
""",
      views: 21116,
      creator: openai,
      likes: 1200,
      tags: {
        'technology',
        'ai',
        'openai',
        'human',
        'ad',
        'education',
        'documentary'
      },
    );

    Server.uploadVideo(
      title:
          'فلوج مجنون مع جماهير السان سيرو في ميلانو - ميلان ١-٢ ليفربول دوري ابطال اوروبا',
      videoPath: 'assets/videos/milan.mp4',
      publishDateTime: DateTime.parse('2021-12-09'),
      length: const Duration(minutes: 21, seconds: 25),
      picPath: 'assets/images/milan.jpg',
      description: """سافرت لميلان عشان احضر ماتش ليفريول في السان سيرو
قابلت المشجعين و استغربت من جنون المدرجات و جمال السان سيرو
فلوج من وسط فلوجات كتييييير جاية استنوها قريب

!متنساش تعمل لايك للحلقة و تشترك فى القناة عشان تنضم لعيلتنا الصغيرة
 --------------------------------------------------------------------------------------------------------------------
تابعونا على كل منصات السوشيال ميديا اللى بننزل عليها محتوى مختلف:
Facebook: https://fb.me/ShayfnhaMerabba3a
Instagram: https://www.instagram.com/shayfenhame...
TikTok: https://vm.tiktok.com/ZMeL7QFcJ/

Music from Uppbeat (free for Creators!):
https://uppbeat.io/t/atm/follow-your-...
License code: IZDOUI0ARC9Z3H8S""",
      views: 2686,
      creator: meraba3a,
      likes: 46,
      tags: {'vlog', 'documentary', 'football', 'meraba3a'},
    );

    Server.uploadVideo(
      title: 'Flutter in 100 seconds',
      videoPath: 'assets/videos/flutter-100-seconds.mp4',
      publishDateTime: DateTime.parse('2020-04-14'),
      length: const Duration(minutes: 2, seconds: 9),
      picPath: 'assets/images/flutter 100 seconds.jpg',
      description:
          """Build apps on iOS, Android, the web, and desktop with Flutter in 100 seconds. Go beyond the basics in the Flutter Firebase course https://fireship.io/courses/flutter-f...

#Flutter #100SecondsOfCode

Flutter https://flutter.dev

Install the quiz app 🤓

iOS https://itunes.apple.com/us/app/fires...
Android https://play.google.com/store/apps/de...

Upgrade to Fireship PRO at https://fireship.io/pro
Use code lORhwXd2 for 25% off your first payment. 

My VS Code Theme

- Atom One Dark 
- vscode-icons
- Fira Code Font""",
      views: 481480,
      creator: fireship,
      likes: 20000,
      tags: {'flutter', 'programming', 'technology', 'fireship', 'educational'},
    );

    Server.uploadVideo(
      title: 'Apple at Work — The Underdogs',
      videoPath: 'assets/videos/apple-at-work.mp4',
      publishDateTime: DateTime.parse('2019-04-03'),
      length: Duration(minutes: 3),
      picPath: 'assets/images/apple at work.jpg',
      description: '''Four colleagues. Two days. One chance.

Learn how Apple products help employees do their best work at https://apple.com/business

Song: “Nature Fights Back” by Hauschka https://apple.co/2TTLqdi''',
      views: 9431199,
      creator: apple,
      likes: 172000,
      tags: <String>{
        'technology',
        'apple',
        'work',
        'creative',
        'power',
        'fun',
        'ad'
      },
    );
  }
}
