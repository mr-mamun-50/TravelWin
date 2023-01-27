import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";
export default function LoginFrom() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const [error, setError] = useState();
  const [success, setSuccess] = useState("");
  const [loading, setLoading] = useState();

  const navigate = useNavigate();

  const loginSubmit = (e) => {
    e.preventDefault()

    let data = { email, password };

    setLoading(true);
    setError("");

    axios.get("/sanctum/csrf-cookie").then((response) => {
      axios.post("/admin/login", data)
        .then((res) => {
          if (res.status === 200) {
            localStorage.setItem("auth_token", res.data.token);
            localStorage.setItem("auth_user_name", res.data.user.name);
            localStorage.setItem("auth_user_email", res.data.user.email);
            setLoading(false);
            setSuccess(res.data.message);

            navigate("/homeinfo");
          } else {
            setLoading(false);
            setError(res.data.message);
          }
        })
        .catch((err) => {
          setLoading(false);
          setError(err.response.data.message);
        });
    });
  };
  return (
    <div className="row d-flex align-items-center justify-content-center h-100 m-3">
      <div className="col-md-8 col-lg-7 col-xl-6">
        <img
          src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg"
          class="img-fluid"
          alt="Phone image"
        />
      </div>
      <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">
        <form onSubmit={loginSubmit}>
          <div class="form-outline mb-4">
            <h3 className="text-center">LOGIN FROM</h3>
            <label class="form-label" htmlFor="femail">
              Email address
            </label>
            <input
              type="email"
              name="email"
              id="email"
              className="form-control"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>

          <div class="form-outline mb-4">
            <label class="form-label" htmlFor="password">
              Password
            </label>
            <input
              type="password"
              name="password"
              id="password"
              className="form-control"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>

          <div className="row mb-4">
            <div class="col d-flex justify-content-center">
              <div class="form-check">
                <input
                  type="checkbox"
                  className="form-check-input"
                  name="remember"
                  id="remember"
                />
                <label className="form-check-label" htmlFor="form2Example31">
                  {" "}
                  Remember me{" "}
                </label>
              </div>
            </div>
            {error && <div className="alert alert-danger py-2">{error}</div>}
          </div>

          <button type="submit" className="btn btn-primary btn-block">
            {loading ? (
              <span
                className="spinner-border spinner-border-sm"
                role="status"
                aria-hidden="true"
              ></span>
            ) : success ? (
              setTimeout(() => {
                setSuccess("");
              }, 3000) && success
            ) : (
              "Login"
            )}
          </button>
        </form>
        
      </div>
    </div>
  );
}
