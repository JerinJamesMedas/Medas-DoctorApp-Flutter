const express = require("express");
const app = express();
const PORT = 3000;

// Your appointment data
const appointments = [
  {
    title: "Current Appointment",
    patient: "John Smith",
    mr: "MR123456",
    dob: "1985-01-12",
    type: "Video Call",
    nationality: "American",
    city: "New York",
    visitCount: 5
  },
  {
    title: "Upcoming Appointment",
    patient: "Emma Wilson",
    mr: "MR654321",
    dob: "1990-03-03",
    type: "On Spot",
    nationality: "British",
    city: "London",
    visitCount: 2
  },
  {
    title: "Upcoming Appointment",
    patient: "Michael Brown",
    mr: "MR998877",
    dob: "1978-12-25",
    type: "Home Visit",
    nationality: "Canadian",
    city: "Toronto",
    visitCount: 4
  },
  {
    title: "Upcoming Appointment",
    patient: "Sophia Green",
    mr: "MR111222",
    dob: "1992-06-15",
    type: "On Spot",
    nationality: "Australian",
    city: "Sydney",
    visitCount: 3
  },
  {
    title: "Upcoming Appointment",
    patient: "Liam Johnson",
    mr: "MR333444",
    dob: "1988-08-09",
    type: "Video Call",
    nationality: "American",
    city: "Chicago",
    visitCount: 6
  },
  {
    title: "Upcoming Appointment",
    patient: "Olivia Davis",
    mr: "MR555666",
    dob: "1995-02-28",
    type: "Home Visit",
    nationality: "British",
    city: "Manchester",
    visitCount: 1
  },
  {
    title: "Upcoming Appointment",
    patient: "William Miller",
    mr: "MR777888",
    dob: "1982-04-12",
    type: "On Spot",
    nationality: "Canadian",
    city: "Vancouver",
    visitCount: 7
  },
  {
    title: "Upcoming Appointment",
    patient: "Isabella Martinez",
    mr: "MR999000",
    dob: "1993-09-21",
    type: "Video Call",
    nationality: "Mexican",
    city: "Mexico City",
    visitCount: 4
  }
];

// API route
app.get("/appointments", (req, res) => {
  res.json(appointments);
});

// Start server
app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
