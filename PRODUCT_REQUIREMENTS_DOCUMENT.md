# Product Requirements Document (PRD)
## M-Link: Campus Local Commerce Directory

**Document Version:** 1.0  
**Date:** February 27, 2026  
**Project Type:** Mobile Application (Flutter)  
**Target Institution:** Mae Fah Luang University (MFU)

---

## 1. Product Overview

### 1.1 Product Vision

M-Link aims to become the essential digital bridge connecting Mae Fah Luang University students with local service providers in the campus vicinity. By creating a centralized, easily accessible platform, M-Link empowers students to discover essential services efficiently while enabling local merchants to establish and manage their digital presence without technical expertise.

The platform envisions a thriving local economy where students can make informed decisions about services they need daily, and merchants can reach their target audience with minimal overhead costs.

### 1.2 Problem Statement

**Current Challenges:**

- **Students:** Lack a centralized directory to discover essential services near campus (motorbike rentals, optical shops, printing services, dormitory amenities). Students often rely on word-of-mouth or trial-and-error, leading to inefficient time usage and missed opportunities to find better service options.

- **Merchants:** Small local businesses struggle to establish an online presence due to limited technical knowledge, budget constraints, and lack of platforms specifically targeting the student demographic. Traditional marketing methods (flyers, banners) are costly and have limited reach.

- **Information Gap:** No standardized way to access up-to-date information about service availability, pricing ranges, locations, and merchant contact details.

### 1.3 Solution Overview

M-Link is a mobile-first web application that provides:

**For Students:**
- Free, no-login-required browsing of categorized local services
- Comprehensive shop information including descriptions, pricing ranges, images, and direct Google Maps integration
- Category-based filtering for quick service discovery
- Mobile-optimized interface for on-the-go access

**For Merchants:**
- Free, self-service shop profile creation and management
- Intuitive dashboard for updating business information
- Digital storefront accessible to the entire student population
- Authentication-protected management interface

**Technical Implementation:**
- Progressive Web App (PWA) built with Flutter for cross-platform compatibility
- Role-based access control (Student vs. Merchant)
- JWT-based authentication for merchant accounts
- RESTful API architecture for scalability

---

## 2. Target Users

### 2.1 Student Users

**Demographics:**
- Age: 18-25 years
- Status: Undergraduate and graduate students at Mae Fah Luang University
- Tech proficiency: Medium to high (smartphone-native generation)
- Primary device: Mobile phones (iOS and Android)

**User Characteristics:**
- Budget-conscious consumers
- Time-sensitive (class schedules, assignments)
- High mobile internet usage
- Prefer quick, frictionless experiences
- Value peer recommendations and visual information

**User Needs:**
- Quick discovery of services by category
- Transparent pricing information
- Visual confirmation (shop photos)
- Easy navigation to physical locations
- No account creation barriers

### 2.2 Merchant Users

**Demographics:**
- Business owners and managers of small-to-medium enterprises near MFU campus
- Age: 25-55 years
- Tech proficiency: Low to medium
- Business types: Motorbike rentals, optical shops, printing services, laundromats, food vendors, stationary stores, tailoring shops, convenience stores

**Business Characteristics:**
- Primarily serve student clientele
- Limited marketing budgets
- Minimal or no existing online presence
- Need cost-effective visibility solutions

**User Needs:**
- Simple, guided shop profile creation
- Easy-to-update business information
- Platform to showcase products/services visually
- Secure management of their business data
- Analytics on shop views (future requirement)

---

## 3. User Roles & Permissions

### 3.1 Role Definition Table

| Role | Authentication Required | Capabilities | Restrictions |
|------|------------------------|--------------|--------------|
| **Student (Guest)** | No | • Browse all shops<br>• View shop details<br>• Filter by category<br>• Access Google Maps links | • Cannot create/edit shops<br>• No access to merchant dashboard<br>• Cannot save favorites (future feature) |
| **Merchant** | Yes (JWT) | • All student capabilities<br>• Create new shop profile<br>• Edit own shop information<br>• Upload/manage shop images<br>• Update pricing and descriptions | • Cannot edit other merchants' shops<br>• Limited to one shop per account (v1.0)<br>• Cannot delete shops (requires admin approval) |
| **Admin** (Future) | Yes | • All merchant capabilities<br>• Approve/reject shop registrations<br>• Moderate content<br>• View analytics | • N/A for v1.0 |

### 3.2 Permission Matrix

```
Action                    | Student | Merchant | Admin (Future)
--------------------------|---------|----------|---------------
View Shop List            |    ✓    |    ✓     |      ✓
View Shop Details         |    ✓    |    ✓     |      ✓
Filter by Category        |    ✓    |    ✓     |      ✓
Register Account          |    ✗    |    ✓     |      ✗
Login/Logout              |    ✗    |    ✓     |      ✓
Create Shop               |    ✗    |    ✓     |      ✓
Edit Own Shop             |    ✗    |    ✓     |      ✓
Edit Any Shop             |    ✗    |    ✗     |      ✓
Delete Shop               |    ✗    |    ✗     |      ✓
View Analytics            |    ✗    |    ✗     |      ✓
```

---

## 4. Core Features

### 4.1 Category Browsing

**Description:** Students can explore shops organized by service categories.

**User Story:**  
*"As a student, I want to browse shops by category so that I can quickly find the type of service I need."*

**Acceptance Criteria:**
- Display 8+ predefined categories with representative icons
- Categories include: Motorbike Rentals, Optical Shops, Printing Services, Laundry, Food & Beverages, Stationary, Tailoring, Others
- Each category shows shop count
- Tapping a category filters the shop list
- Visual feedback on selected category

**Priority:** P0 (Must Have)

### 4.2 Shop Listing

