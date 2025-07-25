
# MegaMart MultiVendor Ecommerce App for Admin

MegaMart Admin is a Flutter-based admin panel for managing the MegaMart application. This project allows administrators to upload banners, manage products, and perform other administrative tasks.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Installation

### Prerequisites
- Flutter SDK: `>=3.3.2 <4.0.0`
- Dart SDK: `>=3.3.2 <4.0.0`
- Firebase account

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/nisanray/megamart_admin.git
   cd megamart_admin
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Follow the Firebase setup instructions for Flutter [here](https://firebase.flutter.dev/docs/overview).
   - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective directories.

## Usage

Run the project with the following command:
```bash
flutter run
```

Example usage:
- Open the app on your device or emulator.
- Navigate to the banner upload section.
- Pick an image and upload it to Firestore.

## Features

- **Upload and manage banners**: Easily upload and manage banners for the MegaMart application.
- **Firebase integration**: Authentication, storage, and Firestore integration.
- **Responsive design**: Adapts to various screen sizes.
- **User-friendly interface**: Simple and intuitive UI for administrators.
- **CRUD category management**: Create, read, update, and delete categories.
- **Customer profile management**: Manage customer profiles.
- **Vendor approval**: Approve or reject vendor applications.
- **Vendor profile viewing**: View vendor profiles along with their products.

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) for details on the process for submitting pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

Maintainer: [Nisan Ray](https://github.com/nisanray)
Feel free to reach out for questions or contributions!
