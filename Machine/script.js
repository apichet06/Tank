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

$("#insert_data").submit(function (e) {
    e.preventDefault();
    var formData = new FormData(this);
    var M_Name = $("#M_Name").val();
    var M_Building = $("#M_Building").val();
    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { M_Name: M_Name, M_Building: M_Building, insert: "insert" },
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
        confirmButtonText: 'ตกลง'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                url: "./manages.asp",
                data: { M_ID: id, DEL: "delete" },
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

                    }
                }
            });
        }
    })

});

