<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/PhotographyQueryManager.asp" -->
<%
  pageTitle = "View Photos"

  ppid = request("ppid")    
  uid = request("uid")
  selectedPhotoId = ""
  
  if ppid <> "" then
    photoPersonId = ppId
    sql = "SELECT contract_id FROM photography_people WHERE photo_person_id = " & escapeString(photoPersonId)
    set personRecSet = executeYBQuery(sql)
    if personRecSet.EOF = False then
      contractId = personRecSet("contract_id")
    end if
    
  elseif uid <> "" then
    sql = "SELECT contract_id, photo_person_id, photography_user_id FROM photography_users WHERE user_guid = '" & escapeString(uid) & "'"
    set uRecSet = executeYBQuery(sql)
  
    if uRecSet.EOF = false then
      contractId = uRecSet("contract_id")
      photoPersonId = uRecSet("photo_person_id")
      set personRecSet = getPhotographyPersonInformation(photoPersonId)
      personName = personRecSet("first_name") & " " & personRecSet("last_name")
      sql = "SELECT org_id FROM service_contracts WHERE contract_id = '" & contractId & "'"
      set conRecSet = executeYBQuery(sql)
      if conRecSet.EOF = false then
        orgId = conRecSet("org_id")
        set orgRecSet = getOrganizationInformation(orgId)
        if orgRecSet.EOF = false then
          schoolName = orgRecSet("org_name")
        end if
      end if
      
      sql = "SELECT photography_photo_id FROM photography_user_photos WHERE photography_user_id = '" & escapeString(uRecSet("photography_user_id")) & "' " & _
        "AND photo_person_id = " & photoPersonId
      set sRecSet = executeYBQuery(sql)
      if sRecSet.EOF = false then
        selectedPhotoId = sRecSet("photography_photo_id")
      end if  
    else
      response.redirect "/index.asp"
    end if
  end if
  
%>
<!-- #include File="./_header.asp" -->
  <style>
    #submitCol {
      text-align: right;
    }
        
    .submitRow {
      margin-top: 20px;
    }
    
  </style>
  <script language="javascript">
    var _lastPhotoId = null;
    
    function selectPhoto(photoId) {
      if (_lastPhotoId !== null) {
        $("#imgDiv_" + _lastPhotoId).removeClass("imgDivSelected");
      }
      $("#imgDiv_" + photoId).addClass("imgDivSelected");
      $("#imgDiv_" + photoId).removeClass("imgDiv:hover");
      document.theForm.photo_id.value = photoId;
      _lastPhotoId = photoId;
      
    }
    function submitForm() {
      var errMsg = "";
      var theForm = document.theForm;
      
      <%
        if contractId <> "" then 
      %>
      if (theForm.email_address.value == '') {
        errMsg += " - Please enter your email address\n";
      }  
      if (theForm.student_id.value == '') {
        errMsg += " - Please enter your student id\n";
      }  
      <%
        
        else
      %>
      if (theForm.school_name.value == '') {
        errMsg += " - Please enter a school name\n";
      }  
      <%
        end if
      %>
      if (errMsg !== "") {
        alert("Error submitting the form.\n" + errMsg);        
        return false;
      }
      else {
        return true;
      }
    }
    
    $(document).ready(function() {
    <% 
      if selectedPhotoId <> "" then 
    %>
    selectPhoto('<%= selectedPhotoId %>');
    <%  
      end if
    %>
    });
    
  </script>
  <form name="theForm" action="/ViewPhotosAction.asp" onsubmit="return submitForm();">
    <input type="hidden" name="photo_id" value="<%= selectedPhotoId %>">
    <input type="hidden" name="uid" value="<%= uid %>">
    <div class="container">
      <div class="row">
        <div id="" class="col-xs-12 col-md-12">
          <h1><%= personName %></h1>
          <h3><%= schoolName %></h3>
          <p>
            Select the photo pose you would like with your photo order. Click the "Select Photo" button when you are finished.  
            If you have not ordered a photo package, please refer to your photo order instructions from your school. 
          </p>
        </div>
      </div>
      <%
        sql = "SELECT photography_photo_id, photo_file_name, photo_url, photo_thumbnail_url, photo_status, photo_height, " & _
          "photo_width, photo_person_id, people_id, member_id, yearbook_id, photo_file_name, " & _
          "update_date, create_date FROM photography_photos WHERE photo_person_id = " & photoPersonId
        set pRecSet = executeYBQuery(sql)
      %>
      <div class="row">
      <%
        do while not pRecSet.EOF
      %>
        <div class="col-md-4 col-xs-12">   
          <div class="imgDiv" onclick="selectPhoto('<%= pRecSet("photography_photo_id") %>');" id="imgDiv_<%= pRecSet("photography_photo_id") %>">
            <div class="imgPreviewDiv">
              <img src="<%= pRecSet("photo_thumbnail_url") %>" alt="" border="0" class="img-responsive">
              <div class="imgOverlay">
              </div>
            </div>
            <div class="imgFileName">   
              <%= pRecSet("photo_file_name") %>
            </div>
          </div>
        </div>
      <%
          pRecSet.MoveNext
        loop
      %>
      </div>
      <div class="row submitRow">
        <div id="submitCol" class="col-xs-12 col-md-12">
          <input class="btn btn-default" value="Select Photo" type="submit">
        </div>
      </div>
    </div>
  </form>
      
<!-- #include File="./_footer.asp" -->
