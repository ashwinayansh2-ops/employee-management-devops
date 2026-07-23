require("dotenv").config();

const express = require("express");
const cors = require("cors");

const employeeRoutes = require("./routes/employeeRoutes");

const app = express();

app.use(cors());

app.use(express.json());

app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next();
});

app.get("/", (req, res) => {
    res.send("Employee Management Backend Running");
});

app.get("/health", (req, res) => {

    res.status(200).json({
        status: "UP",
        application: "Employee Management Backend",
        version: "1.0.0"
    });

});

app.use("/api/employees", employeeRoutes);

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {

    console.log("=================================");
    console.log("Employee Backend Started");
    console.log(`Listening on Port ${PORT}`);
    console.log("=================================");

});