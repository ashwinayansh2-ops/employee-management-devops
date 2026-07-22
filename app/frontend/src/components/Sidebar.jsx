import { Link } from "react-router-dom";

function Sidebar() {
  return (
    <aside
      style={{
        width: "220px",
        background: "#f4f4f4",
        padding: "20px",
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
          <Link to="/about">About</Link>
        </li>

      </ul>

    </aside>
  );
}

export default Sidebar;