window.addEventListener("error", function (e) {
    if (e.target.tagName === "LINK" && e.target.href.includes("fa-solid-900.woff2")) {
        e.preventDefault();
        e.stopPropagation();
    }
}, true);

$(function () {
    $('#TK_Date').datetimepicker({
        format: 'YYYY-MM-DD',
    });
});

$(document).ready(function () {
    $('#example').DataTable();
});
$(".select2").select2({
    width: 'resolve'
});


$(".edit").click(function (e) {
    e.preventDefault();

    var id = $(this).data("id");
    var M_ID = $(this).data("m_id");
    var T_Name = $(this).data("t_name")
    var CS_ID = $(this).data("cs_id")
    var T_QTY = $(this).data("t_qty")
    var T_Change = $(this).data("t_change")
    var T_Period = $(this).data("t_period")

    $("#ET_ID").val(id)
    $("#EM_ID").val(M_ID).select2()
    $("#ET_Name").val(T_Name)
    $("#ECS_ID").val(CS_ID).select2()
    $("#ET_QTY").val(T_QTY).select2()
    $("#ET_Change").val(T_Change).select2()
    $("#ET_Period").val(T_Period).select2()

});


$("#Update_data").submit(function (e) {
    e.preventDefault();

    var T_ID = $("#ET_ID").val();
    console.log(T_ID);
    var M_ID = $("#EM_ID").val();
    var T_Name = $("#ET_Name").val();
    var CS_ID = $("#ECS_ID").val()
    var T_QTY = $("#ET_QTY").val()
    var T_Change = $("#ET_Change").val()
    var T_Period = $("#ET_Period").val()
    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { T_ID: T_ID, M_ID: M_ID, T_Name: T_Name, CS_ID: CS_ID, T_QTY: T_QTY, T_Change: T_Change, T_Period: T_Period, update: "update" },
        dataType: "json",
        success: function (response) {
            if (response.data == "1") {

                $("#staticBackdrop").hide();

                Swal.fire({
                    title: 'แก้ไขข้อมูลสำเร็จ',
                    icon: 'success',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'ตกลง'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.reload();
                    }
                })
            } else {
                Swal.fire({
                    title: 'ข้อมูลซ้ำ',
                    icon: 'error',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'ตกลง'
                })

            }

        }
    });

});
$("#insert_data").submit(function (e) {
    e.preventDefault();
    // var formData = new FormData(this);

    var M_ID = $("#M_ID").val();
    var T_Name = $("#T_Name").val();
    var CS_ID = $("#CS_ID").val()
    var T_QTY = $("#T_QTY").val()
    var T_Change = $("#T_Change").val()
    var T_Period = $("#T_Period").val()
    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { M_ID: M_ID, T_Name: T_Name, CS_ID: CS_ID, T_QTY: T_QTY, T_Change: T_Change, T_Period: T_Period, insert: "insert" },
        dataType: "json",
        success: function (response) {
            if (response.data == "1") {
                Swal.fire({
                    title: 'บันทึกข้อมูลสำเร็จ',
                    icon: 'success',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'ตกลง'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.reload();
                    }
                })
            } else {
                Swal.fire({
                    title: 'ข้อมูลซ้ำ',
                    icon: 'error',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'ตกลง'
                })

            }

        }
    });

});

$(".del").click(function (e) {
    e.preventDefault();
    var id = $(this).data("id")
    Swal.fire({
        title: 'ต้องการลบหรือไม่',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'ใช่'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                url: "./manages.asp",
                data: { T_ID: id, DEL: "delete" },
                dataType: "json",
                success: function (response) {

                    if (response.data == "1") {
                        Swal.fire({
                            title: 'ลบข้อมูลสำเร็จ',
                            icon: 'success',
                            showCancelButton: false,
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'ตกลง'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.reload();
                            }
                        })

                    } else if (response.data == "11") {
                        Swal.fire({
                            title: 'ข้อมูลถูกใช้งานไม่สามารถลบได้',
                            icon: 'error',
                            showCancelButton: false,
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: 'ตกลง'
                        })

                    }
                }

            });
        }
    })

});

