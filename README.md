# MovieLand

A Flutter application applying Clean Architecture with TheMovieDB service.

-----

## Key features

- **Fetching most popular movies**
- **Showing relevant details about movie**
- **Local storage management**

-----

## Architecture overview

![Diagram](https://github.com/araujocarlosm/MovieLand/blob/main/movieland_architecture.png)

### Presentation Layer

Responsible for managing the user interface and interacting with the Domain Layer to display data
and handle user inputs. It follows the MVVM to ensure a clean separation of concerns.

- **MoviesViewModel**
    - Manages the state of movie data, including loading status, error messages, and the list of movies.
    - Uses a *GetMoviesUseCase* to fetch movie data, promoting separation of concerns.
    - Uses *ChangeNotifier* to notify the UI about state changes, enabling reactive UI updates.

- **MovieDetailsViewModel**
    - Handles fetching, saving, and managing movie details.
    - It uses use cases to interact with the domain layer.

-----

### Domain Layer

**Entities:**

- **Movie:** This class is intended to represent movie data, and it's structured to be compatible
  with *Hive*, a NoSQL database chosen for this project.
- **MovieDetails:** represents the details of a movie, including its genres, and inherits basic
  movie information from the *Movie* class.

**Use Cases:**

- ``UseCase(interface)``  this is a generic abstract class that can be extended by other use cases.
- ``GetMoviesUseCase`` encapsulates the logic for fetching a list of movies. It adheres to the
  *UseCase* interface, making it reusable and testable. It depends on a *MoviesRepository* to handle
  the actual data fetching, promoting separation of concerns.
- ``GetMovieDetailsUseCase`` encapsulates the logic for retrieving movie details. It depends on a
  *MoviesRepository* to fetch the data.
- ``SaveMovieUseCase`` encapsulates the logic for saving movie details in a local database.
- ``GetLocalMovieUseCase`` responsible for retrieving movie details from a local data source.

**Repository:**

- ``MoviesRepository(interface)`` defines a contract for movie data access, promoting code
  reusability and maintainability by decoupling the data access logic from the rest of the
  application.

-----

### Data Layer

**DataSource:**

- ``RemoteDataSource(interface)`` defines a contract for fetching movie data from a remote source.
- ``LocalDataSource(interface)`` defines a contract for any class that wants to provide local data
  storage functionality for MovieDetails.

*The DataSource pattern was chosen because helps to decouple the data access logic from the rest of
the application, making it easier to test and maintain.*

**Repositories:**

- ``MoviesRepositoryImpl`` acts as a concrete implementation of the *MoviesRepository* interface. It
  handles fetching movie data from a remote source (*RemoteDataSource*) and managing locally stored
  movie data using a *LocalDataSource*.

*This class follows the repository pattern, which is a common way to abstract data access in
applications.*

-----

### Infrastructure

**Local Storage:**

- Added ``BaseLocalStorageService(interface)``, which defines a contract for any class that wants to
  provide local storage functionality. By extending this abstract class, concrete classes are forced
  to implement the add, get, getAll, and clear methods.
- ``HiveLocalStorageService`` is a concrete implementation of **BaseLocalStorageService**, for
  storing and retrieving MovieDetails objects using the Hive database.
- *Hive* is a package use for storing app settings, user preferences, cached data, or any other data that needs to be easily persisted locally.
- Using this approach its easy to swap out different storage implementations if needed.

**Networking Services:**

- ``HttpClient(interface)`` defines a contract for any class that wants to act as an HTTP client.
- ``DioClient`` provides a convenient way to make HTTP GET requests using the *dio* package. Dio provides a more robust and feature-rich approach to making HTTP requests compared to simpler alternatives. Its powerful interceptors and detailed error handling capabilities make it a great choice for building complex applications with demanding network requirements.
- As the same way as local Storage, its easy to swap out with other networking implementations if needed.

**Dependency Injection:**

- ``InjectionDependencies`` uses the get_it package to handle DI. It registers various services, data sources, repositories, and use cases as singletons or lazy singletons. This allows to easily access dependencies throughout app using *locator*, promoting loose coupling and making the code more testable and maintainable.