import React from "react";
import Animation from "./Animation";

export default function GuideBooking() {

       


  return (
    <div className="col-md-10 my-2">
        <h2 className="my-2" style={{fontSize:"40px", fontWeight:"500"}}>Guide Details</h2>
      <Animation>
      <div className="card pmd-card my-5 ">
        
                <form className="form-inline m-2 m-lg-2">
                    <input
                        className="form-control mr-sm-2"
                        type="search"
                        placeholder="Search"
                        aria-label="Search"
                    />
                </form>
                <table
                    id="example "
                    className="homeOverflow  table pmd-table table-hover table-striped display dt-responsive nowrap"
                    cellSpacing="0"
                    width="100%"
                >
                    <thead style={{textAlign:"center"}}>
                        <tr>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>E-mail</th>
                            <th>Phone Number</th>
                            <th>Service Area</th>
                            <th>Status</th>
                            <th>Action</th>
                            <th>Start date</th>
                            <th>Salary</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Tiger</td>
                            <td>Nixon</td>
                            <td>System Architect</td>
                            <td>Edinburgh</td>
                            <td>61</td>
                            <td>2011/04/25</td>
                            <td>$320,800</td>
                            <td>5421</td>
                            <td>t.nixon@datatables.net</td>
                        </tr>
                        <tr>
                            <td>Garrett</td>
                            <td>Winters</td>
                            <td>Accountant</td>
                            <td>Tokyo</td>
                            <td>63</td>
                            <td>2011/07/25</td>
                            <td>$170,750</td>
                            <td>8422</td>
                            <td>g.winters@datatables.net</td>
                        </tr>
                        <tr>
                            <td>Ashton</td>
                            <td>Cox</td>
                            <td>Junior Technical Author</td>
                            <td>San Francisco</td>
                            <td>66</td>
                            <td>2009/01/12</td>
                            <td>$86,000</td>
                            <td>1562</td>
                            <td>a.cox@datatables.net</td>
                        </tr>
                        <tr>
                            <td>Cedric</td>
                            <td>Kelly</td>
                            <td>Senior Javascript Developer</td>
                            <td>Edinburgh</td>
                            <td>22</td>
                            <td>2012/03/29</td>
                            <td>$433,060</td>
                            <td>6224</td>
                            <td>c.kelly@datatables.net</td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul className="pagination">
                        <li className="page-item">
                            <a className="page-link" href='avascript:void(0)'  aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span className="sr-only">Previous</span>
                            </a>
                        </li>
                        <li className="page-item">
                            <a href='avascript:void(0)'  className="page-link">1</a>
                        </li>
                        <li className="page-item">
                            <a href='avascript:void(0)'  className="page-link">2</a>
                        </li>
                        <li className="page-item">
                            <a href='avascript:void(0)'  className="page-link">3</a>
                        </li>
                        <li className="page-item">
                            <a className="page-link" href='avascript:void(0)' aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span className="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
      </Animation>
    </div>
  );
}
