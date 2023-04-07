$(document).ready(function () {
  fetchEmployees();

  $("#viewScheduleButton").click(function () {
    const employeeId = $("#employeeSelect").val();
    const employeeName = $("#employeeSelect option:selected").text();
    if (employeeId) {
      fetchEmployeeSchedule(employeeId, employeeName);
    } else {
      $("#scheduleContainer").html("Please select an employee.");
    }
  });
});

function fetchEmployees() {
  $.ajax({
    url: "employeeSchedule.php",
    type: "GET",
    dataType: "json",
    success: function (response) {
      populateEmployeeDropdown(response);
    },
    error: function (xhr, status, error) {
      console.error("Error fetching employees:", error);
    },
  });
}

function populateEmployeeDropdown(employees) {
  const employeeSelect = $("#employeeSelect");
  employeeSelect.empty();
  employeeSelect.append('<option value=""></option>');
  employees.forEach((employee) => {
    employeeSelect.append(
      `<option value="${employee.id}">${employee.firstName} ${employee.lastName}</option>`
    );
  });
}

function fetchEmployeeSchedule(employeeId, employeeName) {
  $.ajax({
    url: "employeeSchedule.php",
    type: "GET",
    data: { id: employeeId },
    dataType: "json",
    success: function (response) {
      displayEmployeeSchedule(response, employeeName);
    },
    error: function (xhr, status, error) {
      console.error("Error fetching schedule:", error);
    },
  });
}

function displayEmployeeSchedule(schedule, employeeName) {
  let scheduleHtml = "";
  if (schedule.length === 0) {
    scheduleHtml = `<p class="schedule-no-shifts">${employeeName} currently has no visible shifts</p>`;
  } else {
    scheduleHtml = `<h2 class="schedule-heading">${employeeName}'s Schedule</h2>`;
    schedule.forEach((shift) => {
      scheduleHtml += `${shift.day}: ${shift.startTime} - ${shift.endTime}<br>`;
    });
  }
  $("#scheduleContainer").html(scheduleHtml);
}
