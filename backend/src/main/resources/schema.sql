-- User Table
CREATE TABLE IF NOT EXISTS sys_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL COMMENT 'ROLE_STUDENT, ROLE_TEACHER, ROLE_ADMIN',
    college VARCHAR(100),
    major VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_phone (phone),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Document Info Table
CREATE TABLE IF NOT EXISTS document_info (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    stage VARCHAR(50) NOT NULL COMMENT 'PROPOSAL, DRAFT, FINAL',
    status VARCHAR(20) NOT NULL COMMENT 'PENDING, APPROVED, REJECTED',
    file_path VARCHAR(255) NOT NULL,
    original_filename VARCHAR(255),
    submit_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES sys_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Interaction Question Table
CREATE TABLE IF NOT EXISTS question (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    teacher_id BIGINT NOT NULL,
    title VARCHAR(200),
    content TEXT NOT NULL,
    status INT DEFAULT 0 COMMENT '0: Unanswered, 1: Answered',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES sys_user(id),
    FOREIGN KEY (teacher_id) REFERENCES sys_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Teacher Evaluation Table
CREATE TABLE IF NOT EXISTS evaluation_teacher (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    teacher_id BIGINT NOT NULL,
    star INT NOT NULL COMMENT '1-5',
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES sys_user(id),
    FOREIGN KEY (teacher_id) REFERENCES sys_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
