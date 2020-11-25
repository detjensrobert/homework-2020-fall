<?php
session_start();
// Include config file
require_once "config.php";

// Define variables and initialize with empty values
$Depname = $Depsex = $Depbday = $Deprelation = "";
$General_err = $Depname_err = $Depsex_err = $Depbday_err = $Deprelation_err =
    "";

if (isset($_GET["Ssn"]) && !empty(trim($_GET["Ssn"]))) {
    $_SESSION["Ssn"] = trim($_GET["Ssn"]);
    $Depname = trim($_POST["Depname"]);

    // Prepare a select statement
    $sql1 = "SELECT * FROM DEPENDENT WHERE Essn = ? AND Dependent_name = ? ";

    if ($stmt1 = mysqli_prepare($link, $sql1)) {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "ss", $param_Ssn, $param_Name);

        // Set parameters
        $param_Ssn = $Ssn;
        $param_Depname = $Depname;

        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt1)) {
            $result1 = mysqli_stmt_get_result($stmt1);
            if (mysqli_num_rows($result1) > 0) {
                $row = mysqli_fetch_array($result1);

                $Depname = $row["Dependent_name"];
                $Depsex = $row["Sex"];
                $Depbday = $row["Bdate"];
                $Deprelation = $row["Relationship"];
            }
        }
    }
}

// Post information about the dependent when the form is submitted
// Processing form data when form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // the id is hidden and can not be changed
    $Ssn = $_SESSION["Ssn"];

    // Validate form data this is similar to the create Dependent file
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
        // Prepare an update statement
        $sql =
            "UPDATE DEPENDENT SET Essn = ?, Dependent_name = ?, Sex = ?, Bdate = ?, Relationship = ? WHERE Essn = ? AND Dependent_name = ?";

        if ($stmt = mysqli_prepare($link, $sql)) {
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param(
                $stmt,
                "issssis",
                $param_Essn,
                $param_Depname,
                $param_Depsex,
                $param_Depbday,
                $param_Deprelation,
                $param_Essn,
                $param_Depname
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
} else {
    // Check existence of sID parameter before processing further
    // Form default values

    if (isset($_GET["Ssn"]) && !empty(trim($_GET["Ssn"]))) {
        $_SESSION["Ssn"] = $_GET["Ssn"];
        $Depname = trim($_GET["Depname"]);

        // Prepare a select statement
        $sql1 = "SELECT * FROM Dependent WHERE Essn = ? AND Dependent_name = ?";

        if ($stmt1 = mysqli_prepare($link, $sql1)) {
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt1, "ss", $param_Ssn, $param_Depname);
            // Set parameters
            $param_Ssn = trim($_GET["Ssn"]);
            $param_Depname = $Depname;

            // Attempt to execute the prepared statement
            if (mysqli_stmt_execute($stmt1)) {
                $result1 = mysqli_stmt_get_result($stmt1);

                echo "$result1";
                if (mysqli_num_rows($result1) == 1) {
                    $row = mysqli_fetch_array($result1);

                    echo "$row";
                    $Depname = $row["Dependent_name"];
                    $Depsex = $row["Sex"];
                    $Depbday = $row["Bdate"];
                    $Deprelation = $row["Relationship"];
                } else {
                    // URL doesn't contain valid id. Redirect to error page
                    header("location: error.php");
                    exit();
                }
            } else {
                echo "Error in SSN while updating";
            }
        }
        // Close statement
        mysqli_stmt_close($stmt);

        // Close connection
        mysqli_close($link);
    } else {
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
  <title>Update Dependent</title>
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
            <h3>Update Dependent Record for Employee SSN = <?php echo $_GET[
                "Ssn"
            ]; ?> </H3>
          </div>
          <p>Please edit the input values and submit to update.
          <form action="<?php echo htmlspecialchars(
              basename($_SERVER["REQUEST_URI"])
          ); ?>" method="post">

            <input type="hidden" name="Ssn" value="<?php echo $Ssn; ?>" />

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