**Description:** Display all shops or filtered shops in a scrollable, card-based layout.

**User Story:**  
*"As a student, I want to see a list of all available shops so that I can compare options."*

**Acceptance Criteria:**
- Display shop cards with thumbnail, name, category, and price range
- Support infinite scroll or pagination (20 shops per page)
- Show "Last Updated" timestamp
- Empty state when no shops match filter
- Loading skeleton during data fetch
- Pull-to-refresh functionality

**Priority:** P0 (Must Have)

### 4.3 Shop Detail View

**Description:** Comprehensive information page for individual shops.

**User Story:**  
*"As a student, I want to view detailed information about a shop so that I can make an informed decision."*

**Acceptance Criteria:**
- Display full shop information:
  - Shop name and category
  - High-resolution image gallery (swipeable)
  - Full description
  - Price range indicator (฿, ฿฿, ฿฿฿)
  - Contact information (phone, LINE ID, email)
  - Operating hours
  - Last updated timestamp
- "Open in Google Maps" button with deep linking
- Back navigation to previous screen
- Share shop functionality (future)

**Priority:** P0 (Must Have)

### 4.4 Merchant Authentication

**Description:** Secure login and registration system for merchant accounts.

**User Story:**  
*"As a merchant, I want to create an account so that I can manage my shop's digital presence."*

**Acceptance Criteria:**
- **Registration Form:**
  - Email (unique, validated)
  - Password (minimum 8 characters, alphanumeric)
  - Shop name
  - Contact phone number
  - Terms and conditions acceptance
- **Login Form:**
  - Email and password fields
  - "Remember me" option
  - "Forgot password" link (future)
- JWT token generation and storage
- Session persistence across app restarts
- Automatic token refresh before expiry
- Logout functionality with token invalidation

**Priority:** P0 (Must Have)

### 4.5 Merchant Dashboard

**Description:** Central hub for merchants to manage their shop profile.

**User Story:**  
*"As a merchant, I want a dashboard where I can view and edit my shop information easily."*

**Acceptance Criteria:**
- Display current shop information summary
- Quick action buttons:
  - Edit shop profile
  - Preview shop (as students see it)
  - View statistics (future)
  - Logout
- Confirmation messages for all actions
- Navigation menu with branded header
- Responsive layout for tablets

**Priority:** P0 (Must Have)

### 4.6 Shop Profile Management

**Description:** Form-based interface for creating and updating shop information.

**User Story:**  
*"As a merchant, I want to update my shop's information so that students see accurate details."*

**Acceptance Criteria:**
- **Form Fields:**
  - Shop name (required, max 100 chars)
  - Category selection (dropdown)
  - Description (required, max 500 chars, rich text support)
  - Price range (฿/฿฿/฿฿฿ selector)
  - Phone number (validated format)
  - LINE ID (optional)
  - Email (validated)
  - Operating hours (time picker)
  - Google Maps URL (validated URL format)
- **Image Upload:**
  - Support up to 5 images
  - Max 5MB per image
  - Auto-resize to optimize storage
  - Drag-to-reorder functionality
- Real-time validation with error messages
- Auto-save draft (local storage)
- "Save" and "Cancel" buttons
- Optimistic UI updates

**Priority:** P0 (Must Have)

### 4.7 Confirmation Screen

**Description:** Success feedback after shop profile updates.

**User Story:**  
*"As a merchant, I want confirmation that my changes were saved so that I have peace of mind."*

**Acceptance Criteria:**
- Display success message with checkmark icon
- Show updated information summary
- Buttons: "Back to Dashboard" and "Preview Shop"
- Auto-redirect to dashboard after 5 seconds
- Handle error states with retry option

**Priority:** P1 (Should Have)

---

## 5. Functional Requirements

### 5.1 Student User Flow

```
[1] App Launch
    ↓
[2] Home Screen (Category Grid)
    ↓
[3] User selects category
    ↓
[4] Shop List (Filtered)
    ↓
[5] User taps shop card
    ↓
[6] Shop Detail View
    ↓
[7] User views info, opens Google Maps, or returns
    ↓
[8] User can navigate back or select another category
```

**Detailed Steps:**

1. **App Launch:**
   - Load cached shop data if available
   - Fetch latest shop data from API in background
   - No authentication check required
   - Direct to home screen

2. **Home Screen:**
   - Display 8 category cards in 2-column grid
   - Show category icons and shop counts
   - Header with app logo and search icon (future)

3. **Category Selection:**
   - Apply visual feedback (highlight selected category)
   - Navigate to shop list with category filter
   - Update URL for deep linking (web only)

4. **Shop List:**
   - Fetch shops matching selected category
   - Display loading state during fetch
   - Render shop cards with key information
   - Allow scroll and pull-to-refresh

5. **Shop Detail:**
   - Fetch complete shop information by ID
   - Display image gallery at top
   - Render all shop metadata
   - Enable Google Maps integration

**Error Handling:**
- Network timeout: Show cached data with offline indicator
- Empty results: Display friendly empty state with illustration
- API errors: Show retry button with error message

### 5.2 Merchant User Flow

```
[1] App Launch
    ↓
[2] Check authentication status
    ↓
    ├── Not Authenticated
    │   ↓
    │   [3a] Show Login/Register Screen
    │   ↓
    │   [4a] User logs in or registers
    │   ↓
    │   [5a] JWT token stored
    │   ↓
    └── Authenticated
        ↓
[3b] Merchant Dashboard
    ↓
[4b] User selects "Edit Shop Profile"
    ↓
[5b] Shop Management Form (pre-filled)
    ↓
[6b] User updates information and saves
    ↓
[7b] API PUT request with JWT token
    ↓
[8b] Confirmation Screen
    ↓
[9b] Return to Dashboard or Preview Shop
```

