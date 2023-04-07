$(document).ready(function () {
  $("form.create-customer-form").on("submit", function (event) {
    event.preventDefault();

    $.ajax({
      url: "createCustomer.php",
      type: "POST",
      data: $(this).serialize(),
      success: function (response) {
        if (
          response.trim() ===
          "An account linked with the current email already exists"
        ) {
          $("#result").css({
            color: "red",
            "text-transform": "uppercase",
            "font-weight": "bold",
            "font-style": "normal",
          });
        } else {
          $("#result").css({
            color: "black",
            "text-transform": "none",
            "font-style": "italic",
            "font-weight": "normal",
          });
        }
        $("#result").html(response);
      },
      error: function (xhr, status, error) {
        console.log(xhr, status, error);
        $("#result").html("Error: Unable to process the request");
      },
    });
  });
});
