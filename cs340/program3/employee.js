const express = require("express");
const router = express.Router();

function getProjects(res, mysql, ctx, complete) {
  mysql.pool.query("select Pnumber, Pname from PROJECT", (err, result) => {
    if (err) {
      res.write(JSON.stringify(err, null, 4));
      res.end();
    }

    ctx.projects = result;
    complete();
  });
}

function getEmployees(res, mysql, ctx, complete) {
  mysql.pool.query(
    "select Ssn, Fname, Lname, Salary, Dno from EMPLOYEE",
    (err, result) => {
      if (err) {
        res.write(JSON.stringify(err, null, 4));
        res.end();
      }

      ctx.employee = result;
      complete();
    }
  );
}

function getByProject(req, res, mysql, ctx, complete) {
  const query =
    "select Ssn, Fname, Lname, Salary Dno, WO.Pno from EMPLOYEE E, WORKS_ON WO where E.Ssn = WO.Essn and WO.Pno = ?";
  const param = [req.params.project];
  mysql.pool.query(query, param, (err, result) => {
    if (err) {
      res.write(JSON.stringify(err, null, 4));
      res.end();
    }

    ctx.employee = result;
    ctx.PNO = result[0].Pno;
    complete();
  });
}

function getProjectInfo(req, res, mysql, ctx, complete) {
  const query =
    "select Pname, Pnumber, Plocation from PROJECT where Pnumber = ?";
  const param = [req.params.project];

  mysql.pool.query(query, param, (err, result) => {
    if (err) {
      res.write(JSON.stringify(err, null, 4));
      res.end();
    }

    ctx.Projectname = result[0].Pname;
    ctx.Projectlocation = result[0].Plocation;
    complete();
  });
}

function getByName(req, res, mysql, ctx, complete) {
  const query = `select Ssn, Fname, Lname, Salary, Dno from EMPLOYEE where Fname like ${mysql.pool.escape(
    `${req.params.s}%`
  )}`;
  mysql.pool.query(query, (err, result) => {
    if (err) {
      res.write(JSON.stringify(err, null, 4));
      res.end();
    }

    ctx.employee = result;
    complete();
  });
}

router.get("/", (req, res) => {
  let callback_count = 0;
  let ctx = {};
  ctx.jsscripts = ["filterEmployee.js", "searchEmployee.js"];
  const mysql = req.app.get("mysql");

  function complete() {
    callback_count++;
    if (callback_count >= 2) {
      res.render("employee", ctx);
    }
  }

  getEmployees(res, mysql, ctx, complete);
  getProjects(res, mysql, ctx, complete);
});

router.get("/filter/:project", (req, res) => {
  let callback_count = 0;
  let ctx = {};
  ctx.jsscripts = ["filterEmployee.js", "searchEmployee.js"];
  const mysql = req.app.get("mysql");

  function complete() {
    callback_count++;
    if (callback_count >= 3) {
      res.render("employee", ctx);
    }
  }

  getByProject(req, res, mysql, ctx, complete);
  getProjectInfo(req, res, mysql, ctx, complete);
  getProjects(res, mysql, ctx, complete);
});

router.get("/search/:s", (req, res) => {
  let callback_count = 0;
  let ctx = {};
  ctx.jsscripts = ["filterEmployee.js", "searchEmployee.js"];
  const mysql = req.app.get("mysql");

  function complete() {
    callback_count++;
    if (callback_count >= 2) {
      res.render("employee", ctx);
    }
  }

  getByName(req, res, mysql, ctx, complete);
  getProjects(res, mysql, ctx, complete);
});

module.exports = router;
