-- Keep a log of any SQL queries you execute as you solve the mystery.

SELECT description FROM crime_scene_reports WHERE year = 2021 AND month = 7 AND day = 28 AND street = "Humphrey Street";
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

SELECT name, transcript FROM interviews WHERE year = 2021 AND month = 7 AND day = 28;
-- Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”
-- Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

SELECT name FROM people WHERE name = "Eugene";
-- +--------+
-- |  name  |
-- +--------+
-- | Eugene |
-- +--------+

SELECT name, transcript FROM interviews WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE "%bakery%" ORDER BY name;
-- | Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
-- | Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
-- | Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

SELECT account_number, amount FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND transaction_type = "withdraw";
-- +----------------+--------+
-- | account_number | amount |
-- +----------------+--------+
-- | 28500762       | 48     |
-- | 28296815       | 20     |
-- | 76054385       | 60     |
-- | 49610011       | 50     |
-- | 16153065       | 80     |
-- | 25506511       | 20     |
-- | 81061156       | 30     |
-- | 26013199       | 35     |
-- +----------------+--------+

SELECT name, atm_transactions.amount FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.year = 2021 AND atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.atm_location = "Leggett Street" AND atm_transactions.transaction_type = "withdraw";
-- +---------+--------+
-- |  name   | amount |
-- +---------+--------+
-- | Bruce   | 50     |
-- | Diana   | 35     |
-- | Brooke  | 80     |
-- | Kenny   | 20     |
-- | Iman    | 20     |
-- | Luca    | 48     |
-- | Taylor  | 60     |
-- | Benista | 30     |
-- +---------+--------+

SELECT abbreviation, full_name, city FROM airports WHERE city = "Fiftyville";
-- +--------------+-----------------------------+------------+
-- | abbreviation |          full_name          |    city    |
-- +--------------+-----------------------------+------------+
-- | CSF          | Fiftyville Regional Airport | Fiftyville |
-- +--------------+-----------------------------+------------+

SELECT flights.id, full_name, city, flights.hour, flights.minute FROM airports JOIN flights ON airports.id = flights.destination_airport_id WHERE flights.origin_airport_id = (SELECT id FROM airports WHERE city = "Fiftyville") AND flights.year = 2021 AND flights.month = 7 AND flights.day = 29 ORDER BY flights.hour, flights.minute;
-- +----+-------------------------------------+---------------+------+--------+
-- | id |              full_name              |     city      | hour | minute |
-- +----+-------------------------------------+---------------+------+--------+
-- | 36 | LaGuardia Airport                   | New York City | 8    | 20     |
-- | 43 | O'Hare International Airport        | Chicago       | 9    | 30     |
-- | 23 | San Francisco International Airport | San Francisco | 12   | 15     |
-- | 53 | Tokyo International Airport         | Tokyo         | 15   | 20     |
-- | 18 | Logan International Airport         | Boston        | 16   | 0      |
-- +----+-------------------------------------+---------------+------+--------+

SELECT passengers.flight_id, name, passengers.passport_number, passengers.seat FROM people JOIN passengers ON people.passport_number = passengers.passport_number JOIN flights ON passengers.flight_id = flights.id WHERE flights.year = 2021 AND flights.month = 7 AND flights.day = 29 AND flights.hour = 8 AND flights.minute = 20 ORDER BY passengers.passport_number;
-- +-----------+--------+-----------------+------+
-- | flight_id |  name  | passport_number | seat |
-- +-----------+--------+-----------------+------+
-- | 36        | Edward | 1540955065      | 5C   |
-- | 36        | Sofia  | 1695452385      | 3B   |
-- | 36        | Taylor | 1988161715      | 6D   |
-- | 36        | Bruce  | 5773159633      | 4A   |
-- | 36        | Doris  | 7214083635      | 2A   |
-- | 36        | Kelsey | 8294398571      | 6C   |
-- | 36        | Luca   | 8496433585      | 7B   |
-- | 36        | Kenny  | 9878712108      | 7A   |
-- +-----------+--------+-----------------+------+

SELECT name, phone_calls.duration FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration <= 60 ORDER BY phone_calls.duration;
-- +---------+----------+
-- |  name   | duration |
-- +---------+----------+
-- | Kelsey  | 36       |
-- | Carina  | 38       |
-- | Taylor  | 43       |
-- | Bruce   | 45       |
-- | Diana   | 49       |
-- | Kelsey  | 50       |
-- | Sofia   | 51       |
-- | Benista | 54       |
-- | Kenny   | 55       |
-- | Kathryn | 60       |
-- +---------+----------+

SELECT name, phone_calls.duration FROM people JOIN phone_calls ON people.phone_number = phone_calls.receiver WHERE phone_calls.year = 2021 AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration <= 60 ORDER BY phone_calls.duration;
-- +------------+----------+
-- |    name    | duration |
-- +------------+----------+
-- | Larry      | 36       |
-- | Jacqueline | 38       |
-- | James      | 43       |
-- | Robin      | 45       |
-- | Philip     | 49       |
-- | Melissa    | 50       |
-- | Jack       | 51       |
-- | Anna       | 54       |
-- | Doris      | 55       |
-- | Luca       | 60       |
-- +------------+----------+

SELECT name, bakery_security_logs.hour, bakery_security_logs.minute FROM people JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate WHERE bakery_security_logs.year = 2021 AND bakery_security_logs.month = 7 AND bakery_security_logs.day = 28 AND bakery_security_logs.activity = "exit" AND bakery_security_logs.hour = 10 AND bakery_security_logs.minute >= 15 AND bakery_security_logs.minute <= 25 ORDER BY bakery_security_logs.minute;
-- +---------+------+--------+
-- |  name   | hour | minute |
-- +---------+------+--------+
-- | Vanessa | 10   | 16     |
-- | Bruce   | 10   | 18     |
-- | Barry   | 10   | 18     |
-- | Luca    | 10   | 19     |
-- | Sofia   | 10   | 20     |
-- | Iman    | 10   | 21     |
-- | Diana   | 10   | 23     |
-- | Kelsey  | 10   | 23     |
-- +---------+------+--------+