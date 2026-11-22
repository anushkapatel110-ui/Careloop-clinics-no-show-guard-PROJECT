
CREATE TABLE IF NOT EXISTS appointments (
    appointment_id TEXT PRIMARY KEY,
    patient_id TEXT,
    clinic_id TEXT,
    booked_on DATE,
    appt_date DATE,
    age INTEGER,
    gender TEXT,
    distance_km REAL,
    fee_inr INTEGER,
    booking_channel TEXT,
    visit_type TEXT,
    reminder_sent TEXT,
    prior_no_shows INTEGER,
    status TEXT,
    lead_days INTEGER,
    no_show INTEGER
);

CREATE TABLE IF NOT EXISTS clinics (
    clinic_id TEXT PRIMARY KEY,
    clinic_name TEXT,
    city TEXT,
    tier TEXT,
    latitude REAL,
    longitude REAL,
    temperature_c REAL
);
