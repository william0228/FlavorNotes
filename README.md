### Steps to Run the App
1. Clone the repository from the GitHub: https://github.com/william0228/FlavorNotes.git
2. Use Xcode to open the project and hit run (Cause the app fetchs data from remote JSON file, please also make sure the network connection)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I select three part to focus on:

- User Experience: Created a clean and intuitive interface for navigating(use confirmationDialog for better clarity and usability) and searching recipes.
- Data Handling: Focused on robust handling of JSON data, including error handling for malformed data or network failures.
- Scalability: Ensured the app structure aligns with the MVVM pattern to allow for future feature additions without major refactoring.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 4 hours on this project:

- 1 hour: UI design and implementation.
- 2 hours: Developing ViewModel functionality and data fetching logic.
- 1 hour: Unit testing and debugging.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I prioritized functionality over visual polish, particularly for the "empty state" view, to ensure I met the project’s core requirements.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of the project is the lack of offline support. Currently, the app relies entirely on a network connection(only cach the image after first sight), and if the fetch fails, no data is displayed. 
Adding offline caching or storing data in a local database like Core Data or Realm would enhance usability.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- Kingfisher: Used for efficient image downloading and caching, which significantly improved the performance and responsiveness of the app when displaying recipe images.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Future Plans: Plan to extend the app with features like user authentication, saving favorite recipes, and advanced filtering options for quick search.
