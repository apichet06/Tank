window.addEventListener("error", function (e) {
    if (e.target.tagName === "LINK" && e.target.href.includes("fa-solid-900.woff2")) {
        e.preventDefault();
        e.stopPropagation();
    }
}, true);

$(function () {
    $('#TK_Date').datetimepicker({
        format: 'YYYY-MM-DD HH:mm',
    });
});

$(".select2").select2({});

$(document).ready(function () {
    $('#example').DataTable();
});

$("#insert_data").submit(function (e) {
    e.preventDefault();
    var formData = new FormData(this);
    var TK_Date = $("#TK_Date").val();
    var T_ID = $("#T_ID").val();
    $.ajax({
        type: "post",
        url: "./manages.asp",
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

function formatDate(dateString, format) {
    if (dateString === "" || dateString === undefined) {
        return "N/A";
    }

    var dateParts = dateString.split(" ")[0].split("/");
    var timeParts = dateString.split(" ")[1].split(":");

    var day = parseInt(dateParts[0], 10);
    var month = parseInt(dateParts[1], 10);
    var year = parseInt(dateParts[2], 10);

    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }

    var hours = timeParts[0];
    var minutes = timeParts[1];

    var formattedDate = format
        .replace("DD", day)
        .replace("MM", month)
        .replace("YYYY", year)
        .replace("HH", hours)
        .replace("mm", minutes);

    return formattedDate;
}


// function formatDateNextTime(dateString, T_Change, T_Period, format) {
//     if (dateString === "" || dateString === undefined) {
//         return "N/A";
//     }

//     var dateParts = dateString.split(" ")[0].split("/");
//     var timeParts = dateString.split(" ")[1].split(":");

//     var day = parseInt(dateParts[0], 10);
//     var month = parseInt(dateParts[1], 10);
//     var year = parseInt(dateParts[2], 10);

//     if (day < 10) {
//         day = "0" + day;
//     }
//     if (month < 10) {
//         month = "0" + month;
//     }

//     var hours = timeParts[0];
//     var minutes = timeParts[1];

//     var dateObject = new Date(year, month - 1, day, hours, minutes);
//     dateObject.setMonth(dateObject.getMonth() + T_Change);
//     switch (T_Period) {
//         case "hour":
//             dateObject.setHours(dateObject.getHours() + T_Change); // Add 6 hours
//             break;
//         case "day":
//             dateObject.setDate(dateObject.getDate() + T_Change); // Add 6 hours
//             break;
//         case "month":
//             dateObject.setMonth(dateObject.getMonth() + T_Change); // Add 6 hours
//             break;
//         case "week":
//             dateObject.setWeek(dateObject.getWeek() + T_Change); // Add 6 hours
//             break;
//         default:
//             dateObject.setYear(dateObject.getYear() + T_Change); // Add 6 hours
//             break;
//     }
//     var formattedDate = format
//         .replace("DD", padZero(dateObject.getDate()))
//         .replace("MM", padZero(dateObject.getMonth() + 1))
//         .replace("YYYY", dateObject.getFullYear())
//         .replace("HH", padZero(dateObject.getHours()))
//         .replace("mm", padZero(dateObject.getMinutes()));

//     return formattedDate;
// }

// function padZero(value) {
//     return value < 10 ? "0" + value : value;
// }

function formatDateNextTime(dateString, T_Change, T_Period, format) {
    if (dateString === "" || dateString === undefined) {
        return "N/A";
    }

    var dateParts = dateString.split(" ")[0].split("/");
    var timeParts = dateString.split(" ")[1].split(":");

    var day = parseInt(dateParts[0], 10);
    var month = parseInt(dateParts[1], 10);
    var year = parseInt(dateParts[2], 10);

    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }

    var hours = timeParts[0];
    var minutes = timeParts[1];

    var dateObject = new Date(year, month - 1, day, hours, minutes);
    var chang = parseInt(T_Change, 10);

    switch (T_Period) {
        case "hour":
            dateObject.setHours(dateObject.getHours() + chang); // hours
            break;
        case "day":
            dateObject.setDate(dateObject.getDate() + chang);
            break;
        case "month":
            dateObject.setMonth(dateObject.getMonth() + chang);
            break;
        case "weeks":
            dateObject.setDate(dateObject.getDate() + (chang * 7)); // Add 1 week 
            break;
        default:
            dateObject.setFullYear(dateObject.getFullYear() + chang);
            break;
    }

    var formattedDate = format
        .replace("DD", padZero(dateObject.getDate()))
        .replace("MM", padZero(dateObject.getMonth() + 1))
        .replace("YYYY", dateObject.getFullYear())
        .replace("HH", padZero(dateObject.getHours()))
        .replace("mm", padZero(dateObject.getMinutes()));

    return formattedDate;
}

function padZero(value) {
    return value < 10 ? "0" + value : value;
}

$("#T_ID").change(function (e) {
    e.preventDefault();
    var T_ID = $("#T_ID").val();
    $.ajax({
        type: "post",
        url: "./manages.asp",
        data: { T_ID: T_ID, Data: "Data" },
        dataType: "json",
        success: function (data) {
            console.log(data.T_Period);
            const tkDate = data.TK_Date === "" ? "N/A" : formatDate(data.TK_Date, "DD-MM-YYYY HH:mm");
            const tkDateNexTime = data.TK_Date === "" ? "N/A" : formatDateNextTime(data.TK_Date, data.T_Change, data.T_Period, "DD-MM-YYYY HH:mm");
            $("#Data").html(

                `<div class="text-center">
                        ***
                    </div> 
                     <table class="table table-sm">
                    <thead>
                      <tr>
                        <th class="text-right">ชื่อเครื่องจักร :</th>
                        <th >${data.M_Name}</th> 
                      </tr>
                      <tr>
                        <th class="text-right">จุดที่เปลี่ยน :</th>
                        <th >${data.T_Name}</th> 
                      </tr>
                      <tr>
                        <th class="text-right">Code CS :</th>
                        <th >${data.CS_Code}</th> 
                      </tr>
                      <tr>
                        <th class="text-right">จำนวนที่ต้องเปลี่่ยน :</th>
                        <th >${data.T_QTY} EA</th> 
                      </tr>
                      <tr>
                        <th class="text-right">ความถี่ในการเปลี่ยน :</th>
                        <th >${data.T_Change} ${data.T_Period.toString().toUpperCase()}</th> 
                      </tr>
                      <tr>
                        <th class="text-right text-secondary">วันที่เปลี่ยน ล่าสุด :</th>
                        <th class="text-secondary">${tkDate}</th> 
                      </tr>
                      <tr>
                        <th class="text-right text-secondary">เปลี่ยนครั้งถัดไป :</th>
                        <th class="text-secondary">${tkDateNexTime} </th> 
                      </tr>
                    </thead> 
                  </table> 
                    <div class="text-center">
                    ***
                    </div> `

                //   "*** <br> Machine :" + data.M_Name +
                //     "<br> จุดที่เปลี่ยน : " + data.T_Name +
                //     "<br> Code CS : " + data.CS_Code +
                //     "<br> จำนวนที่ต้องเปลี่่ยน : " + data.T_QTY + " EA " +
                //     "<br> ความถี่ : " + data.T_Change + " " + data.T_Period.toString().toUpperCase() +
                //     "<br> วันที่เปลี่ยน ล่าสุด : " + tkDate +
                //     "<br> วันที่ต้องเปลี่ยนครั้งถัดไป : " + tkDate +
                //     "<br>*** "

            );
        }
    });
});