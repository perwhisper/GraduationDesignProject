# Graduation Project Collaborative Guidance Platform (AI Enhanced) - Technical Design

## 1. Project Overview
A multi-role collaborative guidance platform for graduation projects, supporting Students, Teachers, and Administrators. Features include full-process management (topic selection to defense), AI-enhanced tools (topic recommendation, writing assistant, document review), and multi-dimensional evaluation.

## 2. Technical Architecture

### 2.1 Backend (Java Monolithic)
- **Framework**: Spring Boot 3.x + MyBatis-Plus
- **Security**: Spring Security + JWT
- **Database**: MySQL 8.0
- **Tools**: Lombok, WebSocket, AI Integration Layer
- **Build**: Maven

### 2.2 Frontend (Vue3)
- **Framework**: Vue 3 + Vite + TypeScript
- **UI Library**: Element Plus
- **State Management**: Pinia
- **Routing**: Vue Router

## 3. Database Schema Design

### 3.1 Core Tables

#### `sys_user` (User Info)
| Field | Type | Description |
|---|---|---|
| id | BIGINT | Primary Key |
| username | VARCHAR | Login Account |
| password | VARCHAR | BCrypt Encrypted |
| name | VARCHAR | Real Name |
| role | VARCHAR | ROLE_STUDENT, ROLE_TEACHER, ROLE_ADMIN |
| college | VARCHAR | College Name |
| major | VARCHAR | Major Name |
| created_at | DATETIME | Creation Time |

#### `document_info` (Document Management)
| Field | Type | Description |
|---|---|---|
| id | BIGINT | Primary Key |
| student_id | BIGINT | Foreign Key (sys_user) |
| stage | VARCHAR | e.g., PROPOSAL, DRAFT, FINAL |
| status | VARCHAR | PENDING, APPROVED, REJECTED |
| file_path | VARCHAR | Storage Path |
| submit_time | DATETIME | Submission Time |

#### `question` (Interaction)
| Field | Type | Description |
|---|---|---|
| id | BIGINT | Primary Key |
| student_id | BIGINT | FK |
| teacher_id | BIGINT | FK |
| content | TEXT | Question Content |
| status | INT | 0: Unanswered, 1: Answered |
| created_at | DATETIME | |

#### `evaluation_teacher` (Teacher Evaluation)
| Field | Type | Description |
|---|---|---|
| id | BIGINT | Primary Key |
| student_id | BIGINT | FK |
| teacher_id | BIGINT | FK |
| star | INT | 1-5 Rating |
| comment | TEXT | |

## 4. API Structure

### 4.1 Auth Module (`/api/auth`)
- `POST /login`: User login, returns JWT.
- `POST /register`: User registration.

### 4.2 Document Module (`/api/documents`)
- `POST /upload`: Upload file (multipart).
- `GET /list`: List documents by stage/user.
- `POST /audit`: Teacher reviews document.

### 4.3 AI Module (`/api/ai`)
- `POST /recommend-topic`: Generate topic suggestions.
- `POST /review`: AI document review.
- `POST /write-assist`: AI writing assistance.

## 5. Deployment
- **Docker**: `Dockerfile` for backend (Java 17) and frontend (Nginx).
- **Compose**: `docker-compose.yml` orchestration for App + MySQL.
