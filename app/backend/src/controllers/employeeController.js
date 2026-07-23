const employees = require("../data/employees");

exports.getEmployees = (req, res) => {
    res.status(200).json(employees);
};