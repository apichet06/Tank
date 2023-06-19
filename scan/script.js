
$(function () {
    $('#TK_Date').datetimepicker({
        format: 'YYYY-MM-DD HH:mm',
        // format: 'L'
    });
});

$("#insert_data").submit(function (e) {
    e.preventDefault();
    var formData = new FormData(this);
    var TK_Date = $("#TK_Date").val();
    var T_ID = $("#T_ID").val();
    $.ajax({
        type: "post",
        url: "../Service/manages.asp",
        data: { TK_Date: TK_Date, T_ID: T_ID, insert: "insert" },
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