**Detailed Steps:**

1. **Authentication Check:**
   - Retrieve JWT from secure storage
   - Validate token expiry
   - If expired: refresh token or redirect to login
   - If valid: fetch merchant's shop data

2. **Login/Register:**
   - Toggle between login and register forms
   - Validate input fields client-side
   - Submit credentials to API
   - Receive JWT and user role
   - Store token securely (Flutter Secure Storage)

3. **Merchant Dashboard:**
   - Display merchant's shop summary card
   - Show action buttons with icons
   - Display last updated timestamp
   - Provide logout option in menu

4. **Edit Shop Profile:**
   - Load existing shop data into form
   - Enable all form fields
   - Validate on blur and on submit
   - Allow draft saving to local storage

5. **Save Changes:**
   - Validate all required fields
   - Show loading indicator
   - Send PUT request with Authorization header
   - Handle success and error responses

6. **Confirmation:**
   - Display success animation
   - Show summary of updated fields
   - Provide navigation options
   - Update local cache

### 5.3 Role-Based Navigation Logic

**Routing Rules:**

| Route | Student Access | Merchant Access | Redirect Logic |
|-------|---------------|-----------------|----------------|
| `/` (Home) | ✓ Allow | ✓ Allow | None |
| `/category/:id` | ✓ Allow | ✓ Allow | None |
| `/shop/:id` | ✓ Allow | ✓ Allow | None |
| `/login` | ⚠️ Not needed | ✓ Allow | If authenticated → `/dashboard` |
| `/register` | ⚠️ Not needed | ✓ Allow | If authenticated → `/dashboard` |
| `/dashboard` | ✗ Deny | ✓ Allow | If not authenticated → `/login` |
| `/shop/edit` | ✗ Deny | ✓ Allow | If not authenticated → `/login` |

**Implementation:**
- Use GoRouter with guards
- Check authentication token on protected routes
- Store intended destination for post-login redirect
- Show 403 error for unauthorized access attempts

### 5.4 Authentication Flow (JWT)

**Token Lifecycle:**

1. **Token Generation (Backend):**
   ```
   POST /api/v1/auth/login
   → Verify credentials
   → Generate JWT (expiry: 7 days)
   → Return { token, refreshToken, user }
   ```

2. **Token Storage (Frontend):**
   ```
   Receive token
   → Store in FlutterSecureStorage
   → Store user role in memory
   → Navigate to dashboard
   ```

3. **Token Usage:**
   ```
   Protected API call
   → Retrieve token from storage
   → Add to Authorization header: "Bearer {token}"
   → Send request
   ```

4. **Token Validation:**
   ```
   On app launch
   → Retrieve token
   → Check expiry (decode JWT)
   → If expired: attempt refresh
   → If refresh fails: logout
   ```

5. **Token Refresh:**
   ```
   POST /api/v1/auth/refresh
   → Send refreshToken
   → Receive new token
   → Update storage
   ```

6. **Logout:**
   ```
   User clicks logout
   → Delete token from storage
   → Clear user state
   → Navigate to home
   → (Optional) Invalidate token on backend
   ```

---

## 6. Data Model

### 6.1 Shop Entity

**JSON Schema:**

```json
{
  "id": "string (UUID)",
  "name": "string (required, max 100)",
  "category": "string (enum: motorbike-rental | optical | printing | laundry | food | stationary | tailoring | others)",
  "description": "string (required, max 500)",
  "priceRange": "number (1-3, where 1=฿, 2=฿฿, 3=฿฿฿)",
  "images": [
    {
      "id": "string (UUID)",
      "url": "string (CDN URL)",
      "thumbnailUrl": "string (CDN URL)",
      "order": "number",
      "uploadedAt": "string (ISO 8601)"
    }
  ],
  "contact": {
    "phone": "string (required, format: +66XXXXXXXXX)",
    "lineId": "string (optional)",
    "email": "string (required, email format)"
  },
  "operatingHours": {
    "monday": { "open": "08:00", "close": "20:00", "closed": false },
    "tuesday": { "open": "08:00", "close": "20:00", "closed": false },
    "wednesday": { "open": "08:00", "close": "20:00", "closed": false },
    "thursday": { "open": "08:00", "close": "20:00", "closed": false },
    "friday": { "open": "08:00", "close": "20:00", "closed": false },
    "saturday": { "open": "09:00", "close": "18:00", "closed": false },
    "sunday": { "open": "00:00", "close": "00:00", "closed": true }
  },
  "googleMapsUrl": "string (required, URL format)",
  "ownerId": "string (UUID, foreign key to User)",
  "status": "string (enum: active | pending | suspended)",
  "viewCount": "number (default: 0)",
  "createdAt": "string (ISO 8601)",
  "lastUpdated": "string (ISO 8601)"
}
```

