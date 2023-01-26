import React from 'react'
import DataTable from './DataTable'
import Animation from './Animation'

export default function HomeInfo() {
  return (
    
    <div className='col-md-10 my-2'>
        <Animation >
            <div className="container">
                <div className="row">
                    <div className="col-md-8">
                        <div className="icome-box">
                            <p>Total Income: $7000,000</p>
                        </div>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-3 my-2">
                        <div className="info-box">
                            <p>Total User</p>
                            <p className='text-end user-value'>2,000</p>
                            <div className="progress">
                                <div className="progress-bar bg-warning" role="progressbar" style={{ width: "10%" }} aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div className="col-md-3 my-2">
                        <div className="info-box">
                            <p>Total Guide</p>
                            <p className='text-end user-value'>4,010</p>
                            <div className="progress">
                                <div className="progress-bar bg-warning" role="progressbar" style={{ width: "40%" }} aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div className="col-md-3 my-2">
                        <div className="info-box">
                            <p>Total Rent Car</p>
                            <p className='text-end user-value'>4,010</p>
                            <div className="progress">
                                <div className="progress-bar bg-warning" role="progressbar" style={{ width: "40%" }} aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div className="col-md-3 my-2">
                        <div className="info-box">
                            <p>Total Booking</p>
                            <p className='text-end user-value'>4,010</p>
                            <div className="progress">
                                <div className="progress-bar bg-warning" role="progressbar" style={{ width: "50%" }} aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <DataTable/>
            </Animation >
        </div>
        
  )
}
