# Step Squad

![Logo](https://i.ibb.co/47Cz70G/Step-Squad-Logo.png)

Step Squad is an app that allows users to share and join communities centered around dancing. It provides a platform for dancers to connect, explore, and share their passion for dancing like never before.

## Project Overview

The Step Squad project consists of two main components:

1. Client (Flutter App): This folder contains the Flutter mobile app code for Step Squad.
2. Server (NodeJS): This folder contains the Node.js server code for Step Squad.

## Technologies Used

- Flutter (Dart): For building the mobile app frontend.
- Node.js: For building the server-side backend.
- MongoDB: For data storage and retrieval.

## Screenshots

![App Screenshot](https://i.ibb.co/tYsFGxP/Step-Squad-Screenshots.png)

## Getting Started

To get started with the Step Squad project, follow the steps below:

### Setting Up the Server

1. Clone the repository: `git clone https://github.com/royalgaetan/step-squad.git`.
2. Navigate to the `Server` folder: `cd Server`.
3. Install the dependencies: `npm install`.
4. Start the server: `npm start`.

The server should now be running at `http://localhost:3000`.

### Running the Flutter App

1. Ensure you have Flutter installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
2. Navigate to the `Client` folder: `cd Client/stepsquad`.
3. Open the project in your preferred text editor or IDE.
4. Navigate to the utils.dart file located at `Client/stepsquad/lib/utils/utils.dart`.
5. Inside the file, locate the `baseURL` variable. It should be defined as a string.
6. Replace the existing value of baseURL with your own IP address
   If you're not sure how to find your IP address, you can follow the instructions below based on your operating system:

   - Windows: Open Command Prompt and run the following command: ipconfig. Look for the IPv4 Address under the network adapter you're using.
   
   - Linux: Open Terminal and run the following command: ifconfig. Look for the IP address under the network adapter you're using.
   
   - Mac: Open Terminal and run the following command: ifconfig. Look for the IP address under the en0 section.
   
   Save the changes to the utils.dart file.
   
8. Run the app: `flutter run`.

The Step Squad app should now be running on your device/emulator.

## Contributors

- [Royal G](https://github.com/royalgaetan)

Feel free to contribute to the project by submitting bug reports, feature requests, or pull requests

## License

This project is licensed under the [MIT License](LICENSE).
