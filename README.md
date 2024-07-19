# LB Planner (App)

This is the source code for the frontend of LB Planner.

## Development

### Prerequisites

- Flutter Version Manager (fvm): [Installation Guide](https://fvm.app/docs/getting_started/installation)
  - You may want to set an alias for flutter to fvm in your shell configuration file.

    ```bash
    alias flutter="fvm flutter"
    alias dart="fvm dart"
    ```

- VsCode

### Setup

1. Once you've cloned the repository open it in VsCode
2. If not already, install the recommended extensions.
   - VsCode should prompt you upon opening the project.
3. Run `fvm use` to install the flutter version used for this project.
4. Restart VsCode so that it recognizes the flutter version.

### Tools

- Use [slidy](https://pub.dev/packages/slidy) to generate modules and files within those modules.
- `slidy run translate` to generate the dart code for the translation files.
- `slidy run generate` to run all generators.
- `slidy run clean` to clean the project and refetch dependencies.

### Guidelines

Coding style is enforced as defined per the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines and the [analysis_options.yaml](analysis_options.yaml) file.

#### Architecture

- LB Planner uses `flutter_modular` and adheres to [Clean Dart](https://github.com/Flutterando/Clean-Dart/blob/master/README_en.md) principles (a port of Clean Architecture to Dart).
- The project is divided into modules, each module representing a feature or a group of features (e.g. `auth`, `home`, `settings`).
- Each module has its own `domain`, `infra`, and `presentation` layers.
  - **Domain**: Defines contracts logic and entities.
  - **Infra**: Implements the contracts defined in the domain layer.
  - **Presentation**: Contains the UI and business logic.

#### Commits

- Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.
- It is recommended to use the [Conventional Commits VsCode extension](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits) to help you write conventional commit messages.
  - You should be prompted to install this extension upon opening the project.
