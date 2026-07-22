function Employees() {

  const employees = [
    { id: 1, name: "John", department: "IT" },
    { id: 2, name: "David", department: "HR" },
    { id: 3, name: "Alice", department: "Finance" },
  ];

  return (
    <div>

      <h2>Employees</h2>

      <table border="1" cellPadding="10">

        <thead>

          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Department</th>
          </tr>

        </thead>

        <tbody>

          {employees.map((emp) => (

            <tr key={emp.id}>
              <td>{emp.id}</td>
              <td>{emp.name}</td>
              <td>{emp.department}</td>
            </tr>

          ))}

        </tbody>

      </table>

    </div>
  );
}

export default Employees;