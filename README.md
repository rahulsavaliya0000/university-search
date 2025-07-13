```markdown
   University Search App 📚

A Flutter application to search global universities by country or name.  
Built with   MVVM architecture  , using   Riverpod   for state management and   GoRouter   for navigation.

I'm also Uploading application here.So you can Simply Install it from there.

A Downlaod Link of Application : 
     ✨ Overview

This app allows users to:
- Browse a list of universities from around the world.
- Search by country or university name.
- View details with country flags, domain info, and quick website links.
- Experience a smooth, responsive, animated UI.

     🚀 Tech stack

| Framework / Library | Purpose                            |
|----------------------|-----------------------------------|
|   Flutter            | UI toolkit for building natively compiled applications |
|   Dart               | Programming language |
|   Riverpod           | State management (MVVM ViewModel layer) |
|   GoRouter           | Navigation & deep linking |
|   flutter_animate    | UI animations |
|   rxdart             | For custom search streams |
|   http               | Networking |
|   country_flags      | Display country flags |
|   url_launcher       | Open university websites in browser |

     🏗 Folder structure



lib/
├── core/
│   ├── constants/
│   └── utils/
│
├── data/
│   ├── models/            e.g. University.dart
│   └── services/          API calls
│
├── domain/
│   └── usecases/          Future extensions (clean separation)
│
├── presentation/
│   ├── view\_models/       Riverpod providers, notifiers
│   ├── views/             UI screens (Home, Detail)
│   ├── widgets/           Reusable UI components
│   └── routes/            GoRouter config



     🛠 Setup instructions

1.   Clone the repository  

   ```bash
   git clone https://github.com/rahulsavaliya0000/university-search.git
   cd university-search
````

2.   Install dependencies  

   ```bash
   flutter pub get
   ```

3.   Run the app  

   ```bash
   flutter run
   ```

     🧑‍💻 Environment

| Tool     | Version |
| -------- | ------- |
| Flutter  | 3.32.2  |
| Dart     | 3.8.1   |
| DevTools | 2.45.1  |

> Check your setup with:
>
> ```bash
> flutter doctor
> ```

     🔥 Features & considerations

  MVVM architecture separates business logic, API services, and UI.
  Reactive search (using `rxdart` BLoC + Riverpod for MVVM).
  Lazy loading for default list with smooth scroll pagination.
  Handles network errors gracefully with UI retry.
  App icons & splash screen configured via `flutter_launcher_icons`.
  Uses HTTP only for demo; easy to adapt to HTTPS / secure APIs.


 ⚠ Security & error handling

  Ensures graceful fallback on API failures, shows error widgets with retry.
  Clear separation via Riverpod providers avoids direct state coupling.
  No sensitive tokens or keys are stored in code.

     🚀 License

This project is open to use for portfolio & educational purposes.

```
```

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

university-search
   f407baab56d8bc6cb336b60a8e7232bc80aab9ed
