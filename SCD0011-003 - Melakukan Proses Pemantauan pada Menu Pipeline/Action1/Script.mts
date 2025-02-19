﻿Dim dt_TCID, dt_TestScenarioDesc, dt_ScenarioDesc, dt_ExpectedResult @@ script infofile_;_ZIP::ssf7.xml_;_
Dim dtNavbarMenu, dt_UserLogin, iteration

REM -------------- Call Function
Call spLoadLibrary()
Call spInitiateData("DigisalesLib_Report.xlsx", "SCD0011-003 - Melakukan Proses Pemantauan pada Menu Pipeline.xlsx", "SCD0011")
Call spGetDatatable()
Call fnRunningIterator()
Call spReportInitiate()
Call spAddScenario(dt_TCID, dt_TestScenarioDesc, dt_ScenarioDesc, dt_ExpectedResult, Array("Login Sebagai : " & dt_UserLogin))

iteration = Environment.Value("ActionIteration")

If iteration = 1 Then
	REM ------- Digisales Mobile
	Call DA_LoginMobile()
	Call FR_GoTo_NavbarMenu(dtNavbarMenu)
	Call GoToSubNavbar_Store()
	Call TambahLeadsProspek()
	Call RefreshPage()
	Call FilterDataStore()
	Call AddProspekToChart()
	Call RefreshPage()
	Call FilterDataPipeline()
	Call HasilCallTertarik()
	Call RefreshPage()
	Call FilterDataPipeline()
	Call CheckBNIMFDropdown()
	Call MasukLanjutFollowUp()
	Call LanjutFollowUp()
	Call RefreshPage()
	Call FilterDataStore()
	Call PembandingMonitoringDanClosing()
	call CheckDataTidakClosing()
	Call DA_LogoutMobile("0")
ElseIf iteration = 2 Then
	REM -------- Filezilla
'	Call Login_Filezilla()
'	Call DownloadFile()
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
	
	LoadFunctionLibrary (LibPathDigisales & "DigisalesLib_Menu.qfl")
	LoadFunctionLibrary (LibPathDigisales & "MDigisales_Store.qfl")
	LoadFunctionLibrary (LibPathDigisales & "MDigisales_Pipeline.qfl")
	LoadFunctionLibrary (LibPathDigisales & "Digisales_Filezilla.qfl")
	
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Login.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Store.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Pipeline.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_MDigisales_Profile.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Navbar.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Login.tsr")
	Call RepositoriesCollection.Add(LibRepo & "RP_Filezilla.tsr")
End Sub

Sub spGetDatatable()
	REM --------- Data
	dt_UserLogin				= DataTable.Value("USER",dtLocalSheet)
	
	REM --------- Reporting
	dt_TCID						= DataTable.Value("TC_ID", dtLocalSheet)
	dt_TestScenarioDesc			= DataTable.Value("TEST_SCENARIO_DESC", dtLocalSheet)
	dt_ScenarioDesc				= DataTable.Value("SCENARIO_DESC", dtLocalSheet)
	dt_ExpectedResult			= DataTable.Value("EXPECTED_RESULT", dtLocalSheet)
	
	REM ---------- Navbar Menu
	dtNavbarMenu				= DataTable.Value("NAVBAR_MENU" ,dtLocalSheet)

End Sub
