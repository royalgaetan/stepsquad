const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");

const app = express();
const PORT = 3000;

// MongoDB connection string
const connectionString =
  "mongodb+srv://user1:nuEAoti8VWkml9Hu@cluster0.lajclhl.mongodb.net/ssdatabase?retryWrites=true&w=majority";

// Connect to MongoDB
mongoose
  .connect(connectionString, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((error) => {
    console.error("Error connecting to MongoDB:", error);
  });

// User Schema
const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
});

const User = mongoose.model("User", userSchema);

// Middleware
app.use(bodyParser.json());

// Simple endpoint
app.get("/", (req, res) => {
  res.send("Hello masta!");
});

// Register endpoint
app.post("/register", async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if the username already exists
    const existingUser = await User.findOne({ username });
    if (existingUser) {
      res.status(409).json({ error: "Username already exists" });
    } else {
      // Create a new user
      const newUser = new User({ username, password });
      await newUser.save();

      res.status(200).json({ message: "User registered successfully" });
    }
  } catch (error) {
    res.status(500).json({ error: "Failed to register user" });
  }
});

// Login endpoint
app.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if the username or password is missing
    // if (!username || !password) {
    //   return res
    //     .status(400)
    //     .json({ error: "Username and password are required" });
    // }

    // Find the user with matching credentials
    const user = await User.findOne({ username, password });

    if (user) {
      res.status(200).json({ message: "Login successful" });
    } else {
      res.status(401).json({ message: "Invalid credentials" });
    }
  } catch (error) {
    res.status(500).json({ error: "Failed to login" });
  }
});

// Users endpoint
app.get("/users", async (req, res) => {
  try {
    // Fetch all registered users
    const users = await User.find({}, { password: 0 });

    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch users" });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
