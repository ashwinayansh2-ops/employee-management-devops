function Dashboard() {
  return (
    <div>
      <h2>Dashboard</h2>
      <hr />

      <div style={{ display: "flex", gap: "20px" }}>
        <div
          style={{
            border: "1px solid #ddd",
            padding: "20px",
            width: "220px",
          }}
        >
          <h3>Total Employees</h3>
          <h1>25</h1>
        </div>

        <div
          style={{
            border: "1px solid #ddd",
            padding: "20px",
            width: "220px",
          }}
        >
          <h3>Backend Status</h3>
          <h2 style={{ color: "green" }}>Healthy</h2>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;