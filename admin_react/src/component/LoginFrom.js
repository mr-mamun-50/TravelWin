import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
export default function LoginFrom() {
  let loginSubmit = (e) => {
    e.preventDefault();
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
        <form method="post" onSubmit={loginSubmit}>
          <div class="form-outline mb-4">
            <h3 className="text-center">LOGIN FROM</h3>
            <label class="form-label" htmlFor="email">
              Email address
            </label>
            <input
              type="email"
              name="email"
              id="email"
              className="form-control"
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
            />
          </div>

          <button type="submit" className="btn btn-primary btn-block"></button>
        </form>
      </div>
    </div>
  );
}
