import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/color-manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          title: Text(
            "about",
            style: TextStyle(fontSize: 20, fontFamily: "Pacifico"),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [SizedBox(height: 100,child: Image.asset(("assets/images/logo.png"))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Selene: Your Personal Mental Health Companion\n\n"
                  "Empowering Wellness Through AI and Music\n\n"
                  "In today's fast-paced world, mental health is a critical aspect of overall well-being. Recognizing this, we introduce Selene, a revolutionary mental health app designed to support users on their journey toward emotional balance and resilience. Let's delve into the remarkable features that make Selene a game-changer:\n\n"
                  "1. Diagnosis of Mental Illness\n\n"
                  "Selene's AI Algorithms: Selene employs cutting-edge artificial intelligence (AI) algorithms to assess users' mental health. By analyzing input data. Selene provides personalized insights. Whether it's detecting signs of anxiety, depression, or panic attack ,or bipolar 1, or bipolar 2. Selene acts as a vigilant companion, nudging users toward professional help when needed.\n\n"
                  "2. Music Generation for Comfort\n\n"
                  "Soothing Sounds at Your Fingertips: Selene understands that music has a profound impact on our emotions. Through its music generation feature, Selene creates customized playlists for certain illnesses and calming melodies. Whether you're winding down after a hectic day or seeking solace during anxious moments, Selene's music adapts to your emotional state.\n\n"
                  "3. Quranic Surah Playback\n\n"
                  "In Selene, users can listen to calming Quranic Surahs. Whether it’s the melodious recitation of Surah Al-Rahman or the tranquil verses of Surah Al-Baqarah, Selene provides a serene space for reflection and solace. As they listen, stress dissipates, anxiety eases, and a sense of peace envelops their hearts.\n\n"
                  "4. Doctor-Generated Descriptions\n\n"
                  "Enhancing Doctor-Patient Communication: When doctors provide descriptions or treatment plans, Selene steps in as an AI collaborator. It refines and expands on the doctor's notes, ensuring patients receive comprehensive information. From coping strategies to medication details.\n\n"
                  "5. Task Management and Goal Setting\n\n"
                  "Aims and Tasks Made Manageable: Selene isn't just about diagnosis; it's about progress. Doctors can set aims and tasks within the app, tailoring them to each patient's needs. Selene sends reminders, tracks progress, and celebrates achievements. Whether it's practicing mindfulness or sticking to medication schedules, Selene keeps you on track.\n\n"
              
                  "6. Doctor-User Chat\n\n"
                  "Real-Time Support: Selene fosters direct communication between doctors and users. The secure chat feature allows patients to ask questions, share updates, and seek guidance. Whether it's discussing treatment adjustments or clarifying doubts, Selene ensures a seamless connection.\n\n"
                  "---\n\n"
                  "Download Selene: Available on Android, Selene is your ally in mental wellness. Remember, seeking professional advice is essential, but Selene complements that journey, offering support 24/7.\n\n"
                  "Discover Selene today and embrace a brighter, healthier you! 🌙✨\n\n"
                  "Team developers:\n\n"
                  "Nour srour mallah\n\n"
                  "Muhammad al mouhtaseb\n\n"
                  "Muhammad mamo\n\n"
                  "Tala wappy\n\n"
                  "---\n\n"
                  "© 2024 Selene , Inc. All rights reserved.\n\n",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
