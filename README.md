# PlaylistApp

**PlaylistApp** is a Swift-based iOS music player app that allows users to play a curated selection of songs, control playback, adjust volume, and favorite tracks for later review. Built with UIKit, AVFoundation, and Storyboards, this app delivers a simple music experience.

---

## Features

- **Play/Pause Songs**: Toggle playback using system-style buttons.
- **Skip and Rewind**: Navigate through a fixed playlist.
- **Volume Control**: Adjust playback volume in real-time.
- **Favorite Songs**: Save your favorite tracks with artist and cover image.
- **Favorites Screen**: Browse a table view list of your saved favorites.
- **UI**: Built using Storyboards and SF Symbols, optimized for iOS design guidelines.

---

## Architecture

### `AppDelegate.swift`
- Stores a global `favorites` array that is accessible throughout the app lifecycle.

### `ViewController.swift`
- Handles the main UI and playback logic.
- Loads audio files using `AVAudioPlayer`.
- Maintains arrays for song titles, artists, album covers, and audio players.
- Responds to user actions: play/pause, skip, back, volume, favorite, and navigation to the favorites list.

### `FavoritesViewController.swift`
- Displays a list of saved favorite songs in a `UITableView`.
- Loads data from the `favorites` array stored in `AppDelegate`.

---

## File Structure

```plaintext
PlaylistApp/
├── AppDelegate.swift
├── ViewController.swift
├── FavoritesViewController.swift
├── Main.storyboard
├── Info.plist
├── Assets.xcassets (album art & system images)
├── Audio files (.mp3) in Bundle
