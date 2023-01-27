import React from 'react'
import { NavLink } from "react-router-dom";



export default function LeftSideBar(props) {


    return (
        <div id="menuAcitvate" className="col-md-2 menu-acitve ">
            <div className="menu-left">
                <NavLink to="/">
                    <div className="menu-iteam">
                        <i className="bi bi-house"></i>
                        <span>Home</span>
                    </div></NavLink>
                <NavLink to="/tplace">
                    <div className="menu-iteam">
                        <i className="bi bi-map"></i>
                        <span>Tourist Place</span>
                    </div></NavLink>
                <div className="menu-iteam">
                    <i className="bi bi-person"></i>
                    <span>Guid Bookings</span>
                </div>
                <div className="menu-iteam">
                    <i className="bi bi-car-front-fill"></i>
                    <span>Rent Car</span>
                </div>
                <NavLink to="/adminSetting">
                    <div className="menu-iteam">
                        <i className="bi bi-gear"></i>
                        <span>Settign</span>
                    </div></NavLink>
                <div className="menu-iteam">
                    <i className="bi bi-box-arrow-left"></i>
                    <span>Log Out</span>
                </div>
            </div>
        </div>
    )
}
