import React from 'react'
import Animation from './Animation'

export default function Place() {

	let activeDropDown = () => {
		var dtlPlace = document.getElementById('PlaceDtl');
		dtlPlace.classList.toggle('place-dtl-active');
	}
	return (
			<div className='col-md-10 my-2'>
				<Animation >
				<div className="row">
					<div className="place-dtl" id='PlaceDtl'>
						<div className="col-md-6 mt-3 mx-5">
							<form acceptCharset="UTF-8" encType="multipart/form-data" >
								<div className="form-group">
									<label htmlFor="exampleInputName"> Place Title</label>
									<input type="text" name="p_title" className="form-control" id="exampleInputName" placeholder="Enter your name and surname" required="required" />
								</div>
								<div className="form-group">
									<label htmlFor="exampleFormControlTextarea1" className="form-label">Place Description</label>
									<textarea className="form-control" id="exampleFormControlTextarea1" rows="3" placeholder='Start From here....'></textarea>
								</div>
								<hr />
								<div className="form-group mt-3">
									<label className="m-3 my-1">Upload Place Image: </label>
									<input type="file" name="file" />
								</div>
								<hr />
								<button type="submit" className="btn btn-success">Submit</button>
							</form>
						</div>
					</div>
				</div>
				<div className="ftco-section my-5">
					<div className="input-group rounded p-3" style={{ zIndex: "0" }}>
						<span className="input-group-text border-0" id="search-addon">
							<i className="bi bi-search"></i>
						</span>
						<input type="search" className="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
						<button onClick={activeDropDown} type="submit" className="btn btn-primary">Add</button>
					</div>
					<table id="example" className="table pmd-table table-hover table-striped display dt-responsive nowrap" cellSpacing="0" width="100%">
						<thead>
							<tr>
								<th>Image</th>
								<th>Place Details</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td className='place-image'><img src="https://www.w3schools.com/howto/img_avatar.png" alt="" /></td>
								<td className='place-description'>
									<h4>Lorem ipsum</h4>
									<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aliquid beatae ipsa eum eveniet assumenda ipsam placeat aut nam? A reprehenderit error facere eligendi iure saepe? Sequi laborum nam vero molestiae.</p>
								</td>
								<td className='place-action'><i className="bi bi-trash"></i> </td>
								<td className='place-action'><i className="bi bi-pencil-square"></i></td>
							</tr>
							<tr>
								<td className='place-image'><img src="https://www.w3schools.com/howto/img_avatar.png" alt="" /></td>
								<td className='place-description'>
									<h4>Lorem ipsum</h4>
									<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aliquid beatae ipsa eum eveniet assumenda ipsam placeat aut nam? A reprehenderit error facere eligendi iure saepe? Sequi laborum nam vero molestiae.</p>
								</td>
								<td className='place-action'><i className="bi bi-trash"></i> </td>
								<td className='place-action'><i className="bi bi-pencil-square"></i></td>
							</tr>
							<tr>
								<td className='place-image'><img src="https://www.w3schools.com/howto/img_avatar.png" alt="" /></td>
								<td className='place-description'>
									<h4>Lorem ipsum</h4>
									<p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aliquid beatae ipsa eum eveniet assumenda ipsam placeat aut nam? A reprehenderit error facere eligendi iure saepe? Sequi laborum nam vero molestiae.</p>
								</td>
								<td className='place-action'><i className="bi bi-trash"></i> </td>
								<td className='place-action'><i className="bi bi-pencil-square"></i></td>
							</tr>
						</tbody>
					</table>
					<nav aria-label="Page navigation example" className='d-flex justify-content-end'>
						<ul className="pagination">
							<li className="page-item">
								<a className="page-link" href="!#"  aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
							<li className="page-item"><a href="!#" className="page-link" >1</a></li>
							<li className="page-item"><a href="!#" className="page-link" >2</a></li>
							<li className="page-item"><a href="!#" className="page-link" >3</a></li>
							<li className="page-item">
								<a href="!#" className="page-link" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</ul>
					</nav>
				</div>
				</Animation>
			</div>
		
	)
}
