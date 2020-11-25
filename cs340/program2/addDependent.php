<?php
session_start();
ob_start();
$Ssn = $_SESSION["Ssn"];
// Include config file
require_once "config.php";

// Define variables and initialize with empty values
$Depname = $Depsex = $Depbday = $Deprelation = "";
$General_err = $Depname_err = $Depsex_err = $Depbday_err = $Deprelation_err =
    "";

// Processing form data when form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $Depname = trim($_POST["Depname"]);
    $Depsex = trim($_POST["Depsex"]);
    $Depbday = trim($_POST["Depbday"]);
    $Deprelation = trim($_POST["Deprelation"]);

    if (empty($Depname)) {
        $Depname_err = "Please enter a name.";
    } elseif (
        !filter_var($Depname, FILTER_VALIDATE_REGEXP, [
            "options" => ["regexp" => "/^[a-zA-Z\s]+$/"],
        ])
    ) {
        $Depname_err = "Please enter a valid name.";
    }

    if (empty($Depsex)) {
        $Depsex_err = "Please enter a sex.";
    }

    if (empty($Depbday)) {
        $Depbday_err = "Please enter a birthdate.";
    }

    if (empty($Deprelation)) {
        $Deprelation_err = "Please enter a relationship.";
    }

    // Check input errors before inserting in database
    if (
        empty($Depname_err) &&
        empty($Depsex_err) &&
        empty($Depbday_err) &&
        empty($Deprelation_err)
    ) {
        // Prepare an insert statement
        $sql =
            "INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES (?, ?, ?, ?, ?)";

        if ($stmt = mysqli_prepare($link, $sql)) {
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param(
                $stmt,
                "issss",
                $param_Essn,
                $param_Depname,
                $param_Depsex,
                $param_Depbday,
                $param_Deprelation
            );

            // Set parameters
            $param_Essn = $Ssn;
            $param_Depname = $Depname;
            $param_Depsex = $Depsex;
            $param_Depbday = $Depbday;
            $param_Deprelation = $Deprelation;

            // Attempt to execute the prepared statement
            if (mysqli_stmt_execute($stmt)) {
                // Records created successfully. Redirect to landing page
                header("location: viewDependents.php");
                exit();
            } else {
                echo "<center><h4>Error while adding a new dependent.</h4></center>";
                $General_err = "Something went wrong!";
            }
        }

        // Close statement
        mysqli_stmt_close($stmt);
    }

    // Close connection
    mysqli_close($link);
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Create Record</title>
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
            <h2>Add a Dependent</h2>
          </div>
          <p>Employeee SSN = <?php echo $Ssn; ?></p>
          <form action="<?php echo htmlspecialchars(
              $_SERVER["PHP_SELF"]
          ); ?>" method="post">
            <div class="form-group <?php echo !empty($General_err)
                ? "has-error"
                : ""; ?>"><?php echo $General_err; ?></div>

            <div class="form-group <?php echo !empty($Depname_err)
                ? "has-error"
                : ""; ?>">
              <label>Dependent Name</label>
              <input type="text" name="Depname" class="form-control" value="<?php echo $Depname; ?>">
              <span class="help-block"><?php echo $Depname_err; ?></span>
            </div>

            <div class="form-group <?php echo !empty($Deprelation_err)
                ? "has-error"
                : ""; ?>">
              <label>Relationship</label>
              <input type="text" name="Deprelation" class="form-control" value="<?php echo $Deprelation; ?>">
              <span class="help-block"><?php echo $Deprelation_err; ?></span>
            </div>

            <div class="form-group <?php echo !empty($Depsex_err)
                ? "has-error"
                : ""; ?>">
              <label>Sex</label>
              <input type="text" name="Depsex" class="form-control" value="<?php echo $Depsex; ?>">
              <span class="help-block"><?php echo $Depsex_err; ?></span>
            </div>

            <div class="form-group <?php echo !empty($Depbday_err)
                ? "has-error"
                : ""; ?>">
              <label>Birthday</label>
              <input type="date" name="Depbday" class="form-control" value="<?php echo $Depbday; ?>">
              <span class="help-block"><?php echo $Depbday_err; ?></span>
            </div>

            <input type="submit" class="btn btn-primary" value="Submit">
            <a href="viewDependents.php" class="btn btn-default">Cancel</a>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
