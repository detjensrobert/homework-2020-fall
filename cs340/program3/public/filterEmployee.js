function filterEmployeeByProject() {
  const project_pno = document.getElementById("project_filter").value;
  window.location = `/employee/filter/${parseInt(project_pno)}`;
}
