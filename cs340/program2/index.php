<?php
session_start();
//$currentpage="View Employees";
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>CS340 Program 2</title>

  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!-- Latest compiled JavaScript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style type="text/css">
  .wrapper {
    width: 70%;
    margin: 0 auto;
  }

  .page-header h2 {
    margin-top: 0;
  }

  table tr td:last-child a {
    margin-right: 15px;
  }
  </style>
  <script type="text/javascript">
  $(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip();
  });
  $('.selectpicker').selectpicker();
  </script>
</head>

<body>
  <?php require_once "config.php"; ?>

  <div class="wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="page-header clearfix">
            <div class="pull-left"><h2>Employee Details</h2><h4>Robert Detjens</h4></div>
            <a href="createEmployee.php" class="btn btn-success pull-right">Add New Employee</a>
          </div>
          <?php
          // Include config file
          require_once "config.php";

          $sql =
              "SELECT Ssn,Fname,Lname,Salary, Address, Bdate, PayLevel(Ssn) as Level, Super_ssn, Dno FROM EMPLOYEE";

          if ($result = mysqli_query($link, $sql)) {
              if (mysqli_num_rows($result) > 0) {
                  echo "<table class='table table-bordered table-striped'>";
                  echo "<thead>";
                  echo "<tr>";
                  echo "<th width=8%>SSN</th>";
                  echo "<th width=10%>First Name</th>";
                  echo "<th width=10%>Last Name</th>";
                  echo "<th width=15%>Address</th>";
                  echo "<th width=10%>Birthdate</th>";
                  echo "<th width=5%>Salary</th>";
                  echo "<th width=10%>Level</th>";
                  echo "<th width=8%>Super SSN</th>";
                  echo "<th width=5%>Dno</th>";
                  echo "<th width=10%>Action</th>";
                  echo "</tr>";
                  echo "</thead>";
                  echo "<tbody>";
                  while ($row = mysqli_fetch_array($result)) {
                      echo "<tr>";
                      echo "<td>{$row["Ssn"]}</td>";
                      echo "<td>{$row["Fname"]}</td>";
                      echo "<td>{$row["Lname"]}</td>";
                      echo "<td>{$row["Address"]}</td>";
                      echo "<td>{$row["Bdate"]}</td>";
                      echo "<td>${$row["Salary"]}</td>";
                      echo "<td>{$row["Level"]}</td>";
                      echo "<td>{$row["Super_ssn"]}</td>";
                      echo "<td>{$row["Dno"]}</td>";
                      echo "<td>";
                      echo "<a href='viewProjects.php?Ssn={$row["Ssn"]}' title='View Projects' data-toggle='tooltip'><span class='glyphicon glyphicon-eye-open'></span></a>";
                      echo "<a href='viewDependents.php?Ssn={$row["Ssn"]}' title='View Dependents' data-toggle='tooltip'><span class='glyphicon glyphicon-user'></span></a>";
                      echo "<a href='updateEmployee.php?Ssn={$row["Ssn"]}' title='Update Record' data-toggle='tooltip'><span class='glyphicon glyphicon-pencil'></span></a>";
                      echo "<a href='deleteEmployee.php?Ssn={$row["Ssn"]}' title='Delete Record' data-toggle='tooltip'><span class='glyphicon glyphicon-trash'></span></a>";
                      echo "</td>";
                      echo "</tr>";
                  }
                  echo "</tbody>";
                  echo "</table>";
                  // Free result set
                  mysqli_free_result($result);
              } else {
                  echo "<p class='lead'><em>No records were found.</em></p>";
              }
          } else {
              echo "ERROR: Could not able to execute $sql. <br>" .
                  mysqli_error($link);
          }
          echo "<br> <h2> Department Stats </h2> <br>";

          // Select Department Stats

          $sql2 = "SELECT * FROM DEPT_STATS";
          if ($result2 = mysqli_query($link, $sql2)) {
              if (mysqli_num_rows($result2) > 0) {
                  echo "<div class='col-md-4'>";
                  echo "<table width=30% class='table table-bordered table-striped'>";
                  echo "<thead>";
                  echo "<tr>";
                  echo "<th width=20%>Dno</th>";
                  echo "<th width = 20%>Number of Employees</th>";
                  echo "<th width = 40%>Average Salary</th>";

                  echo "</thead>";
                  echo "<tbody>";
                  while ($row = mysqli_fetch_array($result2)) {
                      echo "<tr>";
                      echo "<td>{$row["Dnumber"]}</td>";
                      echo "<td>{$row["Emp_count"]}</td>";
                      echo "<td>{$row["Avg_salary"]}</td>";

                      echo "</tr>";
                  }
                  echo "</tbody>";
                  echo "</table>";
                  // Free result set
                  mysqli_free_result($result2);
              } else {
                  echo "<p class='lead'><em>No records were found for Dept Stats.</em></p>";
              }
          } else {
              echo "ERROR: Could not able to execute $sql2. <br>" .
                  mysqli_error($link);
          }

          // Close connection
          mysqli_close($link);
          ?>
        </div>
      </div>
    </div>
  </div>
</body>

</html>
