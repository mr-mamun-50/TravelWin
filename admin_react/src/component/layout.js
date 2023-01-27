import React from 'react'
import { Outlet } from 'react-router-dom'
import Header from './Header'
import LeftSideBar from './LeftSideBar'

export default function Layout() {
    return (
        <div>
            <Header />
            <LeftSideBar />
            <main className='ms-2' style={{ marginTop: '58px' }}>
                <div className="container pt-4">
                    <Outlet />
                </div>
            </main>
        </div >
    )
}