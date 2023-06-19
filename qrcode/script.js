$(".insert_data").click(function (e) {
    e.preventDefault();
    var T_ID = $(this).data("t_id");

    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { T_ID: T_ID, insert: "insert" },
        dataType: "json",
        success: function (response) {
            window.location.reload();
        }
    });

})

$("#cleanup").click(function (e) {
    e.preventDefault();
    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { cleanup: "cleanup" },
        dataType: "json",
        success: function (response) {
            window.location.reload();
        }
    });
});

$(document).ready(function () {
    $('#example').DataTable();
});