**Example:**

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "MFU Bike Rental",
  "category": "motorbike-rental",
  "description": "Affordable motorbike rentals for MFU students. Daily and monthly plans available. Well-maintained bikes with insurance coverage.",
  "priceRange": 2,
  "images": [
    {
      "id": "img-001",
      "url": "https://cdn.m-link.com/shops/mfu-bike/hero.jpg",
      "thumbnailUrl": "https://cdn.m-link.com/shops/mfu-bike/hero-thumb.jpg",
      "order": 1,
      "uploadedAt": "2026-02-15T10:30:00Z"
    }
  ],
  "contact": {
    "phone": "+66812345678",
    "lineId": "@mfubike",
    "email": "info@mfubikerental.com"
  },
  "operatingHours": {
    "monday": { "open": "08:00", "close": "18:00", "closed": false },
    "tuesday": { "open": "08:00", "close": "18:00", "closed": false },
    "wednesday": { "open": "08:00", "close": "18:00", "closed": false },
    "thursday": { "open": "08:00", "close": "18:00", "closed": false },
    "friday": { "open": "08:00", "close": "18:00", "closed": false },
    "saturday": { "open": "09:00", "close": "15:00", "closed": false },
    "sunday": { "open": "00:00", "close": "00:00", "closed": true }
  },
  "googleMapsUrl": "https://goo.gl/maps/mfubikerental",
  "ownerId": "user-12345",
  "status": "active",
  "viewCount": 247,
  "createdAt": "2026-01-10T09:00:00Z",
  "lastUpdated": "2026-02-20T14:22:00Z"
}
```

### 6.2 User Entity

**JSON Schema:**

```json
{
  "userId": "string (UUID)",
  "name": "string (required, max 100)",
  "email": "string (required, unique, email format)",
  "passwordHash": "string (backend only, never exposed to frontend)",
  "role": "string (enum: student | merchant | admin)",
  "shopId": "string (UUID, nullable, references Shop.id)",
  "phone": "string (required for merchants)",
  "isVerified": "boolean (default: false)",
  "isActive": "boolean (default: true)",
  "createdAt": "string (ISO 8601)",
  "lastLogin": "string (ISO 8601)"
}
```

**Frontend Token Payload (JWT):**

```json
{
  "userId": "user-12345",
  "email": "merchant@example.com",
  "role": "merchant",
  "shopId": "550e8400-e29b-41d4-a716-446655440000",
  "iat": 1709035200,
  "exp": 1709639999
}
```

**Example User Object (API Response):**

```json
{
  "userId": "user-12345",
  "name": "Somchai Vendor",
  "email": "somchai@mfubikerental.com",
  "role": "merchant",
  "shopId": "550e8400-e29b-41d4-a716-446655440000",
  "phone": "+66812345678",
  "isVerified": true,
  "isActive": true,
  "createdAt": "2026-01-10T09:00:00Z",
  "lastLogin": "2026-02-27T08:15:00Z"
}
```

### 6.3 Category Entity (Static)

**JSON Schema:**

```json
{
  "id": "string (slug)",
  "name": "string (display name)",
  "icon": "string (icon identifier or emoji)",
  "description": "string",
  "order": "number (display order)"
}
```

**Predefined Categories:**

```json
[
  {
    "id": "motorbike-rental",
    "name": "Motorbike Rentals",
    "icon": "🏍️",
    "description": "Daily and monthly bike rental services",
    "order": 1
  },
  {
    "id": "optical",
    "name": "Optical Shops",
    "icon": "👓",
    "description": "Eyeglasses, contact lenses, and eye exams",
    "order": 2
  },
  {
    "id": "printing",
    "name": "Printing Services",
    "icon": "🖨️",
    "description": "Document printing, binding, and photocopying",
    "order": 3
  },
  {
    "id": "laundry",
    "name": "Laundry & Dry Cleaning",
    "icon": "👕",
    "description": "Wash, dry, iron, and dry cleaning services",
    "order": 4
  },
  {
    "id": "food",
    "name": "Food & Beverages",
    "icon": "🍜",
    "description": "Restaurants, cafes, and food delivery",
    "order": 5
  },
  {
    "id": "stationary",
    "name": "Stationary Shops",
    "icon": "📚",
    "description": "Books, pens, notebooks, and office supplies",
    "order": 6
  },
  {
    "id": "tailoring",
    "name": "Tailoring & Alterations",
    "icon": "✂️",
    "description": "Clothing alterations and custom tailoring",
    "order": 7
  },
  {
    "id": "others",
    "name": "Other Services",
    "icon": "🏪",
    "description": "Miscellaneous shops and services",
    "order": 8
  }
]
```

---

## 7. API Requirements

### 7.1 Base URL

```
Production: https://api.m-link.app/api/v1
Development: http://localhost:8080/api/v1
```

### 7.2 Authentication Endpoints

#### 7.2.1 POST /auth/register

**Description:** Create a new merchant account.

**Request:**
```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "name": "Somchai Vendor",
  "email": "somchai@example.com",
  "password": "SecurePass123!",
  "phone": "+66812345678",
  "shopName": "MFU Bike Rental",
  "agreeToTerms": true
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Account created successfully",
  "data": {
    "user": {
      "userId": "user-12345",
      "name": "Somchai Vendor",
      "email": "somchai@example.com",
      "role": "merchant",
      "shopId": null
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "refresh_token_here"
  }
}
```

**Error Response (400 Bad Request):**
```json
{
  "success": false,
  "error": {
    "code": "EMAIL_EXISTS",
    "message": "Email address is already registered",
    "field": "email"
  }
}
```

#### 7.2.2 POST /auth/login

**Description:** Authenticate merchant and receive JWT token.

**Request:**
```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "somchai@example.com",
  "password": "SecurePass123!"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "user": {
      "userId": "user-12345",
      "name": "Somchai Vendor",
      "email": "somchai@example.com",
      "role": "merchant",
      "shopId": "550e8400-e29b-41d4-a716-446655440000"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "refresh_token_here",
    "expiresAt": "2026-03-06T10:30:00Z"
  }
}
```

**Error Response (401 Unauthorized):**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Invalid email or password"
  }
}
```

#### 7.2.3 POST /auth/refresh

**Description:** Refresh expired JWT token.

**Request:**
```http
POST /api/v1/auth/refresh
Content-Type: application/json

{
  "refreshToken": "refresh_token_here"
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "token": "new_jwt_token_here",
    "expiresAt": "2026-03-13T10:30:00Z"
  }
}
```

### 7.3 Shop Endpoints

#### 7.3.1 GET /shops

**Description:** Retrieve list of shops with optional filtering.

