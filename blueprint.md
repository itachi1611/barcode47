# Project Blueprint

## Overview

This document outlines the structure, features, and design of the Flutter application. It serves as a single source of truth for the project's implementation details.

## Implemented Features

*   **Initial Project Setup:** A basic Flutter project structure.
*   **Localization:** Support for English and Vietnamese.
*   **Routing:** Basic routing setup with `go_router`.

## Current Plan: Implement Bottom Navigation and Language Switch

### 1. Add Dependencies
*   Add the `provider` package for state management.

### 2. Create UI Shell with Bottom Navigation
*   Create a new widget `main_shell.dart` that will contain the `Scaffold` with the `BottomNavigationBar` and the content area for the different tabs.

### 3. Create Tab Screens
*   Create placeholder screens for each tab:
    *   `lib/ui/dashboard/dashboard_page.dart`
    *   `lib/ui/view/view_page.dart`
    *   `lib/ui/setting/setting_page.dart`

### 4. Implement Language State Management
*   Create a `LocaleProvider` class using `ChangeNotifier` to manage the application's current locale.

### 5. Update Router Configuration
*   Modify `app_router.dart` to use `StatefulShellRoute.indexedStack` for the home screen. This will create a nested navigation structure for the tabs, preserving the state of each tab when switching between them.
*   Update `routers.dart` with the new routes for the tabs.

### 6. Implement Settings UI
*   In `setting_page.dart`, add a `Switch` widget to toggle between English and Vietnamese.
*   The switch will interact with the `LocaleProvider` to update the application's language.

### 7. Update `main.dart`
*   Wrap the application in a `ChangeNotifierProvider` to make the `LocaleProvider` available to the entire widget tree.
*   Configure `MaterialApp.router` to use the locale from the `LocaleProvider`.

