﻿Dim dt_TCID, dt_TestScenarioDesc, dt_ScenarioDesc, dt_ExpectedResult @@ script infofile_;_ZIP::ssf7.xml_;_
Dim dt_UserLogin, dt_Bulan, dt_Tahun, dtSidebarMenu

REM -------------- Call Function
Call spLoadLibrary()
Call spInitiateData("DigisalesLib_Report.xlsx", "SCD0016-036 - Searching profiling nasabah & memiliki sales kelolaan.xlsx", "SCD0016")
Call spGetDatatable()
Call fnRunningIterator()
Call spReportInitiate()
Call spAddScenario(dt_TCID, dt_TestScenarioDesc, dt_ScenarioDesc, dt_ExpectedResult, Array("Login Sebagai : " & dt_UserLogin, "Data CIF : " & DataTable.Value("TEXT1",dtlocalsheet)))
iteration = Environment.Value("ActionIteration")
REM ------- Digisales Mobile

If iteration = 1 Then
	Call DA_LoginMobile()
	Call SearchProfilingLeads()
	Call AddFamilyTree()
	Call SearchFamilyTreeFlagging()
	call ChangeStatusVerifikasiCustomerFamilyTreeFlagging()
	Call CheckDetailFamilyTreeFlagging()
	Call SendCustomerFamilyTreeFlaggingToPenyelia()
	Call DA_LogoutMobile("0")	
End If

If iteration = 2 Then
	Call DA_Login()
	Call FR_GoTo_SidebarMenu(dtSidebarMenu)
	Call ApprovalFamilyTree()
	Call DA_Logout("0")
End If

If iteration = 3 Then
	Call DA_LoginMobile()
	Call GoToSubNavbar()
	Call GoToSubSubNavbar()
	Call SearchFamilyTreeFlagging()
	Call CheckDetailFamilyTreeFlagging()
	Call DA_LogoutMobile("0")
End If

Call spReportSave()
	
Sub spLoadLibrary()
	Dim LibPathDigisales, LibReport, LibRepo, objSysInfo
	Dim tempDigisalesPath, tempDigisalesPath2, PathDigisales
	
	Set objSysInfo 		= Createobject("Wscript.Network")	
	
	tempDigisalesPath 	= Environment.Value("TestDir")
	tempDigisalesPath2 	= InStrRev(tempDigisalesPath, "\")
	PathDigisales 		= Left(tempDigisalesPath, tempDigisalesPath2)
	
	LibPathDigisales	= PathDigisales & "Lib_Repo_Excel\LibDigisales\"
	LibReport			= PathDigisales & "Lib_Repo_Excel\LibReport\"
	LibRepo				= PathDigisales & "Lib_Repo_Excel\Repo\"
	REM ------- Report Library
	LoadFunctionLibrary (LibReport & "BNI_GlobalFunction.qfl")
	LoadFunctionLibrary (LibReport & "Run Report BNI.vbs")
	
	rem ---- Digisales lib
	LoadFunctionLibrary (LibPathDigisales & "DigisalesLib_Menu.qfl")
	LoadFunctionLibrary (LibPathDigisales & "MDigisales_Home.qfl")
	LoadFunctionLibrary (LibPathDigisales & "Digisales_Customer_Flagging.qfl")
	
	Call RepositoriesCollection.Add(LibRepo & "RP_Home_Digisales_Web.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Customer_Flagging.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Home.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Login.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Profile.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Navbar.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Sidebar.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Login.tsr")

End Sub

Sub spGetDatatable()
	REM --------- Data
	dt_UserLogin				= DataTable.Value("USER",dtLocalSheet)
	dt_Bulan					= DataTable.Value("TEXT1",dtLocalSheet)
	dt_Tahun					= DataTable.Value("TEXT2",dtLocalSheet)

	REM --------- Reporting
	dt_TCID						= DataTable.Value("TC_ID", dtLocalSheet)
	dt_TestScenarioDesc			= DataTable.Value("TEST_SCENARIO_DESC", dtLocalSheet)
	dt_ScenarioDesc				= DataTable.Value("SCENARIO_DESC", dtLocalSheet)
	dt_ExpectedResult			= DataTable.Value("EXPECTED_RESULT", dtLocalSheet)

	REM --------- Menu
	dtSidebarMenu				= DataTable.Value("SIDEBAR_MENU" ,dtLocalSheet)
	dtNavbarMenu				= DataTable.Value("NAVBAR_MENU" ,dtLocalSheet)
End Sub
