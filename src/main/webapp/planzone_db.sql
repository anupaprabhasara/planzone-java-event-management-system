-- Create and select the database
CREATE DATABASE IF NOT EXISTS planzone_db;
USE planzone_db;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('User', 'Admin', 'Organizer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (full_name, email, password, role) VALUES 
('Alice Johnson', 'alice@example.com', 'pass123', 'Admin'),
('Bob Smith', 'bob@example.com', 'pass123', 'Organizer'),
('Charlie Davis', 'charlie@example.com', 'pass123', 'User'),
('Diana Roberts', 'diana@example.com', 'pass123', 'User'),
('Ethan Brown', 'ethan@example.com', 'pass123', 'Organizer');

-- Venues Table
CREATE TABLE venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    capacity INT
);

INSERT INTO venues (name, address, capacity) VALUES 
('Main Auditorium', '123 University Rd', 200),
('Tech Hall', '456 Innovation Blvd', 150),
('Outdoor Stage', '789 Park Ave', 300),
('Conference Room A', '321 Office Ln', 50),
('Virtual - Zoom', 'Online', 500);

-- Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

INSERT INTO categories (name) VALUES 
('Technology'),
('Culture'),
('Education'),
('Entertainment'),
('Networking');

-- Events Table
CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    venue_id INT,
    category_id INT,
    organizer_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (organizer_id) REFERENCES users(user_id)
);

INSERT INTO events (title, description, start_time, end_time, venue_id, category_id, organizer_id) VALUES 
('Tech Talk 2025', 'A talk on emerging tech trends.', '2025-03-28 10:00:00', '2025-03-28 12:00:00', 2, 1, 2),
('Cultural Fest', 'Annual university cultural festival.', '2025-03-29 09:00:00', '2025-03-30 18:00:00', 3, 2, 5),
('Career Fair', 'Meet top recruiters and network.', '2025-04-05 11:00:00', '2025-04-05 15:00:00', 1, 5, 2),
('Film Night', 'Screening of student short films.', '2025-04-06 18:00:00', '2025-04-06 21:00:00', 4, 4, 5),
('Study Skills Workshop', 'Tips for better academic success.', '2025-04-10 14:00:00', '2025-04-10 15:30:00', 5, 3, 2);

-- Registrations Table
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_id INT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO registrations (user_id, event_id) VALUES 
(3, 1),
(4, 2),
(3, 3),
(4, 4),
(3, 5);

-- Notifications Table
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO notifications (message) VALUES
('A new event "Tech Talk 2025" has just been announced. Visit the event page for more details.'),
('A new event "Cultural Fest" has just been announced. Visit the event page for more details.'),
('A new event "Career Fair" has just been announced. Visit the event page for more details.'),
('A new event "Film Night" has just been announced. Visit the event page for more details.'),
('A new event "Study Skills Workshop" has just been announced. Visit the event page for more details.');

-- Views
CREATE VIEW events_view AS
SELECT 
    e.event_id,
    e.title,
    e.description,
    e.start_time,
    e.end_time,
    v.name AS venue_name,
    v.address AS venue_address,
    c.name AS category_name,
    u.full_name AS organizer_name,
    e.created_at
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
JOIN categories c ON e.category_id = c.category_id
JOIN users u ON e.organizer_id = u.user_id;

CREATE VIEW registrations_view AS
SELECT 
    r.registration_id,
    r.user_id,
    u.full_name AS user_name,
    e.title AS event_title,
    r.registered_at
FROM registrations r
JOIN users u ON r.user_id = u.user_id
JOIN events e ON r.event_id = e.event_id;

-- Trigger: Insert notification on new event
DELIMITER //
CREATE TRIGGER trg_new_event_user_notification
AFTER INSERT ON events
FOR EACH ROW
BEGIN
    DECLARE user_message TEXT;
    SET user_message = CONCAT('A new event "', NEW.title, '" has just been announced. Visit the event page for more details.');
    INSERT INTO notifications (message) VALUES (user_message);
END;
//
DELIMITER ;

-- Enable event scheduler
SET GLOBAL event_scheduler = ON;

-- Scheduled Event: Delete notifications older than 6 hours
CREATE EVENT evt_clean_old_notifications
ON SCHEDULE EVERY 10 MINUTE
DO
  DELETE FROM notifications
  WHERE created_at < NOW() - INTERVAL 6 HOUR;