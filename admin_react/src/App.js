import React from "react";
import "./App.css";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import axios from "axios";
import Layout from "./component/layout";
import HomeInfo from "./component/HomeInfo";
import SettingAdmin from "./component/SettingAdmin";
import Place from "./component/Place";
import LoginFrom from "./component/LoginFrom";
import PrivateRoute from "./component/PrivateRoute";
import PublicRoute from "./component/PublicRoute";

axios.defaults.baseURL = "http://192.168.137.71:8000/api";
axios.defaults.headers.post["Content-Type"] = "application/json";
axios.defaults.headers.post["Accept"] = "application/json";

axios.defaults.withCredentials = true;
axios.interceptors.request.use(function (config) {
  const token = localStorage.getItem("auth_token");
  config.headers.Authorization = token ? `Bearer ${token}` : "";
  return config;
});

function App() {
  return (
    <Router>
      <Routes>
        <Route
          path="/"
          element={
            <PrivateRoute>
              <Layout />
            </PrivateRoute>
          }
        >
          <Route path="/homeinfo" element={<HomeInfo />} />
          <Route path="/adminSetting" element={<SettingAdmin />} />
          <Route path="/tplace" element={<Place />} />
        </Route>

        <Route
          path="/login"
          element={
            <PublicRoute>
              {" "}
              <LoginFrom />{" "}
            </PublicRoute>
          }
        />
      </Routes>
    </Router>
  );
}

export default App;

// <>
//   <Header activeCalss={activeClass} title="TravleWin" />

//   <div className='row'  style={{ width: "100%" }}>
//     <BrowserRouter>
//       <LeftSideBar />
//       <Routes>
//         <Route exact path="/" element={<HomeInfo />} />
//         <Route exact path="/adminSetting" element={<SettingAdmin />} />
//         <Route exact path="/tplace" element={<Place />} />
//       </Routes>
//     </BrowserRouter>
//   </div>
// </>
