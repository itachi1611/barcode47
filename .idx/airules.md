# AI Development Rules for this Flutter Project

This document outlines the rules and conventions for the AI assistant when working on this project. Adhering to these rules ensures consistency, maintainability, and a smooth development workflow.

## 1. General Principles

*   **Language:** All code, comments, variable names, and documentation must be written in **English**.
*   **Code Formatting:** After any code modification, run `flutter format .` to ensure consistent style.
*   **Clean State:** Always aim to leave the project in a runnable state. After making changes, run `flutter analyze` to check for issues and resolve them immediately.
*   **Dependencies:** When adding new packages, use `flutter pub add <package_name>`.

## 2. Localization (i18n)

*   **Framework:** The project uses the `Flutter Intl` package (`intl_utils`) for localization.
*   **Source of Truth:** The `lib/l10n/intl_en.arb` file is the single source of truth for all localization keys.
*   **File Naming:** All locale files must follow the `intl_{locale_code}.arb` pattern (e.g., `intl_en.arb`, `intl_vi.arb`).
*   **Code Generation:** After modifying any `.arb` file, run the following command to regenerate the necessary Dart files:
    ```shell
    flutter pub run intl_utils:generate
    ```
*   **Generated Files:** The generated localization files are located in the `lib/generated/` directory. Imports should point to `lib/generated/l10n.dart`.

## 3. Routing and Navigation

*   **Framework:** Navigation is handled by the `go_router` package.
*   **Configuration:** The main router configuration is located in `lib/router/app_router.dart`.
*   **Routes Enum:** Route paths and names are defined in the `lib/router/routers.dart` enum.
*   **Redirects:** Authentication logic and redirects are managed within the `redirect` block of the `GoRouter` configuration.

## 4. State Management

*   **Framework:** The primary state management solution is the `provider` package.
*   **App-level State:** Global application state (like the current locale) is managed in `lib/app/app_provider.dart`.
*   **New State:** For new features requiring state management, prefer using `ChangeNotifierProvider` and `ChangeNotifier` where appropriate.

## 5. Coding Style

*   **Comments:** All comments must be clear, concise, and written in English.
*   **File Structure:** Maintain the existing project structure. UI components are in `lib/ui/`, routing in `lib/router/`, etc.
*   **Stateless/Stateful Widgets:** Use `const` constructors for widgets whenever possible to improve performance.
