<?php
session_start();
if (isset($_GET["Ssn"]) && !empty(trim($_GET["Ssn"]))) {
    $_SESSION["Ssn"] = $_GET["Ssn"];
}

require_once "config.php";

// Delete a dependent record after confirmation
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_SESSION["Ssn"]) && !empty($_SESSION["Ssn"])) {
        $Ssn = $_SESSION["Ssn"];
        $Depname = $_POST["Depname"];
        // Prepare a delete statement
        $sql = "DELETE FROM DEPENDENT WHERE Essn = ? AND Dependent_name = ?";

        if ($stmt = mysqli_prepare($link, $sql)) {
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "ss", $param_Ssn, $param_Name);

            // Set parameters
            $param_Ssn = $Ssn;
            $param_Name = $Depname;

            // Attempt to execute the prepared statement
            if (mysqli_stmt_execute($stmt)) {
                // Records deleted successfully. Redirect to landing page
                header("location: viewDependents.php");
                exit();
            } else {
                echo "Error deleting the dependent";
            }
        }
    }
    // Close statement
    mysqli_stmt_close($stmt);

    // Close connection
    mysqli_close($link);
} else {
    // Check existence of id parameter
    if (empty(trim($_GET["Ssn"]))) {
        // URL doesn't contain id parameter. Redirect to error page
        header("location: error.php");
        exit();
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Delete Record</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
  <style type="text/css">
  .wrapper {
    width: 500px;
    margin: 0 auto;
  }
  </style>
</head>

<body>
  <div class="wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="page-header">
            <h1>Delete Dependent</h1>
          </div>
          <form action="<?php echo htmlspecialchars(
              $_SERVER["PHP_SELF"]
          ); ?>" method="post">
            <div class="alert alert-danger fade in">
              <input type="hidden" name="Ssn" value="<?php echo $_SESSION[
                  "Ssn"
              ]; ?>" />
              <input type="hidden" name="Depname" value="<?php echo $_GET[
                  "Depname"
              ]; ?>" />
              <p>Are you sure you want to delete the record for <?php echo $_GET[
                  "Depname"
              ]; ?>?</p>
              <br>
              <input type="submit" value="Yes" class="btn btn-danger">
              <a href="viewDependents.php" class="btn btn-default">No</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>

</html>
