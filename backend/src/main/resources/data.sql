-- Initial Admin User (password: admin123)
-- BCrypt hash for 'admin123': $2a$10$X/hX9.S2/0.s6/7.8/9.0.1/2.3.4
INSERT INTO sys_user (username, password, name, role, college, major) 
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnutj8iAt8IPys0wZk6q3At5y/n8iUAQWy', 'System Admin', 'ROLE_ADMIN', 'System', 'Admin')
ON DUPLICATE KEY UPDATE name='System Admin';

-- Sample Teacher (password: 123456)
INSERT INTO sys_user (username, password, name, role, college, major) 
VALUES ('teacher1', '$2a$10$N.zmdr9k7uOCQb376NoUnutj8iAt8IPys0wZk6q3At5y/n8iUAQWy', 'Professor Zhang', 'ROLE_TEACHER', 'Computer Science', 'Software Engineering')
ON DUPLICATE KEY UPDATE name='Professor Zhang';

-- Sample Student (password: 123456)
INSERT INTO sys_user (username, password, name, role, college, major) 
VALUES ('student1', '$2a$10$N.zmdr9k7uOCQb376NoUnutj8iAt8IPys0wZk6q3At5y/n8iUAQWy', 'Li Ming', 'ROLE_STUDENT', 'Computer Science', 'Software Engineering')
ON DUPLICATE KEY UPDATE name='Li Ming';
