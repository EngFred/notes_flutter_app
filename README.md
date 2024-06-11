# My Notes - Your Simple and Efficient Note-taking App

My Notes is a straightforward and intuitive Flutter application designed to manage notes efficiently. It supports all CRUD operations, allowing users to create, read, update, and delete notes seamlessly. Users can add a title, description, and choose a color for each note from a list of available colors. The app is built with scalability in mind, following clean architecture principles.

## Features

- **Create Notes:** Add new notes with an optional title and a required description. Select a color for each note from a predefined list.
- **Read Notes:** View all saved notes, with an option to filter or search through them.
- **Update Notes:** Edit existing notes to update the title, description, or color.
- **Delete Notes:** Remove notes that are no longer needed.
- **Color Coding:** Choose from a variety of colors to categorize and organize your notes visually.

## Architecture

My Notes follows the clean architecture pattern, ensuring a maintainable and scalable codebase:

- **Presentation Layer:** Manages the UI and user interactions using Flutter widgets and Riverpod for state management.
- **Domain Layer:** Contains the business logic and use cases.
- **Data Layer:** Handles data retrieval, storage, and caching using SQLBrite, SQLite3, and Drift.

## Technologies Used

- **Flutter:** Utilized for building a responsive and beautiful cross-platform UI.
- **SQLBrite:** For reactive SQLite operations.
- **SQLite3:** Lightweight database engine for local data storage.
- **Drift:** For type-safe SQL queries and database management.
- **Riverpod:** State management solution for managing the state of the application.
- **go_router:** For handling navigation and routing within the app.

## Setup and Installation

To get started with My Notes, follow these steps:

1. **Clone the Repository:**
    ```sh
    git clone https://github.com/yourEngFred/my-notes.git
    ```

2. **Open the Project:**
    Open the project in your preferred IDE (e.g., VSCode, Android Studio).

3. **Install Dependencies:**
    ```sh
    flutter pub get
    ```

4. **Build and Run:**
    - Run the app on an emulator or a physical device:
      ```sh
      flutter run
      ```

## Usage

- **Adding Notes:** Tap the add button to create a new note. Enter an optional title, a required description, and select a color.
- **Viewing Notes:** Browse through all your notes on the main screen.
- **Editing Notes:** Tap on a note to edit its details.
- **Deleting Notes:** Swipe left or right on a note to delete it.
- **Searching Notes:** Use the search bar to find notes quickly.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to the Flutter and Dart communities for their continuous support and contributions.
- Inspired by clean architecture principles to create a maintainable and scalable application.

---

Organize your thoughts and ideas with My Notes! Whether it's for personal use or professional tasks, My Notes offers a simple yet powerful note-taking experience.
