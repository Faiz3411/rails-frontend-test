# Invisible Commerce Rails Frontend Test

Thank you for considering my submission for the Rails Frontend Test. Below you will find instructions for setting up and running the application, as well as an overview of its features.

## Getting Started

Follow these steps to get the application running on your local machine:

### Installation

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Install the required gems:
    ```bash
    bundle install
    ```
4. Install JavaScript dependencies:
    ```bash
    npm install
    ```
5. Precompile the assets:
    ```bash
    rake assets:precompile
    ```
6. Start the development server:
    ```bash
    ./bin/dev
    ```
7. Visit `http://localhost:3000/` in your browser.

## Features

- **Reason Management**: Add new reasons for returns via a modal by clicking the "Add Reason" button. Each reason can be edited or deleted as needed.
- **Dynamic Interactions**: The application uses Hotwire and Stimulus to allow for drag-drop and dynamic updates without the need for full page refreshes.

## Feedback

Please feel free to provide any feedback or report issues by creating a pull request or submitting an issue on the repository.

Thank you for reviewing my test task!
