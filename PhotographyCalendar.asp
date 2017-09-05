<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/PhotographyQueryManager.asp" -->
<!-- #include File="../../wwwroot/appservices/FormHandlerResources.asp" -->
<%
  pageTitle = "Photography Service Availability Calendar"
  adminMode = False
  if request("admin") <> "" then
    adminMode = True
  end if
  
  if request("delete_date") <> "" then
    sql = "UPDATE photography_calendar SET calendar_status = 'DELETED' WHERE calendar_id = " & escapeString(request("delete_date"))
    executeYBQuery sql
  end if
  
  CONFIRM_MIN = 1 
  BOOKED_MIN = 2
  BOOKED_STUDENT_MIN = 700
%>
<!-- #include File="./_header.asp" -->
  <style>
    ul {list-style-type: none;}
      body {font-family: Verdana, sans-serif;}
      
      /* Month header */
      .month {
          padding: 70px 25px;
          width: 100%;
          background: #1abc9c;
          text-align: center;
      }
      
      /* Month list */
      .month ul {
          margin: 0;
          padding: 0;
      }
      
      .month ul li {
          color: white;
          font-size: 20px;
          text-transform: uppercase;
          letter-spacing: 3px;
      }
      
      /* Previous button inside month header */
      .month .prev {
          float: left;
          padding-top: 10px;
      }
      
      /* Next button */
      .month .next {
          float: right;
          padding-top: 10px;
      }
      
      /* Weekdays (Mon-Sun) */
      .weekdays {
          margin: 0;
          padding: 10px 0;
          background-color:#ddd;
      }
      
      .weekdays li {
          display: inline-block;
          width: 13.6%;
          //color: #666;
          text-align: center;
      }
      
      /* Days (1-31) */
      .days {
          padding: 10px 0;
          background: #eee;
          margin: 0;
      }
      
      .days li {
          list-style-type: none;
          display: inline-block;
          width: 13.6%;
          text-align: left;
          margin-bottom: 5px;
          font-size:12px;
          vertical-align: text-top;
         // color:#777;
          padding: 5px;
          height: 80px;
          overflow: auto;
      }
      
      /* Highlight the "current" day */
      .days li .active {
          padding: 5px;
          background: #1abc9c;
          color: white !important
      }
      
      .legendBox {
        border: 1px solid #cccccc;
        padding: 5px;
        margin: 5px;
        text-align: center;
      }
      
      .availableDate {
        color: black;
        background-color: #ffffff;
      
      }
      
      .confirmDate {
        color: black;
        background-color: #ffff00;
      
      }
      
      .bookedDate {
        color: white;
        background-color: #990000;
      }
      
      #dateDetails {
        margin: 0px;
        padding: 10px;
      }
  </style>
  <script language="javascript">
    $(document).ready(function() {
    });
    
    function openCalendarDetails(thisDate) {
      var theURL = "PhotographyCalendarHandler.asp";
      var params = "type=DATE DETAILS&date=" + thisDate;
      var successFunct = function(msg) {
        var jsonObj = JSON.parse(msg);
        var dateDetails = document.getElementById("dateDetails");
        dateDetails.innerHTML = "";
        
        for (var i = 0; i < jsonObj.length; i++) {
          var rowDiv = document.createElement("div");
          rowDiv.className = "row";
          
          var contractName = document.createElement("div");
          contractName.className = "col-md-6";
          contractName.innerHTML = "<b><a href=\"http://admin.entourageyearbooks.com/ContractDetails.asp?contract_id=" + jsonObj[i].contract_id + "\" target=\"CONTRACT_" + jsonObj[i].contract_id + "\">" + jsonObj[i].org_name + "</a></b><BR>" 
                                  + jsonObj[i].org_city + ", " + jsonObj[i].org_state;
          
          var dateType = "Photo Date";
          var dateValue = thisDate
          
          if (jsonObj[i].retake_date == thisDate) {
            dateType = "Retake Date";
          }
          var dateTypeDiv = document.createElement("div");
          dateTypeDiv.className = "col-md-2";
          dateTypeDiv.innerHTML = dateType;
          
          var dateDiv = document.createElement("div");
          dateDiv.className = "col-md-2";
          dateDiv.innerHTML = thisDate;
          
          rowDiv.appendChild(contractName);
          rowDiv.appendChild(dateTypeDiv);          
          rowDiv.appendChild(dateDiv);          
          dateDetails.appendChild(rowDiv);
        }
        
        $("#calendarDetailWindow").modal();    
      }
      
      
      ajaxRequest2('GET', theURL, params, true, successFunct);
    }
    
    function updateForm() {
      document.theForm.submit();
    }
  </script>
  <form name="theForm" action="PhotographyCalendar.asp">
    <div class="container">
      <h1>Entourage Photography Calendar</h2>
      <div class="row">
      <%
        fieldType = "select"
        fieldName = "this_date"
        fieldCaption = "Select Month"
        fieldPlaceHolder = "Select Month"
        if request("fld_this_date") = "" then
          thisDate = Month(Now()) & "/1/" & Year(Now())
        else
          thisDate = request("fld_this_date")
        end if 
        
        colClasses = "col-md-6 col-xs-12"
        set fieldColl = CreateObject("Scripting.Dictionary")
        
        startMonth = Month(Now())
        startYear = Year(Now())
        thisMonth = Month(Now())
        thisYear = Year(Now())
        
        thisLastDay = Day(DateAdd("D", -1, DateAdd("M", 1, DateValue(thisDate))))
  
        for i = 1 to 12
          if thisMonth > 12 then
            thisMonth = 1
            thisYear = thisYear + 1
          end if
          label = MonthName(thisMonth) & " " & thisYear
          val = thisMonth & "/1/" & thisYear
          cls = ""
          
          set fieldColl(val) = getSelectionOptionColl(label, val, cls)
          thisMonth = thisMonth + 1        
        next
        attributes = "onchange=""updateForm()"""
        renderEntFormSelect fieldType, fieldName, fieldCaption, fieldPlaceHolder, thisDate, fieldColl, colClasses, attributes, helpInfo
        
        
        firstWeekDay = WeekDay(DateValue(thisDate))
        thisMonth = Month(DateValue(thisDate))
        thisYear = Year(DateValue(thisDate))
        
        
      %>
      </div>
      <div class="row">
        <div class="col-md-1 col-xs-4 availableDate legendBox">
          Available
        </div>
        <div class="col-md-1 col-xs-4 confirmDate legendBox">
          Confirm
        </div>
        <div class="col-md-1 col-xs-4 bookedDate legendBox">
          Booked
        </div>
        
      </div>
      <div class="row">
        <div class="month"> 
        <ul>
          <li>
            <%= MonthName(thisMonth) %><br>
            <span style="font-size:18px"><%= thisYear %></span>
          </li>
        </ul>
      </div>
      
      <ul class="weekdays">
        <li>Sun</li>
        <li>Mon</li>
        <li>Tues</li>
        <li>Weds</li>
        <li>Thurs</li>
        <li>Fri</li>
        <li>Sat</li>
      </ul>
      
      <ul class="days"> 
        <%
          dy = 1
          dayClass = ""
          for i = 1 to 42
            if i >= firstWeekDay then
              displayDay = dy
              dy = dy + 1
              dayClass = ""
              if  displayDay <= thisLastDay then
                thisPhotoDate = DateValue(thisMonth & "/" & displayDay & "/" & thisYear)
                nextPhotoDate = DateAdd("D", 1, thisPhotoDate)
                nnPhotoDate = DateAdd("D", 2, thisPhotoDate)
                yPhotoDate = DateAdd("D", -1, thisPhotoDate)
                
                sql = "SELECT contract_id, org_id, photo_date, retake_date " & _
                  "FROM view_service_contract_photography " & _
                  "WHERE ((photo_date >= '" & nextPhotoDate & "' AND photo_date < '" & nnPhotoDate & "') " & _
                  " OR (retake_date >= '" & nextPhotoDate & "' AND retake_date < '" & nnPhotoDate & "')) " & _
                  " AND contract_status not in ('PENDING', 'CLOSED', 'VOID') "
                set scRecSet = executeYBQuery(sql)
                nextDayTravel = 0
                do while scRecSet.EOF = False
                  set orgRecSet = getOrganizationInformation(scRecSet("org_id"))
                  if orgRecSet("org_state") <> "NJ" and orgRecSet("org_state") <> "NY" and orgRecSet("org_state") <> "PA" then
                    nextDayTravel = nextDayTravel + 1
                  end if
                  scRecSet.MoveNext
                loop
                if nextDayTravel > 0 then
                  dayClass = "confirmDate"
                end if
                
                sql = "SELECT contract_id, org_id, photo_date, retake_date " & _
                  "FROM view_service_contract_photography " & _
                  "WHERE ((photo_date >= '" & yPhotoDate & "' AND photo_date < '" & thisPhotoDate & "') " & _
                  " OR (retake_date >= '" & yPhotoDate & "' AND retake_date < '" & thisPhotoDate & "')) " & _
                  " AND contract_status not in ('PENDING', 'CLOSED', 'VOID') "
                set scRecSet = executeYBQuery(sql)
                nextDayTravel = 0
                do while scRecSet.EOF = False
                  set orgRecSet = getOrganizationInformation(scRecSet("org_id"))
                  if orgRecSet("org_state") <> "NJ" and orgRecSet("org_state") <> "NY" and orgRecSet("org_state") <> "PA" then
                    nextDayTravel = nextDayTravel + 1
                  end if
                  scRecSet.MoveNext
                loop
                if nextDayTravel > 0 then
                  dayClass = "confirmDate"
                end if
                
                sql = "SELECT contract_id, org_id, photo_date, retake_date " & _
                  "FROM view_service_contract_photography " & _
                  "WHERE ((photo_date >= '" & thisPhotoDate & "' AND photo_date < '" & nextPhotoDate & "') " & _
                  " OR (retake_date >= '" & thisPhotoDate & "' AND retake_date < '" & nextPhotoDate & "')) " & _
                  " AND contract_status not in ('PENDING', 'CLOSED', 'VOID') "
                set scRecSet = executeYBQuery(sql)
                contractCount = 0
                numStudents = 0
                
                do while scRecSet.EOF = False
                  thisNumStudents = getServiceContractParameterValue(scRecSet("contract_id"), "# of Students")
                  if scRecSet("photo_date") >= thisPhotoDate and scRecSet("photo_date") < nextPhotoDate then
                    if thisNumStudents <> "" then
                      numStudents = numStudents + thisNumStudents
                    end if
                  else
                    numStudents = numStudents + 300 ' Basically a retake date is 1 persond all day
                  end if
                  contractCount = contractCount + 1
                  scRecSet.MoveNext
                loop
                
                if contractCount >= CONFIRM_MIN and contractCount < BOOKED_MIN then
                  dayClass = "confirmDate"
                elseif contractCount >= BOOKED_MIN then
                  dayClass = "bookedDate"
                end if
                if numStudents > BOOKED_STUDENT_MIN then
                  dayClass = "bookedDate"
                end if
                
                
                ' Code to handle custom date from photography_calendar
                sql = "SELECT calendar_id, calendar_type, calendar_status, calendar_notes, calendar_date FROM photography_calendar " & _
                  "WHERE calendar_status not in ('DELETED') AND calendar_date = '" & thisPhotoDate & "' "
                set calRecSet = executeYBQuery(sql)
                calNotes = ""
                calendarId = ""
                if calRecSet.EOF = false then
                  if calRecSet("calendar_status") = "BOOKED" then
                    dayClass = "bookedDate"
                  elseif calRecSet("calendar_status") = "CONFIRM" then
                    dayClass = "confirmDate"
                  elseif calRecSet("calendar_status") = "AVAILABLE" then
                    dayClass = ""
                  end if
                  calNotes = calRecSet("calendar_notes")
                  calendarId = calRecSet("calendar_id")
                end if
              end if
            end if
            if displayDay > thisLastDay then
              displayDay = ""
              dayClass = ""
              numStudents = 0
            end if
                  
        %>
        <li class="<%= dayClass %>">
          <%= displayDay %> 
          <br>
          <br>          
          <%
            if adminMode and numStudents > 0 then
          %>
          Contracts: <a href="#" onclick="openCalendarDetails('<%= thisPhotoDate %>'); return false;"><%= contractCount %></a><br>
          Students: <%= numStudents %><br>
          <%
            end if
            if calNotes <> "" then
          %>          
          <%= calNotes %> (<a href="PhotographyCalendar.asp?fld_this_date=<%= request("fld_this_date") %>&delete_date=<%= calendarId %>">Delete</a>)
          <%
            end if
          %>
        </li>
        <%
          next
        %>
        <!-- <li><span class="active">10</span></li>
        <li>11</li>
        ...etc -->
      </ul>
    </div>
  </div>
  </form>
  <form name="addForm" action="PhotographyCalendarHandler.asp">
  <input type="hidden" name="type" value="ADD DATE">
  <input type="hidden" name="this_date" value="<%= request("fld_this_date") %>">
  <%
    if adminMode then 
  %>
  <div class="row">
    <div class="col-md-12">
      <h2>
        Add Custom Date        
      </h2>
      <%
        colClasses = "col-md-2 col-xs-12"
        set fieldColl = CreateObject("Scripting.Dictionary")
        set fieldColl("HOLIDAY") = getSelectionOptionColl("Holiday", "HOLIDAY", "")
        set fieldColl("RESERVED") = getSelectionOptionColl("Reservered", "RESERVED", "")
        set fieldColl("VACATION") = getSelectionOptionColl("Vacation", "VACATION", "")
        set fieldColl("OTHER") = getSelectionOptionColl("Other Type", "OTHER", "")
        
        
        renderEntFormSelect "select", "calendar_type", "Type", "Type", "", fieldColl, colClasses, "required", helpInfo

        colClasses = "col-md-4 col-xs-12"
        renderEntFormInput "text", "calendar_notes", "Notes", "Notes (e.g., Holiday, vacation, etc.)", "", colClasses, "required", ""


        colClasses = "col-md-2 col-xs-12"
        set fieldColl = CreateObject("Scripting.Dictionary")
        set fieldColl("BOOKED") = getSelectionOptionColl("Booked", "BOOKED", "")
        set fieldColl("CONFIRM") = getSelectionOptionColl("Confirm Date", "CONFIRM", "")
        set fieldColl("AVAILABLE") = getSelectionOptionColl("Available Date", "AVAILABLE", "")
        renderEntFormSelect "select", "calendar_status", "Status", "Status", "", fieldColl, colClasses, "required", helpInfo
        
        renderEntFormInput "date", "calendar_date", "Date", "12/1/" & Year(Now()), "", colClasses, "required", ""
      %>
      <div class="col-md-2 col-xs-12">
        <br>
        <input type="submit" class="btn btn-primary btn-block" value="Add">
      </div>
      
    </div>
  </div>
  </form>
  <%
    end if
  %>      
<div id="calendarDetailWindow"  class="modal fade" role="dialog">
  <div class="modal-dialog modal-mc modal-dialog-style">
    <div class="modal-content">
      <div class="modal-header">        
        Date Details
      </div>
      <div class="modal-body">
        <div class="row" id="dateDetails">
        </div>

      </div>
      <div id="actionButtonsDiv" class="modal-footer">
        <input type="button" class="btn" data-dismiss="modal" value="Close">        
      </div>
    </div>
  </div>
</div>
  
<!-- #include File="./_footer.asp" -->
