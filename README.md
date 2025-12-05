# Versario - Diary Application

Versario is an app that allows users to create and manage personal diaries. The app features Firebase integration for authentication and data storage, animations for a smooth user experience, and follows modern architectural patterns to ensure maintainability and scalability.

---

## Architecture

The app follows the **Clean Architecture** pattern, separating responsibilities into distinct layers:

1. **ViewModels**  
   - Responsible for providing data to the Views and handling user interactions.  
   - All screens consume services through their respective ViewModels.  
   - A global ViewModel called `AppSession` is used to share user session information across the app, such as login state, preferences, and user data.

2. **Services (Business Logic Layer)**  
   - Contain the core business logic of the app.  
   - Interact with **Repositories** to fetch or modify data.

3. **Repositories**  
   - Responsible for directly communicating with external data sources, such as APIs, Firebase, or local databases.  
   - Provides an abstraction layer for Services, isolating data access logic.

This separation makes testing, maintenance, and app evolution easier.

---

## Folder Structure

The project is organized in a modular way to maintain scalability and clarity:

```markdown
Versario
├── Application
│   └── Entry point files
├── Shared
│   ├── Enums/
│   ├── Extensions/
│   ├── Services/
│   ├── Protocols/
│   ├── ViewModifiers/
│   ├── Components/
│   ├── Helpers/
│   └── Repositories/
├── Scenes
│   └── App views and their corresponding ViewModels
├── Resources
│   └── Assets and configuration files (e.g., GoogleService-Info.plist)
├── Models
│   └── App models
```
---

## Final Considerations

The app is structured to easily support new features and AI integrations while maintaining a clean, scalable, and organized architecture. Future implementation of sentiment analysis and automatic text suggestions will enhance user engagement and personalization.

## Current Features

- Diary entry creation with title, text and date information.
- Animations in screens and interactions to improve user experience.
- User authentication via Firebase.
- Session information sharing using `AppSession`.
- Modular and organized structure following Clean Architecture.

---

## Technologies and Patterns

- **Swift & SwiftUI** for building interfaces.
- **Firebase** for authentication and data storage.
- **Clean Architecture** to separate layers of responsibility.
- **MVVM** with ViewModels consuming Services and Repositories.
- **Extensions and ViewModifiers** shared across the app for consistency.

---

## Next Steps

1. **New Features and Screens**
   - **Edit Account** screen.
   - **Delete Account** screen.
   - **Statistics and Reports** screens, including:
     - Consecutive diary entry tracking.
     - Weekly and monthly usage reports.

2. **Foundation Models and App Intents Integration**
   - Analyze user-written text sentiment.
   - Generate weekly insights about user mood and emotions.
   - Suggest summaries or automatic comments.
   - Possible AI integration to complete poem stanzas or start poems.

3. **Enhancements in Poems**
   - Add new types of poems currently unavailable.
   - GPT integration to suggest initial stanzas.
   - Sentiment analysis to provide feedback on diary entries automatically.

4. **Potential AI Features**
   - Use Foundation Models to:
     - Assess user mood.
     - Generate insights or reflections based on diary content.
     - Suggest new poem types or text snippets based on style, mood, and previously written content.

---
