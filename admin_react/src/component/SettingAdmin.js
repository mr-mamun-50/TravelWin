import React from 'react'
import Animation from './Animation'

export default function SettingAdmin() {
    return (

        <div className='col-md-10 my-4'>
            <Animation >
                <div className="row">
                    <div className="col-md-8">
                        <div className="admin-dtl-box1">
                            <h4 className="title">About Me</h4>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Recusandae nemo cum eos? Veniam, obcaecati blanditiis laboriosam officiis et alias labore eum quis neque, maiores dolor, numquam accusantium tempora ipsum dolorum.</p>

                        </div>
                        <div className="admin-dtl-box1 d-flex justify-content-center my-3">
                            <img className='nid-card' src="" alt="NID Card Front" />
                            <img className='nid-card' src="" alt="NID Card Back" />
                        </div>
                        <div className="admin-dtl-box1 my-3">
                            <form>
                                <div className="form-group my-2">
                                    <label className='my-2' htmlFor="exampleFormControlInput1">Password</label>
                                    <input type="pwd" className="form-control" id="exampleFormControlInput1" placeholder="********" disabled />
                                </div>
                            </form>
                            <button type="button" className="btn btn-primary">Edit</button>
                        </div>

                    </div>
                    <div className="col-md-4">
                        <div className="admin-dtl-box2">
                            <img className="admin-img " src={require('../image/admin.png')} alt="loading" />
                            <h4 className="title text-center">Your Name</h4>
                            <table className="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row"><i className="bi bi-telephone"></i></th>
                                        <td>+44475742424</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><i className="bi bi-person-lines-fill"></i></th>
                                        <td>06 DOYERS ST. 8 ARLINGTON DR. 599 NW BAY BLVD.</td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><i className="bi bi-envelope"></i></th>
                                        <td colSpan="2">travleswin@me.com</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </Animation>
        </div>

    )
}