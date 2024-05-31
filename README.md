# **Flutter**

## Setup
1. Clone the repository:
  ```bash
  git clone https://github.com/Wambuku/Quantic-Tech.git
  ```

2. Change to the project directory:
  ```bash
  cd Quantic-Tech
  ```
  ```bash
  cd frontend_ui
  ```

3. Install dependencies:
  ```bash
  flutter pub get
  ```

## Run the App
1. Connect a device or start an emulator.

2. Run the app:
  ```bash
  flutter run
  ```

  This will build and run the app on the connected device or emulator.

## Build the App
To build a release version of the app, use the following command:



# **Laravel API Project Documentation**

## Table of Contents

- [Introduction](#introduction)
- [Setup](#setup)
- [Authentication Endpoints](#authentication-endpoints)
- [Customer Management Endpoints](#customer-management-endpoints)
- [Product Management Endpoints](#product-management-endpoints)
- [Order Management Endpoints](#order-management-endpoints)
- [Dashboard Endpoint](#dashboard-endpoint)
- [Notes](#notes)

## Introduction

This documentation covers the API endpoints for the Laravel project. The API allows for managing customers, products, orders, and includes authentication features.

## Setup

Ensure you have the Laravel project set up and running on your local server. Use Postman to test the API endpoints.

## Authentication Endpoints

1. **Register User**
   - **URL:** `POST http://localhost:8000/api/register`
   - **Body (raw JSON):**
     ```json
     {
       "name": "John Doe",
       "email": "john.doe@example.com",
       "password": "password",
       "password_confirmation": "password"
     }
     ```

2. **Login User**
   - **URL:** `POST http://localhost:8000/api/login`
   - **Body (raw JSON):**
     ```json
     {
       "email": "john.doe@example.com",
       "password": "password"
     }
     ```
   - **Response:**
     ```json
     {
       "token": "your_generated_token_here"
     }
     ```

3. **Logout User**
   - **URL:** `POST http://localhost:8000/api/logout`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

## Customer Management Endpoints

1. **Get Customer**
   - **URL:** `GET http://localhost:8000/api/customers/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

2. **Add Customer**
   - **URL:** `POST http://localhost:8000/api/customers`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "name": "John Doe",
       "email": "john.doe@example.com",
       "phone": "1234567890",
       "address": "123 Main St"
     }
     ```

3. **Update Customer**
   - **URL:** `PUT http://localhost:8000/api/customers/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "name": "John Smith",
       "email": "john.smith@example.com",
       "phone": "0987654321",
       "address": "456 Elm St"
     }
     ```

4. **Delete Customer**
   - **URL:** `DELETE http://localhost:8000/api/customers/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

5. **Search Customer**
   - **URL:** `GET http://localhost:8000/api/customers/search?key=value`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

## Product Management Endpoints

1. **Get Product**
   - **URL:** `GET http://localhost:8000/api/products/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

2. **Add Product**
   - **URL:** `POST http://localhost:8000/api/products`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "name": "Product Name",
       "description": "Product Description",
       "price": 99.99,
       "quantity": 10
     }
     ```

3. **Update Product**
   - **URL:** `PUT http://localhost:8000/api/products/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "name": "Updated Product Name",
       "description": "Updated Product Description",
       "price": 89.99,
       "quantity": 5
     }
     ```

4. **Delete Product**
   - **URL:** `DELETE http://localhost:8000/api/products/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

5. **Search Products**
   - **URL:** `GET http://localhost:8000/api/products/search?key=value`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

## Order Management Endpoints

1. **Get Order**
   - **URL:** `GET http://localhost:8000/api/orders/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

2. **Add Order**
   - **URL:** `POST http://localhost:8000/api/orders`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "customer_id": 1,
       "products": [
         {"id": 1, "quantity": 2},
         {"id": 2, "quantity": 1}
       ],
       "phone": "254712345678"
     }
     ```

3. **Update Order**
   - **URL:** `PUT http://localhost:8000/api/orders/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`
   - **Body (raw JSON):**
     ```json
     {
       "status": "completed"
     }
     ```

4. **Delete Order**
   - **URL:** `DELETE http://localhost:8000/api/orders/{id}`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

5. **Search Orders**
   - **URL:** `GET http://localhost:8000/api/orders/search?key=value`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

6. **Generate Invoice**
   - **URL:** `GET http://localhost:8000/api/orders/{id}/invoice`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

## Dashboard Endpoint

1. **Get Dashboard**
   - **URL:** `GET http://localhost:8000/api/dashboard`
   - **Headers:**
     - **Authorization:** `Bearer your_generated_token_here`

## Notes

- Replace `{id}` with the actual ID of the resource you want to access.
- Use the Bearer token received from the login endpoint in the Authorization header for all protected routes.
- Adjust `key=value` in search endpoints based on the actual search criteria (e.g., `name=John`, `status=pending`).

