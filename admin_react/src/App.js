import React from 'react'
import './App.css';
import Header from './component/Header';
import HomeInfo from './component/HomeInfo'
import SettingAdmin from './component/SettingAdmin'
import { BrowserRouter, Routes, Route } from "react-router-dom";
import LeftSideBar from './component/LeftSideBar';
import Place from './component/Place';
import GuideBooking from './component/GuideBooking';


function App() {

  let activeClass = () => {
    let leftMenu = document.getElementById('menuAcitvate');
    leftMenu.classList.toggle('menuAcitve');
    leftMenu.addEventListener('click', ()=>{
      leftMenu.classList.remove('menuAcitve');
    });

  }

  return (
    <>
      <Header activeCalss={activeClass} title="TravleWin" />
      <div className='row'  style={{ width: "100%" }}>
        <BrowserRouter>
          <LeftSideBar />
          <Routes>
            <Route exact path="/" element={<HomeInfo />} />
            <Route exact path="/adminSetting" element={<SettingAdmin />} />
            <Route exact path="/tplace" element={<Place />} />
            <Route exact path="/guide" element={<GuideBooking />} />
          </Routes>
        </BrowserRouter>
      </div>
    </>
  );
}

export default App;