**Query Parameters:**
- `category` (string, optional): Filter by category slug
- `page` (number, optional, default: 1): Page number
- `limit` (number, optional, default: 20): Items per page
- `search` (string, optional): Search by shop name
- `status` (string, optional, default: active): Filter by status

**Request:**
```http
GET /api/v1/shops?category=motorbike-rental&page=1&limit=20
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "shops": [
      {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "name": "MFU Bike Rental",
        "category": "motorbike-rental",
        "description": "Affordable motorbike rentals...",
        "priceRange": 2,
        "images": [
          {
            "thumbnailUrl": "https://cdn.m-link.com/shops/mfu-bike/hero-thumb.jpg",
            "order": 1
          }
        ],
        "lastUpdated": "2026-02-20T14:22:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 45,
      "itemsPerPage": 20
    }
  }
}
```

#### 7.3.2 GET /shops/:id

**Description:** Retrieve detailed information for a specific shop.

**Request:**
```http
GET /api/v1/shops/550e8400-e29b-41d4-a716-446655440000
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "name": "MFU Bike Rental",
    "category": "motorbike-rental",
    "description": "Affordable motorbike rentals for MFU students...",
    "priceRange": 2,
    "images": [
      {
        "id": "img-001",
        "url": "https://cdn.m-link.com/shops/mfu-bike/hero.jpg",
        "thumbnailUrl": "https://cdn.m-link.com/shops/mfu-bike/hero-thumb.jpg",
        "order": 1
      }
    ],
    "contact": {
      "phone": "+66812345678",
      "lineId": "@mfubike",
      "email": "info@mfubikerental.com"
    },
    "operatingHours": {
      "monday": { "open": "08:00", "close": "18:00", "closed": false }
    },
    "googleMapsUrl": "https://goo.gl/maps/mfubikerental",
    "status": "active",
    "viewCount": 247,
    "createdAt": "2026-01-10T09:00:00Z",
    "lastUpdated": "2026-02-20T14:22:00Z"
  }
}
```

**Error Response (404 Not Found):**
```json
{
  "success": false,
  "error": {
    "code": "SHOP_NOT_FOUND",
    "message": "Shop with the specified ID does not exist"
  }
}
```

#### 7.3.3 POST /shops

**Description:** Create a new shop (requires authentication).

**Request:**
```http
POST /api/v1/shops
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json

{
  "name": "MFU Bike Rental",
  "category": "motorbike-rental",
  "description": "Affordable motorbike rentals for MFU students...",
  "priceRange": 2,
  "contact": {
    "phone": "+66812345678",
    "lineId": "@mfubike",
    "email": "info@mfubikerental.com"
  },
  "operatingHours": {
    "monday": { "open": "08:00", "close": "18:00", "closed": false }
  },
  "googleMapsUrl": "https://goo.gl/maps/mfubikerental"
}
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Shop created successfully",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "name": "MFU Bike Rental",
    "status": "pending",
    "createdAt": "2026-02-27T10:00:00Z"
  }
}
```

**Error Response (403 Forbidden):**
```json
{
  "success": false,
  "error": {
    "code": "SHOP_LIMIT_REACHED",
    "message": "You already have a shop. Only one shop per merchant is allowed."
  }
}
```

#### 7.3.4 PUT /shops/:id

**Description:** Update existing shop information (requires authentication and ownership).

**Request:**
```http
PUT /api/v1/shops/550e8400-e29b-41d4-a716-446655440000
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json

{
  "name": "MFU Premium Bike Rental",
  "description": "Updated description with new services...",
  "priceRange": 3,
  "contact": {
    "phone": "+66812345678",
    "lineId": "@mfubike",
    "email": "info@mfubikerental.com"
  }
}
```

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Shop updated successfully",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "name": "MFU Premium Bike Rental",
    "lastUpdated": "2026-02-27T11:30:00Z"
  }
}
```

**Error Response (403 Forbidden):**
```json
{
  "success": false,
  "error": {
    "code": "UNAUTHORIZED_ACCESS",
    "message": "You do not have permission to edit this shop"
  }
}
```

#### 7.3.5 POST /shops/:id/images

**Description:** Upload images for a shop (requires authentication and ownership).

**Request:**
```http
POST /api/v1/shops/550e8400-e29b-41d4-a716-446655440000/images
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: multipart/form-data

file: [binary data]
order: 1
```

**Response (201 Created):**
```json
{
  "success": true,
  "message": "Image uploaded successfully",
  "data": {
    "id": "img-002",
    "url": "https://cdn.m-link.com/shops/mfu-bike/image-2.jpg",
    "thumbnailUrl": "https://cdn.m-link.com/shops/mfu-bike/image-2-thumb.jpg",
    "order": 1,
    "uploadedAt": "2026-02-27T11:45:00Z"
  }
}
```

### 7.4 Category Endpoints

#### 7.4.1 GET /categories

**Description:** Retrieve all available categories.

**Request:**
```http
GET /api/v1/categories
```

**Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": "motorbike-rental",
      "name": "Motorbike Rentals",
      "icon": "🏍️",
      "description": "Daily and monthly bike rental services",
      "shopCount": 12,
      "order": 1
    },
    {
      "id": "optical",
      "name": "Optical Shops",
      "icon": "👓",
      "description": "Eyeglasses, contact lenses, and eye exams",
      "shopCount": 8,
      "order": 2
    }
  ]
}
```

### 7.5 Error Response Standards

