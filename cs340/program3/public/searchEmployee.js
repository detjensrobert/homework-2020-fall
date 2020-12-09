function searchEmployeeByFirstName() {
  const fname = document.getElementById("emp_search_name").value;

  if (fname) {
    window.location = `/employee/search/${fname}`;
  } else {
    window.location = "/employee";
  }
}
