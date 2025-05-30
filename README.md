# 🍕 Foodiez - Food Delivery App  
*Delivering deliciousness with Flutter & Firebase*

<div align="center">
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/ic_launcher_adaptive_fore.png" width="400" height="400 alt="Foodiez Banner"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-35-03-93_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Login Screen"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-35-09-22_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Restaurant List"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-37-50-64_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Order Tracking"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-38-22-71_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-38-36-53_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-38-41-93_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-04-07-09-38-56-31_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-05-30-12-29-05-94_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
  <img src="https://github.com/parth581/Foodiez/blob/main/assets/images/Screenshot_2025-05-30-12-29-19-68_255032073ea671d54b588bf3466f5b80.jpg" width="200" alt="Review System"/>
</div>

---

## 🔥 Key Features

- **Auth System**: Email/Google login with biometric security  
- **Live Tracking**: GPS-powered delivery monitoring  
- **Smart Cart**: Multi-restaurant ordering with Firestore sync  
- **Photo Reviews**: Camera uploads to Firebase Storage  

---

## 🛠 Tech Stack

| Layer            | Technology                      |
|------------------|---------------------------------|
| **Frontend**      | Flutter (Dart)                  |
| **Backend**       | Firebase (Auth, Firestore, Storage) |
| **Maps**          | OpenStreetMap API               |


---

## ⚙️ Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/parth581/Foodiez.git
    ```

2. Add Firebase config:
    - Download `google-services.json` from the Firebase Console  
    - Place it in `android/app/` directory

3. Run the project:
    ```bash
    flutter pub get
    flutter run
    ```

---

## 📸 Feature Highlights

### 1. Secure Authentication  
- Email/Password + Google Sign-In  

### 2. Real-Time Order Tracking  
- Live driver location updates  
- ETA prediction algorithm  

### 3. Performance Metrics

| Metric        | Before | After |
|---------------|--------|-------|
| Cold Start    | 2.8s   | 1.9s  |
| Image Load    | 1.2s   | 0.4s  |
| API Calls     | 15     | 7     |