All error responses follow this structure:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "field": "fieldName (optional, for validation errors)",
    "details": {} (optional, additional context)
  }
}
```

**Common Error Codes:**

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `VALIDATION_ERROR` | 400 | Request data failed validation |
| `INVALID_CREDENTIALS` | 401 | Login credentials incorrect |
| `UNAUTHORIZED` | 401 | JWT token missing or invalid |
| `FORBIDDEN` | 403 | User lacks permission for action |
| `NOT_FOUND` | 404 | Resource does not exist |
| `EMAIL_EXISTS` | 409 | Email already registered |
| `SHOP_LIMIT_REACHED` | 409 | Merchant already has a shop |
| `INTERNAL_ERROR` | 500 | Server-side error |
| `SERVICE_UNAVAILABLE` | 503 | Service temporarily down |

---

## 8. State Management

### 8.1 Global State (Application-Wide)

**Managed via:** Provider / Riverpod / Bloc (to be decided)

**State Variables:**

```dart
// Authentication State
class AuthState {
  final String? token;
  final String? refreshToken;
  final User? currentUser;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
}

// Shop Data Cache State
class ShopCacheState {
  final List<Shop> shops;
  final Map<String, Shop> shopById;
  final DateTime? lastFetched;
  final bool isStale;
}

// Merchant Shop State
class MerchantShopState {
  final Shop? myShop;
  final bool isLoading;
  final String? error;
  final bool hasUnsavedChanges;
}

// Network State
class NetworkState {
  final bool isOnline;
  final DateTime? lastOnline;
}
```

**State Actions:**

```dart
// Auth Actions
- login(email, password)
- register(userData)
- logout()
- refreshToken()
- checkAuthStatus()

// Shop Actions
- fetchShops({category, page})
- fetchShopById(id)
- createShop(shopData)
- updateShop(id, shopData)
- uploadShopImage(shopId, imageFile)
- deleteShopImage(shopId, imageId)

// Cache Actions
- invalidateCache()
- updateCacheItem(shop)
```

### 8.2 Local State (Screen/Widget-Level)

**Managed via:** StatefulWidget, useState (hooks), or local controllers

**Examples:**

```dart
// Shop List Screen
class ShopListState {
  String selectedCategory = 'all';
  int currentPage = 1;
  bool isLoadingMore = false;
  List<Shop> displayedShops = [];
}

// Shop Detail Screen
class ShopDetailState {
  int currentImageIndex = 0;
  bool isLoadingMap = false;
}

// Shop Form Screen
class ShopFormState {
  Map<String, dynamic> formData = {};
  Map<String, String?> validationErrors = {};
  List<File> selectedImages = [];
  bool isSaving = false;
  bool hasUnsavedChanges = false;
}

