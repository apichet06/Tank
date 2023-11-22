<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">แก้ไขรายการข้อมูลจุดที่ต้องเปลี่ยน</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                <form id="Update_data">
                           <div class="form-row"> 
                                    <div class="form-group col-md-12">
                                           <label class="form-label">เครื่องจักร</label>
                                                <select class="form-control select2" id="EM_ID" name="M_ID" required style="width: 100%">
                                                    <option value="">--- เครื่องจักร ---</option> 
                                                            <% 
                                                            sql = " SELECT * FROM [TankDB].[dbo].[Machine] Where M_Status = 1 "
                                                            SET rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            %>
                                                                <option value="<%=rs("M_ID")%>"><%=rs("M_Name")%></option>  
                                                            <% 
                                                            i = i + 1
                                                            rs.MoveNext
                                                            Wend
                                                            %>
                                                    </select>
                                            </div> 
                                            <div class="form-group col-md-12 ">
                                                <label class="form-label">จุดที่ต้องเปลี่ยน</label>
                                                <input type="text" class="form-control" name="T_Name" id="ET_Name" required autocomplete="off" placeholder="จุดที่ต้องเปลี่ยน">
                                                <input type="text" class="form-control" name="ET_ID" id="ET_ID" required  hidden>
                                            </div>
                                            <div class="form-group col-md-12 ">
                                                <label class="form-label">Code CS</label>
                                               <select class="form-control select2" id="ECS_ID" name="CS_ID" required style="width: 100%">
                                                    <option value="">--- CsCode ---</option> 
                                                            <% 
                                                            sql = " SELECT * FROM [TankDB].[dbo].[CsCode] Where CS_Status = 1 "
                                                            SET rs = db.Execute(sql)
                                                            While Not rs.EOF
                                                            %>
                                                                <option value="<%=rs("CS_ID")%>"><%=rs("CS_Code")%></option>  
                                                            <% 
                                                            i = i + 1
                                                            rs.MoveNext
                                                            Wend
                                                            %>
                                                    </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label class="form-label">จำนวนที่เปลี่ยนต่อครั้ง(EA)</label>
                                                <select class="form-control select2" id="ET_QTY" name="T_QTY" required style="width: 100%">
                                                        <option value="">จำนวนที่เปลี่ยนต่อครั้ง(EA)</option>  
                                                        <%   For i = 1 To 2000 %> 
                                                         <option value="<%=i%>"><%=i%></option>  
                                                        <%  Next %>
                                                </select> 
                                            </div>
                                            <div class="form-group col-md-3">
                                                <label class="form-label">ความถี่ในการเปลี่ยน</label>
                                                <select class="form-control select2" id="ET_Change" name="T_Change" required style="width: 100%">
                                                       <option value="">--- ความถี่ ---</option>  
                                                        <%   For i = 1 To 1000 %> 
                                                         <option value="<%=i%>"><%=i%></option>  
                                                        <%  Next %>
                                                </select>         
                                            </div> 
                                            <div class="form-group col-md-4">
                                                <label class="form-label">วัน/เดือน/ปี</label>
                                                 <select class="form-control select2" id="ET_Period" name="T_Period" required style="width: 100%">
                                                    <option value="">--- วัน/สัปดาห์/เดือน/ปี ---</option>
                                                    <option value="hour">ชั่วโมง</option>  
                                                    <option value="day">วัน</option>   
                                                    <option value="weeks">สัปดาห์</option>  
                                                    <option value="month">เดือน</option>  
                                                    <option value="year">ปี</option>  
                                                </select>
                                            </div>
                                            <div class="form-group col-md-1">
                                                 <label class="form-label text-light">-</label>
                                                  <input type="text" class="form-control" disabled value="ครั้ง">
                                            </div>
                                        </div> 
                                         <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">ยืนยันแก้ไข</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> 
                                        </div>
                          </form>
        </div> 
    </div>
  </div>
</div>