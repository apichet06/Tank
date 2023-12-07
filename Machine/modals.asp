<!-- Modal -->
<div class="modal fade" id="Editmodals" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">แก้ไขข้อมูล Machine</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form id="update_data"> 
                   <div class="mb-2">
                         <label class="form-label">ชื่อเครื่องจักร</label>
                         <input type="text" class="form-control" name="EM_ID" id="EM_ID" hidden>
                         <input type="text" class="form-control" name="EM_Name" id="EM_Name" required autocomplete="off" placeholder="CS Code"> 
                   </div>
                  <div class="mb-3">
                                   <label class="form-label">Equipment</label>
                                          <select class="form-control select" id="EMC_EquipmentNo" name="MC_EquipmentNo" style="width: 100%" required>
                                                <option value="">--- เลื่อก Equipment ---</option> 
                                                     
                                                  <%
                                                    sql = "SELECT MC_EquipmentNo FROM [PPOnlineBPD].[dbo].[L_Machine] Where MC_RecordStatus = 'Y' and MC_Plant ='3000' "
                                                    SET rs = db95.Execute(sql)
                                                    While Not rs.EOF
                                                     %>
                                                        <option value="<%=rs("MC_EquipmentNo")%>"><%=rs("MC_EquipmentNo")%></option> 
                                                    <% 
                                                      rs.MoveNext
                                           Wend %>
                                  </select>
                   </div> 

        <div class="modal-footer"> 
        <button type="submit" class="btn btn-primary">แก้ไข</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิด</button> 
      </div>
      </div>
    </div>
  </div>
</div>