// Search Functionality (Future)
class SearchState {
  String searchQuery = '';
  bool isSearching = false;
  List<Shop> searchResults = [];
}
```

### 8.3 Persistence Strategy

**Permanent Storage:**
- **JWT Token:** Secure Storage (flutter_secure_storage)
- **User Preferences:** Shared Preferences (theme, language)
- **Cached Shop Data:** Local Database (sqflite) or Hive

**Temporary Storage:**
- **Form Drafts:** Local Storage (persisted until submission)
- **Image Selections:** In-memory until upload complete

**Cache Invalidation Rules:**
- Shop list cache: 5 minutes TTL
- Individual shop cache: 1 hour TTL
- Force refresh on pull-to-refresh gesture
- Clear cache on logout

---

## 9. Offline Strategy

### 9.1 Offline Capabilities

**Read-Only Features:**
- View cached shop listings
- View cached shop details
- Browse categories (static data)
- View previously loaded images

**Disabled Features:**
- Login/Register (requires network)
- Create/Update shop (requires network)
- Upload images (requires network)
- Real-time data sync

### 9.2 Implementation Approach

**Network Detection:**
```dart
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  Stream<bool> get onlineStatus => 
    Connectivity().onConnectivityChanged
      .map((result) => result != ConnectivityResult.none);
}
```

**UI Indicators:**
- **Top Banner:** Display "Offline Mode" banner with orange background
- **Disabled Actions:** Gray out buttons that require network
- **Warning Messages:** Show alert before attempting network-dependent actions
- **Stale Data Indicator:** Show timestamp of last successful data fetch

**Caching Strategy:**
```dart
// Fetch with cache fallback
Future<List<Shop>> fetchShops({String? category}) async {
  try {
    // Attempt network fetch
    final shops = await apiService.getShops(category: category);
    
    // Update cache on success
    await cacheService.saveShops(shops);
    
    return shops;
  } catch (e) {
    // Fallback to cache on failure
    final cachedShops = await cacheService.getShops(category: category);
    
    if (cachedShops.isEmpty) {
      throw Exception('No cached data available');
    }
    
    return cachedShops;
  }
}
```

### 9.3 Sync Strategy (Future Enhancement)

**Deferred Actions Queue:**
- Queue shop updates when offline
- Auto-sync when connection restored
- Conflict resolution (server wins)
- User notification of sync status

---

## 10. Non-Functional Requirements

### 10.1 Performance

**Load Time Targets:**
- Initial app load: < 3 seconds (on 4G connection)
- Category to shop list navigation: < 1 second
- Shop detail page render: < 2 seconds
- Image loading: Progressive (blur-to-sharp), < 3 seconds
- API response time: < 500ms (95th percentile)

**Optimization Techniques:**
- Image lazy loading and compression (WebP format)
- API response caching with TTL
- Pagination for long lists (20 items per page)
- Code splitting for web version
- Asset preloading for critical resources

**Scalability:**
- Support 1,000+ concurrent users
- Handle database with 500+ shops
- Maintain performance with 5,000+ shop views per day

### 10.2 Security

**Authentication Security:**
- Passwords hashed using bcrypt (cost factor: 12)
- JWT tokens with 7-day expiry
- HTTPS-only API communication
- Secure storage for tokens (FlutterSecureStorage)
- Password requirements: 8+ chars, alphanumeric

**API Security:**
- Rate limiting: 100 requests per minute per IP
- JWT signature verification on all protected endpoints
- Input validation and sanitization
- SQL injection prevention (parameterized queries)
- XSS prevention (output encoding)

**Data Privacy:**
- No storage of sensitive payment information
- Merchant email verification required
- Option to hide phone number (future)
- GDPR-compliant data handling (if applicable)

**Authorization:**
- Shop owners can only edit their own shops
- JWT payload contains user role and shopId
- Backend validates ownership before mutations
- No client-side authorization logic

### 10.3 Usability

**User Interface:**
- Mobile-first responsive design
- Minimum touch target: 48x48dp (Android), 44x44pt (iOS)
- High contrast ratio (WCAG AA compliant)
- Consistent navigation patterns (bottom nav or drawer)
- Clear error messages with recovery actions

**Accessibility:**
- Screen reader support (semantic labels)
- Keyboard navigation for web version
- Alternative text for images
- Color-blind friendly palette

**Internationalization (Future):**
- Support Thai and English languages
- Right-to-left layout support (if needed)
- Localized date/time formats
- Currency formatting (Thai Baht)

**User Feedback:**
- Loading indicators for async operations
- Success/error toast messages
- Form validation with inline error messages
- Confirmation dialogs for destructive actions
- Pull-to-refresh for data updates

### 10.4 Reliability

**Uptime Target:** 99.5% (excluding planned maintenance)

**Error Handling:**
- Graceful degradation on API failures
- Automatic retry for transient errors (3 attempts, exponential backoff)
- Comprehensive error logging (Sentry integration)
- User-friendly error messages

**Data Integrity:**
- Database transactions for critical operations
- Soft deletes for shops (retain for 30 days)
- Automatic database backups (daily)
- Validation at API and database layers

### 10.5 Maintainability

**Code Quality:**
- Consistent code style (Dart lint rules)
- Minimum 70% test coverage
- Comprehensive inline documentation
- Modular architecture (feature-based folders)

**Version Control:**
- Git with semantic versioning (SemVer)
- Feature branch workflow
- Pull request reviews required
- Automated CI/CD pipeline

**Monitoring:**
- Application performance monitoring (Firebase Performance)
- Crash reporting (Firebase Crashlytics)
- Analytics (user flows, feature usage)
- API logging (requests, response times, errors)

---

## 11. Risks and Mitigation

### 11.1 AI-Generated Logic Issues

**Risk Description:**  
Code generated by AI assistants may contain logical errors, security vulnerabilities, or inefficient implementations that are not immediately apparent during development.

**Impact:** High  
**Probability:** Medium

**Mitigation Strategies:**
1. **Code Review Process:**
   - Mandatory peer review for all AI-generated code
   - Senior developer validation before merging
   - Focus on authentication, authorization, and data handling logic

2. **Testing:**
   - Comprehensive unit tests for business logic
   - Integration tests for API endpoints
   - End-to-end tests for critical user flows
   - Security penetration testing

3. **Documentation:**
   - Document all AI-generated code with comments
   - Maintain changelog of AI-assisted implementations
   - Create technical debt log for refactoring needs

4. **Incremental Adoption:**
   - Start with non-critical features
   - Validate AI-generated code in staging environment
   - Gradual rollout with monitoring

### 11.2 Security Vulnerabilities

**Risk Description:**  
Potential security breaches including unauthorized access to merchant accounts, data leaks, or malicious shop profile submissions.

**Impact:** Critical  
**Probability:** Medium

**Mitigation Strategies:**
1. **Authentication Hardening:**
   - Implement rate limiting on login attempts (5 attempts per 15 minutes)
   - Add CAPTCHA for registration (Google reCAPTCHA)
   - Require email verification before shop creation
   - Implement two-factor authentication (future enhancement)

2. **Input Validation:**
   - Server-side validation for all inputs
   - Sanitize user-generated content (descriptions, shop names)
   - File upload restrictions (type, size, malware scanning)
   - URL validation for Google Maps links

3. **API Security:**
   - HTTPS enforcement (redirect HTTP to HTTPS)
   - JWT token rotation on sensitive actions
   - CORS policy restrictions
   - API versioning for backwards compatibility

4. **Monitoring:**
   - Real-time alerts for suspicious activities
   - Regular security audits (quarterly)
   - Automated vulnerability scanning (OWASP ZAP)
   - Incident response plan documentation

### 11.3 Role-Based Access Mistakes

**Risk Description:**  
Incorrect implementation of role checks could allow students to access merchant features or merchants to edit other merchants' shops.

**Impact:** High  
**Probability:** Medium

**Mitigation Strategies:**
1. **Backend Enforcement:**
   - Never trust client-side role checks
   - Validate JWT on every protected endpoint
   - Verify shop ownership before mutations
   - Use middleware for role-based route protection

2. **Testing:**
   - Create test cases for unauthorized access attempts
   - Test all combinations of user roles and endpoints
   - Automated security testing in CI/CD pipeline

3. **Audit Logging:**
   - Log all shop modifications with userId and timestamp
   - Track failed authorization attempts
   - Regular audit log reviews

### 11.4 Scalability Limitations

**Risk Description:**  
Application may not handle rapid user growth or increased data volume efficiently.

**Impact:** Medium  
**Probability:** Medium

**Mitigation Strategies:**
1. **Architecture:**
   - Design API with horizontal scaling in mind
   - Use CDN for static assets and images
   - Implement database indexing on frequently queried fields
   - Plan for database sharding (future)

2. **Monitoring:**
   - Set up performance monitoring dashboards
   - Define performance SLIs and SLOs
   - Load testing before major releases (Apache JMeter)
   - Capacity planning based on growth projections

3. **Optimization:**
   - Implement caching layers (Redis for API responses)
   - Database query optimization
   - Lazy loading and pagination
   - Background job processing for heavy tasks

### 11.5 User Adoption Challenges

**Risk Description:**  
Low adoption rate among students or merchants due to lack of awareness or perceived value.

**Impact:** High  
**Probability:** Medium

**Mitigation Strategies:**
1. **Marketing:**
   - Campus awareness campaigns (posters, social media)
   - Partnerships with student organizations
   - Incentives for early adopter merchants (featured listings)

2. **Onboarding:**
   - Simplified merchant registration flow
   - Video tutorials for shop management
   - In-app help and tooltips
   - Responsive customer support (LINE, email)

3. **Feedback Loop:**
   - Collect user feedback through in-app surveys
   - Regular feature prioritization based on user needs
   - Beta testing program with student volunteers

4. **Value Proposition:**
   - Free service for both students and merchants
   - Clear benefits communication (save time, increase visibility)
   - Success stories and testimonials

### 11.6 Data Quality Issues

**Risk Description:**  
Merchants may submit incomplete, outdated, or misleading information, degrading user trust.

**Impact:** Medium  
**Probability:** High

**Mitigation Strategies:**
1. **Validation:**
   - Required fields enforcement
   - Field length and format validation
   - Image quality requirements (minimum resolution)

2. **Moderation:**
   - Manual approval queue for new shops (v1.0)
   - Automated content moderation (AI-based, future)
   - User reporting mechanism
   - Expiry warnings for outdated listings (90 days)

3. **Incentives:**
   - Highlight "Recently Updated" shops
   - Ranking algorithm favoring complete profiles
   - Merchant dashboard reminders to update information

---

## 12. Success Metrics

### 12.1 Key Performance Indicators (KPIs)

**User Acquisition:**
- Target: 500+ student users within 3 months of launch
- Target: 50+ registered merchants within 3 months
- Metric: Daily active users (DAU) and monthly active users (MAU)

**Engagement:**
- Target: 3+ shop views per student session
- Target: 70% of students visit app weekly
- Target: 50% of merchants update shop info monthly
- Metric: Session duration, bounce rate, feature usage

**Business Value:**
- Target: 80% merchant satisfaction rate
- Target: 90% student find-success rate
- Metric: Surveys, retention rate, referral rate

**Technical Performance:**
- Target: < 2 second average page load time
- Target: 99.5% uptime
- Target: < 1% error rate
- Metric: Performance monitoring, error logs

### 12.2 Evaluation Criteria

**Phase 1 (Month 1-3):** MVP Launch
- ✓ Core features implemented and tested
- ✓ 30+ active shops across 5+ categories
- ✓ 200+ weekly active student users
- ✓ < 5 critical bugs reported

**Phase 2 (Month 4-6):** Growth
- ✓ 100+ active shops
- ✓ 1,000+ weekly active users
- ✓ Search functionality implemented
- ✓ User reviews and ratings (future feature)

**Phase 3 (Month 7-12):** Maturity
- ✓ 200+ active shops
- ✓ 3,000+ weekly active users
- ✓ Mobile apps (iOS and Android native)
- ✓ Advanced analytics for merchants

---

## 13. Development Roadmap

### 13.1 Phase 1: MVP (Weeks 1-8)

**Week 1-2: Setup & Planning**
- Finalize PRD and design mockups
- Set up development environment
- Initialize Flutter project
- Set up CI/CD pipeline

**Week 3-4: Core Features**
- Implement authentication (login, register, JWT)
- Create shop data models and API integration
- Build category browsing UI
- Build shop listing UI

**Week 5-6: Merchant Features**
- Build merchant dashboard
- Implement shop creation form
- Implement shop editing functionality
- Integrate image upload

**Week 7: Testing & Refinement**
- Unit and integration testing
- Bug fixes
- Performance optimization
- Security audit

**Week 8: Deployment**
- Deploy backend to production server
- Deploy frontend to Firebase Hosting
- Set up monitoring and analytics
- Soft launch with beta testers

### 13.2 Phase 2: Enhancement (Weeks 9-16)

- Search functionality
- Shop favoriting system
- User reviews and ratings
- Push notifications for shop updates
- Admin panel for content moderation
- Advanced shop analytics

### 13.3 Phase 3: Expansion (Weeks 17-24)

- Native mobile apps (iOS and Android)
- Multi-language support (Thai, English)
- Booking/reservation system integration
- In-app messaging between students and merchants
- Promotional features for merchants
- AI-powered shop recommendations

---

## 14. Appendix

### 14.1 Glossary

| Term | Definition |
|------|------------|
| **JWT** | JSON Web Token - A compact, URL-safe token format for securely transmitting information between parties |
| **PWA** | Progressive Web App - Web application that can function like a native mobile app |
| **REST API** | Representational State Transfer Application Programming Interface |
| **CDN** | Content Delivery Network - Distributed server network for fast content delivery |
| **TTL** | Time To Live - Duration for which data is considered valid in cache |
| **SLI** | Service Level Indicator - Measurement of service behavior |
| **SLO** | Service Level Objective - Target value for an SLI |

### 14.2 References

- Flutter Documentation: https://flutter.dev/docs
- Firebase Hosting Guide: https://firebase.google.com/docs/hosting
- JWT Best Practices: https://tools.ietf.org/html/rfc8725
- GoRouter Documentation: https://pub.dev/packages/go_router
- OWASP Security Guidelines: https://owasp.org/www-project-top-ten/

### 14.3 Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-27 | Product Manager | Initial PRD creation |

---

**Document Status:** APPROVED  
**Next Review Date:** 2026-03-27

---

*This document is maintained by the M-Link product team and is subject to updates as requirements evolve.*
