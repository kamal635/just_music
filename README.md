# 🎵 Just Music

A modern, feature-rich music player built with Flutter that provides an exceptional listening experience with local music playback, playlist management, and intuitive user interface.


## 📱 Screenshots

<img width="1200" height="1000" alt="just music" src="https://github.com/user-attachments/assets/d6a903fc-9a86-42f9-a43c-f078b355be1d" />


## ✨ Features

### 🏠 Home Screen
- **Recently Played**: Quick access to your recently listened tracks
- **Most Played**: Discover your favorite songs based on play count
- **Featured Songs**: Curated selection of your music library
- **Featured Artists**: Browse music by your favorite artists
- **Featured Albums**: Explore complete albums from your collection
- **Shuffle & Favorite**: Quick actions for instant music enjoyment

### 🎶 Music Library
- **Local Music Playback**: Play music files stored on your device
- **Audio Controls**: Play, pause, skip, and seek through tracks
- **Background Playback**: Continue listening while using other apps
- **Audio Service Integration**: Professional audio handling with just_audio
- **Permission Management**: Secure access to device storage

### 📱 Multiple Views
- **Songs View**: Browse all songs with search functionality
- **Artists View**: Organize music by artist with album collections
- **Albums View**: Complete album browsing with track listings
- **Playlists**: Create and manage custom playlists
- **Favorites**: Quick access to your favorite tracks

### 🔍 Search & Discovery
- **Global Search**: Search across songs, artists, and albums
- **Smart Filtering**: Find music by title, artist, or album name
- **Real-time Results**: Instant search results as you type

### 📋 Playlist Management
- **Create Playlists**: Build custom playlists with your favorite songs
- **Add/Remove Songs**: Easily manage playlist content
- **Rename Playlists**: Customize playlist names
- **Delete Playlists**: Remove unwanted playlists
- **Playlist Sorting**: Sort by creation date or modification date

### ⭐ Favorites System
- **Favorite Songs**: Mark songs as favorites for quick access
- **Favorite Management**: Add/remove songs from favorites
- **Dedicated Favorites View**: Browse all your favorite tracks

### 🎛️ Audio Player Features
- **Progress Bar**: Visual track progress with seek functionality
- **Music Controls**: Play, pause, next, previous controls
- **Floating Player**: Mini player that stays accessible
- **Track Information**: Display song title, artist, and album art
- **Background Audio**: Continue playback when app is minimized

### 🎨 User Interface
- **Dark Theme**: Modern dark interface for comfortable viewing
- **Responsive Design**: Optimized for both mobile and tablet
- **Custom Icons**: Beautiful iconography throughout the app
- **Smooth Animations**: Fluid transitions and interactions
- **Bottom Navigation**: Easy navigation between main sections

## 🛠️ Technology Stack

### Core Framework
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language

### State Management
- **flutter_bloc**: BLoC pattern for state management
- **equatable**: Value-based equality for clean comparisons

### Audio & Media
- **just_audio**: Feature-rich audio player
- **audio_service**: Background audio playback
- **on_audio_query**: Query device audio files
- **audio_video_progress_bar**: Progress bar for audio/video

### UI & Responsiveness
- **flutter_screenutil**: Responsive UI scaling
- **fluttertoast**: Toast notifications
- **font_awesome_flutter**: Icon library

### Data Management
- **hive**: Local database for data persistence
- **get_it**: Dependency injection
- **rxdart**: Reactive programming

### Development Tools
- **build_runner**: Code generation
- **flutter_lints**: Code quality enforcement


## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.2.6)
- Dart SDK (>=3.2.6)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/just_music.git
   cd just_music
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── constant/                  # App constants
│   ├── functions/                 # Utility functions
│   ├── helpers/                   # Helper classes
│   ├── routes/                    # App routing
│   ├── shared_widgets/           # Reusable widgets
│   └── styling/                  # App styling
├── features/                      # Feature modules
│   ├── albums/                   # Album management
│   ├── artists/                  # Artist management
│   ├── changed_view/             # Main navigation view
│   ├── favorites/                # Favorites system
│   ├── home/                     # Home screen
│   ├── playlists/                # Playlist management
│   ├── settings/                 # App settings
│   └── songs/                    # Music playback
├── just_music_app.dart           # Main app widget
└── main.dart                     # App entry point
```

## 🎯 Key Features Implementation

### Audio Service Integration
The app uses `audio_service` for professional background audio playback, ensuring music continues when the app is minimized or the screen is locked.

### State Management with BLoC
Clean architecture with BLoC pattern for predictable state management across all features.

### Local Database with Hive
Fast and efficient local storage using Hive for playlists, favorites, and app data.

### Responsive Design
Adaptive UI that works seamlessly on both mobile phones and tablets with proper scaling.

## 🔧 Configuration

### Permissions
The app requires storage permissions to access music files on your device. Permission requests are handled gracefully with user-friendly dialogs.

### Audio Formats
Supports common audio formats including:
- MP3
- WAV
- FLAC
- AAC
- And other formats supported by the device

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 📞 Support

If you encounter any issues or have questions, please:

1. Check the [Issues](https://github.com/yourusername/just_music/issues) page
2. Create a new issue with detailed description
3. Contact the development team kamalibrahim397@gmail.com

---

**Made with ❤️ using Flutter**

*Enjoy your music with Just Music! 🎵*
