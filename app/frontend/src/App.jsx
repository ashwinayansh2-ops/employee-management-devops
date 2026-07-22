import { BrowserRouter, Routes, Route } from "react-router-dom";

import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import Footer from "./components/Footer";

import Dashboard from "./pages/Dashboard";
import Employees from "./pages/Employees";
import AddEmployee from "./pages/AddEmployee";
import NotFound from "./pages/NotFound";

function App() {
  return (
    <BrowserRouter>
      <Header />

      <div style={{ display: "flex", minHeight: "80vh" }}>
        <Sidebar />

        <main style={{ flex: 1, padding: "20px" }}>
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/employees" element={<Employees />} />
            <Route path="/add-employee" element={<AddEmployee />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </main>
      </div>

      <Footer />
    </BrowserRouter>
  );
}

export default App;