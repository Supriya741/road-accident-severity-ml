-- =========================================================
-- Road Accident Severity Prediction Database
-- Author: Geethanjali Nallateegala
-- =========================================================

CREATE DATABASE IF NOT EXISTS road_accident_prediction;
USE road_accident_prediction;

CREATE TABLE accidents (
    accident_id INT AUTO_INCREMENT PRIMARY KEY,
    accident_date DATE NOT NULL,
    accident_time TIME NOT NULL,
    speed_limit INT NOT NULL,
    road_type VARCHAR(30) NOT NULL,
    weather_condition VARCHAR(30) NOT NULL,
    road_surface VARCHAR(30) NOT NULL,
    light_condition VARCHAR(30) NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL,
    number_of_vehicles INT NOT NULL,
    number_of_casualties INT NOT NULL,
    driver_age INT NOT NULL,
    junction_type VARCHAR(30),
    alcohol_involved BOOLEAN DEFAULT FALSE,
    predicted_severity ENUM('Slight','Serious','Fatal') NOT NULL,
    confidence DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accidents
(accident_date,accident_time,speed_limit,road_type,weather_condition,road_surface,
light_condition,vehicle_type,number_of_vehicles,number_of_casualties,
driver_age,junction_type,alcohol_involved,predicted_severity,confidence)
VALUES
('2026-01-10','08:30:00',40,'Urban','Clear','Dry','Daylight','Car',2,1,28,'Crossroads',0,'Slight',91.40),
('2026-01-15','22:10:00',90,'Highway','Rain','Wet','Dark-unlit','Truck',3,2,45,'None',0,'Serious',83.60),
('2026-02-01','01:45:00',110,'Highway','Fog','Wet','Dark-unlit','Car',4,5,31,'T-junction',1,'Fatal',95.80),
('2026-02-18','17:20:00',60,'Urban','Clear','Dry','Daylight','Motorcycle',2,1,24,'Roundabout',0,'Slight',88.20),
('2026-03-05','20:15:00',80,'Rural','Storm','Muddy','Dark-unlit','Bus',5,7,50,'None',1,'Fatal',97.10),
('2026-03-12','13:10:00',50,'Residential','Clear','Dry','Daylight','Bicycle',1,0,19,'None',0,'Slight',93.00),
('2026-04-08','06:40:00',70,'Urban','Rain','Wet','Dusk/Dawn','Car',2,2,37,'Crossroads',0,'Serious',79.90),
('2026-04-22','23:50:00',100,'Highway','Fog','Icy','Dark-unlit','Truck',4,6,41,'None',1,'Fatal',98.20),
('2026-05-09','11:25:00',45,'Residential','Clear','Dry','Daylight','Car',2,0,34,'T-junction',0,'Slight',90.60),
('2026-06-14','19:35:00',85,'Rural','Rain','Wet','Dark-lit','Motorcycle',3,3,29,'Roundabout',1,'Serious',84.70);

-- Useful SQL queries

-- 1. Count accidents by severity
SELECT predicted_severity, COUNT(*) AS total_cases
FROM accidents
GROUP BY predicted_severity;

-- 2. Average confidence by severity
SELECT predicted_severity, ROUND(AVG(confidence),2) AS avg_confidence
FROM accidents
GROUP BY predicted_severity;

-- 3. Fatal accidents involving alcohol
SELECT accident_id, accident_date, vehicle_type, weather_condition
FROM accidents
WHERE alcohol_involved = TRUE
AND predicted_severity = 'Fatal';

-- 4. Top 5 highest speed accidents
SELECT accident_id, speed_limit, predicted_severity
FROM accidents
ORDER BY speed_limit DESC
LIMIT 5;

-- 5. Weather-wise accident distribution
SELECT weather_condition, COUNT(*) AS accidents
FROM accidents
GROUP BY weather_condition;
