# MangaNotes

[![ru](https://img.shields.io/badge/%D1%8F%D0%B7%D1%8B%D0%BA-%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9%20%F0%9F%87%B7%F0%9F%87%BA-white)](README.md)
[![en](https://img.shields.io/badge/lang-English%20%F0%9F%87%AC%F0%9F%87%A7-white)](./README_EN.md)

---

🚨 **Notice! This repository is deprecated and no longer maintained**

⚠️ Status: Archived

This version of the project is no longer being updated. I'm currently focusing on a completely rewritten version of the application where:

🔄 Full architecture overhaul

🎯 All known bugs fixed and performance improvements implemented

🖌️ UI/UX refresh while maintaining original visual identity

🔧 New features added and security enhancements

---

**MangaNotes** is a convenient app for searching and saving manga information. Users can find their favorite titles, track reading progress, and create personalized lists of favorites. Thanks to account synchronization, your library is accessible from any device.

## Overview and Interface

### Initial Launch
<img src="https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/auth.png" alt="auth" height=800>

On the initial launch, users can either create an account or log in if they already have one. Password recovery is available using a recovery code provided during registration, making it easier to restore access.

### Main Screen
<img src="https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/favorites.png" alt="favorites" height=600>

The main screen displays all saved titles organized into categories: **Read**, **Reading**, **To Read**. This helps users easily track their progress and decide what to read next.

### Manga Details
<img src="https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/manga_info.png" alt="manga_info" height=600>

Each title can be viewed in a detailed card with full description and options to update its status, jump to reading, as well as modify or delete the entry.

### History and Search
<img src="https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/searching.png" alt="searching" height=600>

The search history is saved, making it easy to return to previously found titles.  
Search is conducted across three services: **Remanga**, **Shikimori**, and **MangaOVH**. Results are cached to speed up future searches and reduce API requests.

### Settings
<img src="https://raw.githubusercontent.com/xEncerx/MangaNotes/refs/heads/master/git_images/settings.png" alt="settings" height=600>

In settings, you can change the app theme, button style, and manga sorting order — allowing for a personalized experience.

---

## Technologies and Features

- **Database**: Supabase is used for storing user data and manga collections.
- **API**: Manga data is sourced from multiple providers, including **Remanga**, **Shikimori**, and **MangaOVH**, offering access to diverse content sources.
