import React, { useEffect, useState } from "react";
import Animation from "./Animation";
import { usePlacesWidget } from "react-google-autocomplete";

export default function Place() {
  let activeDropDown = () => {
    var dtlPlace = document.getElementById("PlaceDtl");
    dtlPlace.classList.toggle("place-dtl-active");
  };

  const [image, setImage] = useState(null);
  const [title, setTitle] = useState(null);
  const [description, setdescription] = useState(null);

  const fetchData = async () => {
    const url = "http://192.168.137.71:8000/api/user/tourist_spots";
    await fetch(url).then(res => res.json()).then((data) => {
      console.log(data.touristSpots[0].name);
      setTitle(data.touristSpots[0].name);
      setdescription(data.touristSpots[0].description);
      setImage(data.touristSpots[0].image);
    });
  };

  const [addimage, setaddimage] = useState("");
  const [addtitle, setaddtitle] = useState(null);
  const [adddescription, setadddescriptionn] = useState(null);


  const data = {
    name: addtitle,
    description: adddescription,
    image : addimage,
  }

  const dataEdit = async (e) => {
    e.preventDefault();
    console.log(data);
    const url = "http://192.168.137.71:8000/api/user/tourist_spots";
    fetch(url, {
      method: "POST", // or 'PUT'
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    }).then((data) => {
        console.log("Success:", );
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  };

  useEffect(() => {
    fetchData();
  }, []);

  const { ref } = usePlacesWidget({
    apiKey: "AIzaSyBCcDhyZ9Fqi1X3HxUbcYqoVf2jBU8Jfek",
    onPlaceSelected: (place) => {
      // let long = place.geometry.location.lat();
      // let Lng = place.geometry.location.lat();
      //
      // document.getElementById('Lat').value = long;
      // document.getElementById('Lng').value = Lng;
    },
  });

  return (
    <div className="col-md-10 my-2">
      <Animation>
        <div className="row">
          <div className="place-dtl" id="PlaceDtl">
            <div className="col-md-6 mt-3 mx-5">
              <form onSubmit={dataEdit} acceptCharset="UTF-8" encType="multipart/form-data">
                <div className="form-group">
                  <label htmlFor="exampleInputName"> Place Title</label>

                  <input
                    ref={ref}
                    type="text"
                    name="p_title"
                    className="form-control"
                    id="place-title searchTextField"
                    placeholder="Enter Place name"
                    required="required"
                    value={addtitle}
                    onChange={(e) => {
                      setaddtitle(e.target.value);
                    }}
                  />
                </div>
                <div className="form-group" style={{ marginTop: "5%" }}>
                  <label
                    htmlFor="exampleFormControlTextarea1"
                    className="form-label"
                  >
                    Place Description
                  </label>
                  <textarea
                    value={adddescription}
                    onChange={(e) => {
                      setadddescriptionn(e.target.value);
                    }}
                    className="form-control"
                    id="exampleFormControlTextarea1"
                    rows="3"
                    placeholder="Place Description...."
                  ></textarea>
                </div>
                <hr />
                <div className="form-group mt-3">
                  <label className="m-3 my-1">Upload Place Image: </label>
                  <input
                    type="file"
                    name="file"
                    value={addimage}
                    onChange={(e) => {
                      setaddimage(e.target.value);
                    }}
                  />
                </div>
                <hr />
                <button type="submit" className="btn btn-success">
                  Submit
                </button>
              </form>
            </div>
          </div>
        </div>
        <div className="ftco-section my-5">
          <button
            onClick={activeDropDown}
            type="submit"
            className="btn btn-primary m-2"
          >
            Add Place
          </button>
          <div className="input-group rounded p-3" style={{ zIndex: "0" }}>
            <span className="input-group-text border-0" id="search-addon">
              <i className="bi bi-search"></i>
            </span>
            <input
              type="search"
              // className="rounded"
              placeholder="Search"
              aria-label="Search"
              aria-describedby="search-addon"
              style={{
                width: "80%",
                borderRadius: "5px",
                border: "1px solid #3333",
                paddingLeft: "10px",
              }}
            />
          </div>
          <table
            id="example"
            className="table pmd-table table-hover table-striped display dt-responsive nowrap"
            cellSpacing="0"
            width="100%"
          >
            <thead>
              <tr>
                <th>Image</th>
                <th>Place Details</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td className="place-image">
                  <img src={image} alt="" />
                </td>
                <td className="place-description">
                  <h4>{title}</h4>
                  <p>{description}</p>
                </td>
                <td className="place-action">
                  <i className="bi bi-trash"></i>{" "}
                </td>
                <td className="place-action">
                  <i className="bi bi-pencil-square"></i>
                </td>
              </tr>
              <tr>
                <td className="place-image">
                  <img
                    src="https://www.w3schools.com/howto/img_avatar.png"
                    alt=""
                  />
                </td>
                <td className="place-description">
                  <h4>Lorem ipsum</h4>
                  <p>
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Aliquid beatae ipsa eum eveniet assumenda ipsam placeat aut
                    nam? A reprehenderit error facere eligendi iure saepe? Sequi
                    laborum nam vero molestiae.
                  </p>
                </td>
                <td className="place-action">
                  <i className="bi bi-trash"></i>{" "}
                </td>
                <td className="place-action">
                  <i className="bi bi-pencil-square"></i>
                </td>
              </tr>
              <tr>
                <td className="place-image">
                  <img
                    src="https://www.w3schools.com/howto/img_avatar.png"
                    alt=""
                  />
                </td>
                <td className="place-description">
                  <h4>Lorem ipsum</h4>
                  <p>
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                    Aliquid beatae ipsa eum eveniet assumenda ipsam placeat aut
                    nam? A reprehenderit error facere eligendi iure saepe? Sequi
                    laborum nam vero molestiae.
                  </p>
                </td>
                <td className="place-action">
                  <i className="bi bi-trash"></i>{" "}
                </td>
                <td className="place-action">
                  <i className="bi bi-pencil-square"></i>
                </td>
              </tr>
            </tbody>
          </table>
          <nav
            aria-label="Page navigation example"
            className="d-flex justify-content-end"
          >
            <ul className="pagination">
              <li className="page-item">
                <a className="page-link" href="!#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              <li className="page-item">
                <a href="!#" className="page-link">
                  1
                </a>
              </li>
              <li className="page-item">
                <a href="!#" className="page-link">
                  2
                </a>
              </li>
              <li className="page-item">
                <a href="!#" className="page-link">
                  3
                </a>
              </li>
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
  );
}
