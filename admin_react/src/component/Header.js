import React from 'react'

export default function Header(props) {

    return (
        <>
            <nav className="navbar navbar-expand-lg bg-dark  navbar-dark" data-bs-theme="dark">
                <div className="container-fluid">
                    <a className="navbar-brand d-flex" href='/'>{props.title}</a>
                    <button onClick={props.activeCalss} className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                    </button>
                </div>
            </nav>
        </>
    )
}
