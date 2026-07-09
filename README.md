# LocalScribe 🎙️

**An ultra-lightweight (~100kb) local web app serving as a zero-installation meeting note-taker for corporate employees.**

LocalScribe is a local web application that transcribes your meetings securely, right within your browser. By utilizing the browser's built-in speech recognition, it ensures your data remains completely private. 

Absolutely **no installation required**.

## Features

- ** 100% Private & Corporate Safe:** All transcription happens locally in your browser.
- ** Zero Installation:** Works entirely within your web browser. Just open lunch_app.bat file and start transcribing.
- ** Ultra-Lightweight (~100kb):** A minimalist and efficient codebase that doesn't hog system resources.
- ** Built-in Browser transcriber:** Leverages modern Web Speech APIs for accurate, seamless dictation.

## Getting Started

1. Download or clone this repository.
2. Double-click **`lunch_app.bat`** to launch the application.
3. Allow microphone access when prompted by the browser.
4. Start speaking and watch your meeting get transcribed in real-time!

## Auto-Mode

LocalScribe features a hands-free Auto-Mode designed so you can open the app in the morning and leave it running all day. 

By editing the accompanying **auto_mode_phrases.json** configuration file, you can customize the default greeting and farewell **trigger words**. The app listens for these specific phrases to automatically know when a meeting begins and when it ends.

- **Start a Meeting:** Say your configured greeting to begin transcription.
- **End a Meeting:** Say your configured farewell to stop transcription. The app will immediately separate the meeting notes and download a `.txt` file with a timestamp.

## Privacy First

it's the perfect tool for environments with strict IT security policies for installing external third-party tools. Your meetings stay your meetings.


