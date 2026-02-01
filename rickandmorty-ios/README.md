# Rick & Morty 

A SwiftUI iOS app to explore characters from the Rick & Morty universe.
The codebase follows a clean, layered, domain‑centric architecture guided by software design best practices, resulting in a modular, testable, and maintainable structure that scales as features grow.

## Architecture & Principles
#### Layered System Design:
- Data Layer — Handles networking, repository logic, and image caching mechanisms.
- Domain Layer — Serves as the heart of the system, defining models, high‑level repository abstractions, and the logic that orchestrates application workflows.
- Presentation Layer — Responsible for UI logic, powered by ViewModels and SwiftUI views.

#### Structured & Maintainable Codebase:
- Focused Responsibilities — Each module and component is dedicated to a single purpose, ensuring clarity and simplicity.
- Future‑proofed — Allows expanding functionality, customizing themes, or extending network services while keeping existing code untouched.

#### SwiftUI best practices:
- UI components decomposed into lightweight subviews to reduce recomposition costs and enhance performance.
- Reactive state is managed using Apple’s Observation system (@Observable, @State, @Environment) for smooth updates and predictable UI behavior.


## Requirements
- iOS 26+
- Swift 6.2+
- Xcode 26+

## Project Structure
Project/
├─ Core/
│  ├─ Data/           # Data sources, repositories, DTOs, mappers 
│  ├─ Domain/         # Use cases, entities, repository interfaces 
│  ├─ Extensions/     # Small, focused extensions (String+, Date+, View+, etc.)
│  ├─ Networking/     # API client(s), endpoints, request/response building
│  └─ Router/         # Route enums + Router protocols (feature-agnostic)
├─ Design/            # Design system: tokens, colors, typography, reusable components
├─ L10n/              # Localization: strings catalog, helpers, formatters
├─ Presentation/
│  ├─ Characters/     # Feature-specific views + view models + subroutes (example)
│  └─ Coordinators/   # Coordinators per feature/root; navigation state & flows
## Features
#### Characters List
   - Displays a scrollable list of characters.
   - Infinite scrolling with pagination.
   - Each row shows a character image, name and status.
#### Character Detail
   - Detailed view for each character.
   - Shows character image, status, species, gender, origin, and last known location.
   - Includes a list of episodes the character appears in.
   - Toggle to show all episodes if more than 5.
#### Search & Filters
   - Live search for character names and status.
   - The app uses SwiftUI’s searchable modifier to provide a native search bar integrated into the list view. As the user types, the list updates in real time by filtering characters based on the search query. Additional search scopes (Alive, Dead, Unknown) allow refined results. This approach keeps the UI clean, responsive, and consistent with the iOS experience.
#### Localization (L10n)
   - Text strings are localized, ready for multi-language support.
#### Image Loading & Cache
   - `CachedAsyncImageView` component for loading images efficiently.
#### Testing
   - Basic unit tests covering ViewModels.
   - Mocks and stubs ensure tests run independently of network.
#### Navigator & coordinator
   - A lightweight navigation architecture using a Coordinator to manage navigation state and a Router to map typed routes to views. Designed to keep views simple and make the app easily extensible as new features are added. 


## License
MIT License
    
