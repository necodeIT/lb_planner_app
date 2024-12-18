# LB Planner (App)

This is the source code for the frontend of LB Planner.

## Development

### Prerequisites

- Flutter Version Manager (fvm): [Installation Guide](https://fvm.app/documentation/getting-started/installation)
  - You may want to set an alias for flutter to fvm in your shell configuration file.

    ```bash
    alias flutter="fvm flutter"
    alias dart="fvm dart"
    ```

- VsCode
- slidy (optional): [Installation Guide](https://pub.dev/packages/slidy)

  ```bash
  dart pub global activate slidy
  ```

### Setup

1. Once you've cloned the repository open it in VsCode
2. If not already, install the recommended extensions.
   - VsCode should prompt you upon opening the project.
3. Copy the `.env.example` file to `.env` and fill in the required values.

   ```bash
    cp .env.example .env
    ```

4. Run `fvm use && fvm flutter pub get` to install the flutter version used for this project.
5. Restart VsCode so that it recognizes the flutter version.
6. If you are running the app from a terminal, run `fvm flutter run --dart-define-from-file=.env` to start the app.
   1. VsCode should automatically detect the `.env` file and run the app with the correct environment variables.

### Tools

- [flutter_modular_bricks](https://github.com/mcquenji/flutter_modular_bricks): A tool to generate boilerplate code for flutter_modular.
  - `mason make module` to create a new module.
  - `mason make service` to create a new service.
  - `mason make service-impl` to implement a service.
  - `mason make datasource` to create a new datasource.
  - `mason make datasource-impl` to implement a datasource.
  - `mason make repo` to create a new repository.
  - `mason make widget` to create a new widget.
  - `mason make screen` to create a new screen.
  - `mason make model` to create a new model.
  - `mason make util` to create a new utility group.
  - `mason make guard` to create a new route guard

- `slidy run translate` to generate the dart code for the translation files.
- `slidy run generate` to run all generators.
- `slidy run clean` to clean the project and refetch dependencies.

### Guidelines

Coding style is enforced as defined per the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines and the [analysis_options.yaml](analysis_options.yaml) file.

#### Architecture

- LB Planner uses `flutter_modular` and adheres to [Clean Dart](https://github.com/mcquenji/Clean-Dart) principles (a port of Clean Architecture to Dart).
- The project is divided into modules, each module representing a feature or a group of features (e.g. `auth`, `home`, `settings`).
- Each module has its own `domain`, `infra`, and `presentation` layers.
  - **Domain**: Defines contracts logic and entities.
  - **Infra**: Implements the contracts defined in the domain layer.
  - **Presentation**: Contains the UI and business logic.

#### Commits

- Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.
- It is recommended to use the [Conventional Commits VsCode extension](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits) to help you write conventional commit messages.
  - You should be prompted to install this extension upon opening the project.
