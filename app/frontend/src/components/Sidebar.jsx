import { Link } from "react-router-dom";

function Sidebar() {
  return (
    <aside
      style={{
        width: "220px",
        padding: "20px",
        background: "#f4f4f4",
      }}
    >
      <h3>Menu</h3>

      <ul style={{ listStyle: "none", padding: 0 }}>
        <li>
          <Link to="/">Dashboard</Link>
        </li>

        <li>
          <Link to="/employees">Employees</Link>
        </li>

        <li>
          <Link to="/add-employee">Add Employee</Link>
        </li>
      </ul>
    </aside>
  );
}

export default Sidebar;