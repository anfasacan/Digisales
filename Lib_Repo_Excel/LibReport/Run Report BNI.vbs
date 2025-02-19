REM =================================
REM Declare BNI Project Type constant
REM =================================
Const M_CR = "CR" 'change request
Const M_IR = "IR" 
Const M_MR = "MR"

REM =================================
REM Declare another constant
REM =================================
Const M_NewLineCr = "\r"
Const M_NewLineLf = "\n"
Const M_NewLineCrLf = "\r\n"

REM =================================
REM Create a enumerable blueprint
REM =================================
Class StepStatusEntity
    Public  Passed, Warning, Failed, Done
    Private Sub Class_Initialize
        Passed = 0
        Warning = 1
        Failed = 2
		Done = 3
    End Sub
End Class

Class StepFormatEntity
    Public  FormatText, FormatJson, FormatXml
    Private Sub Class_Initialize
        FormatText = 0
        FormatJson = 1
        FormatXml = 2
    End Sub
End Class

Class CompatibilityEntity
    Public  Desktop, Mobile
    Private Sub Class_Initialize
        Desktop = 0
        Mobile = 1
    End Sub
End Class

REM =================================
REM Declare variables
REM =================================
Dim ReportStatus
Dim StepFormat
Dim CompatibilityMode

Dim PDI_ShortDescriptionHeader
Dim PDI_ShortDescriptionBody
Dim PDI_DocumentAuthor
Dim PDI_TesterName
Dim PDI_ProjectName
Dim PDI_ProjectCode
Dim PDI_ProjectType
Dim PDI_CoverTitle
Dim PDI_CoverSubTitle



REM =================================
REM Initiate all variables
REM =================================
Dim react
Public initiated
Public attributesHaveBeenSet

initiated = False
attributesHaveBeenSet = False

Set react = Nothing
Set ReportStatus = New StepStatusEntity
Set StepFormat = New StepFormatEntity
Set CompatibilityMode = New CompatibilityEntity

PDI_ShortDescriptionHeader = "Perubahan Metode Pembayaran Firstmedia dari Open Payment ke Closed Payment"
PDI_ShortDescriptionBody = "Pembayaran Firstmedia Closed Payment (MBRC)"
PDI_CoverTitle = "Pembayaran Firstmedia aaaaa Closed Payment aaaaaaaaaaaaaaaaaaa aaaaaa Closed Payment Closed Payment "
PDI_CoverSubTitle = "MBRC + SOA"
PDI_DocumentAuthor = "Harfiyan Shia"
PDI_TesterName = "Marchy Tio P / Agustin K Dewi"
PDI_ProjectType = M_CR
PDI_ProjectName = "Demo Automation Report"
PDI_ProjectCode = "19595 + 19722"

'Wscript.Echo fnGetCompleteDateTime()

'REM =================================
'REM Aplic Report Function Call
'REM =================================
'Call spInitiateReport("Prepared By " & PDI_DocumentAuthor, PDI_TesterName, PDI_ShortDescriptionHeader, PDI_ShortDescriptionBody)
'Call spInitiateReportProject(M_CR, PDI_ProjectName , PDI_ProjectCode)
'Call spInitiateReportCover(PDI_CoverTitle, PDI_CoverSubTitle)
'Call spInitiateReportAttributes()
'Call spInitiateReportSigner()
'' Call spInitiateReportBusinessRequirements()
'' Call spInitiateReportSystemImpacted()
'' Call spInitiateReportSystemChanges()
'
'Call spAddScenario("Scenario", "Scenario Exit", Array("t1","t2","t3"))
'  Call spAddImage("Gambar 1", "Scenario Exit", "C:\Users\admin\Downloads\BNI Logo.jpeg", CompatibilityMode.Desktop, ReportStatus.Done)
'' Call spAddImage("Gambar 1", "Scenario Exit", "C:\Users\harfiyanshia\Downloads\Kwitansi.jpeg", CompatibilityMode.Mobile, ReportStatus.Done)
'' Call spAddImages("Gambar Gambar", "C:\Users\harfiyanshia\Downloads\andromeda-galaxy-tilt-shift-wallpaper-for-3840x2160-4k-136-834.jpg|Sample Multiple Gambar", CompatibilityMode.Desktop, ReportStatus.Done)
' Call spAddStep("Step X", "Step Description", ReportStatus.Done)
' Call spAddFormattedStep("Step X", "Step Description", M_NewLineLf, StepFormat.FormatText, ReportStatus.Done)
'
'' Call spAddScenario("Scenario2", "Scenario Exit", Array("t1","t2","t3"))
'' Call spAddImage("Gambar 1", "Scenario Exit", "C:\Users\harfiyanshia\Downloads\andromeda-galaxy-tilt-shift-wallpaper-for-3840x2160-4k-136-834.jpg", CompatibilityMode.Desktop, ReportStatus.Done)
'' Call spAddImage("Gambar 1", "Scenario Exit", "C:\Users\harfiyanshia\Downloads\Kwitansi.jpeg", CompatibilityMode.Mobile, ReportStatus.Done)
'' Call spAddImages("Gambar Gambar", "C:\Users\harfiyanshia\Downloads\andromeda-galaxy-tilt-shift-wallpaper-for-3840x2160-4k-136-834.jpg|Sample Multiple Gambar", CompatibilityMode.Desktop, ReportStatus.Done)
'Call spAddStep("Step X", "Step Description", ReportStatus.Done)
'Call spAddFormattedStep("Step X", "Step Description", M_NewLineLf, StepFormat.FormatText, ReportStatus.Done)
'Call spSave("Result")

'Wscript.Echo fnGetCompleteDateTime()


REM =========================================
REM Declare to create new and set path folders
REM =========================================

Function LPad (str,pad,length)
	LPad = String(length-Len(str),pad) & str
End Function

Function fnCreateFolder(byval folderProject)
	Dim LibPathDigisales, LibRepo, objSysInfo
	Dim tempDigisalesPath, tempDigisalesPath2, PathDigisales
	
	Set objSysInfo 		= Createobject("Wscript.Network")	
	
	tempDigisalesPath 	= Environment.Value("TestDir")
	tempDigisalesPath2 	= InStrRev(tempDigisalesPath, "\")
	PathDigisales 		= Left(tempDigisalesPath, tempDigisalesPath2)

	Dim folderMyDoc
	Dim folderPath
	Dim folderActionPath

	Set objSysInfo = Createobject("Wscript.Network")	
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	
	folderMyDoc = PathDigisales
	folderPath = folderMyDoc & "\" & folderProject
	
	RunReportDate = Year(Now) & LPad(Month(Date), "0", 2) & LPad(Day(Date), "0", 2)
	folderActionPath = folderPath & "\" & RunReportDate
	
	
	If Not objFSO.FolderExists(folderPath) Then
		Call objFSO.CreateFolder(folderPath)
	End If
	
	If Not objFSO.FolderExists(folderActionPath) Then
		Call objFSO.CreateFolder(folderActionPath)
	End If
	
	fnCreateFolder = folderActionPath
End Function

REM =========================================
REM Declare Aplic Report initiation functions
REM =========================================

REM *****************************************
REM Initiate Report Object
REM *****************************************
Sub spInitiateReport(ByVal author, ByVal tester, Byval shortDescHeader, ByVal shortDescBody, byval folderName)
	If Not initiated Then
		Set react = CreateObject("Aplic.Report")
		Call react.About()
		Call react.SetUseDocumentInfo(true)
		Call react.SetOutputDirectory(fnCreateFolder(folderName))
		Call react.SetImageSizePercentage(75)
		Call react.SetMoveWordDocumentAfterSave(true)
		Call react.SetScenarioPrefix("")
		Call react.SetDisplayDocumentDate(true)
		Call react.SetDisplayTestingDate(true)
		Call react.SetAutoHideWarningStatusIfEmptyInSummary(true)
		Call react.SetUseScenarioNumbering(false)
		Call react.SetDisplayCustomAttributes(true)
		Call react.SetDocumentAuthor(author)
		Call react.SetDocumentDate(fnGetDate())
		Call react.SetDocumentShortDescriptionHeader(shortDescHeader)
		Call react.SetDocumentShortDescriptionBody(shortDescBody)
		Call react.SetTester(tester)
		initiated = True
	End If
End Sub


REM *******************************************
REM Initiate Report Project Type, Name and Code
REM *******************************************
Sub spInitiateReportProject(ByVal projectType, ByVal projectName, ByVal projectCode)
	If initiated Then
'		Set react = CreateObject("Aplic.Report")
		Call react.AddProjectType(M_CR)
		Call react.AddProjectType(M_IR)
		Call react.AddProjectType(M_MR)
		Call react.SetProjectType(projectType)
		Call react.SetProjectName(projectName)
		Call react.SetProjectCode(projectCode)
	End If
End Sub

REM *************************************************
REM Initiate Report Cover
REM - To set cover image, refer to 
REM - "C:\ProgramData\Napalm\React\Napalm.Design.ini"
REM - Section [Cover], DocumentLogoPath
REM *************************************************
Sub spInitiateReportCover(ByVal coverTitle, ByVal coverSubTitle)
	Call react.SetCoverTitle(coverTitle)
	Call react.SetCoverSubTitle(coverSubTitle)
End Sub

REM *********************************************************
REM Initiate Report Signer
REM - Move this method/procedure to project specific library, 
REM - Since it will apply different for each project
REM - Such as DigisalesGlobalLib.vbs (example lib name)
REM 
REM Note: This information will be collected from customer
REM *********************************************************
Sub spInitiateReportSigner(byval Tester1, byval Tester2, byval TestManager, byval TestingGroupHead, byval DevelopmentManager, byval RequirementManager, byval ProjectManager)
	Call react.SetSigner(Tester1, "Tester/Developer")
	Call react.SetSigner(Tester2, "Tester/Developer")
	Call react.SetSigner(TestManager, "Test Manager")
	Call react.SetSigner(TestingGroupHead, "Testing Group Head")
	Call react.SetSigner(DevelopmentManager, "Development Manager")
	Call react.SetSigner(RequirementManager, "Requirement Manager/Business Analyst")
	Call react.SetSigner(ProjectManager, "Project Manager")
End Sub

REM *********************************************************
REM Initiate Report Attributes
REM - Move this method/procedure to project specific library, 
REM - Since it will apply different for each project
REM - Such as DigisalesGlobalLib.vbs (example lib name)
REM *********************************************************
Sub spInitiateReportAttributes()
	Dim attBrowser, attBrowserVersion, attURL, attUFTVersion
	
	attUFTVersion		= DataTable.Value("UFT_VERSION", dtGlobalSheet)
	attBrowser			= DataTable.Value("BROWSER", dtGlobalSheet)
	attBrowserVersion 	= DataTable.Value("BROWSER_VERSION", dtGlobalSheet)
	attURL				= DataTable.Value("URL", dtGlobalSheet)
	
	Call react.SetCustomAttributes("UFT Version", attUFTVersion)
	Call react.SetCustomAttributes("Browser", attBrowser)
	Call react.SetCustomAttributes("Browser Version", attBrowserVersion)
	Call react.SetCustomAttributes("Global Library", "BNI_GlobalFunction.qfl")
	Call react.SetCustomAttributes("Report Library", "Run Report BNI.vbs")
	Call react.SetCustomAttributes("Digisales Library", "DigisalesLib_Menu.qfl")
	Call react.SetCustomAttributes("Distribution Library", "Digisales_FileDistribution.qfl")
End Sub

REM *********************************************************
REM Initiate Report Business Requirements
REM - Move this method/procedure to project specific library, 
REM - Since it will apply different for each project
REM - Such as DigisalesGlobalLib.vbs (example lib name)
REM 
REM Note: This information will be collected from customer
REM *********************************************************
Sub spInitiateReportBusinessRequirements()
	Call react.AddBusinessRequirement("E-Channel BNI: MBRC dan SMS Sintaks")
	Call react.AddBusinessRequirement("E-Channel BNI: MBRC dan SMS Sintaks XX")
	Call react.AddBusinessRequirement("E-Channel BNI: MBRC dan SMS Sintaks XXX")
End Sub

REM *********************************************************
REM Initiate Report Impacted Systems
REM - Move this method/procedure to project specific library, 
REM - Since it will apply different for each project
REM - Such as DigisalesGlobalLib.vbs (example lib name)
REM 
REM Note: This information will be collected from customer
REM *********************************************************
Sub spInitiateReportSystemImpacted()
	Call react.AddSystemImpacted("Mobile Banking APK")
	Call react.AddSystemImpacted("Mobile Banking Service")
	Call react.AddSystemImpacted("SOA")
End Sub

REM *********************************************************
REM Initiate Report System Changes
REM - Move this method/procedure to project specific library, 
REM - Since it will apply different for each project
REM - Such as DigisalesGlobalLib.vbs (example lib name)
REM 
REM Note: This information will be collected from customer
REM *********************************************************
Sub spInitiateReportSystemChanges()
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/", "* BNIMBankService.csproj")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/Data", "*TransactionAuditData.cs")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/Documentation", _
		"*Inquiry_PembayaranTVBerlangganan.txt, *Payment_PembayaranTVBerlangganan.txt")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/Web References/ BNI_PaymentService", _
		"*IFPostPaidPayment.wsdl,+InquiryFirstMediaReq.xsd, +InquiryFirstMediaRes.xsd, *PayFirstMediaReq.xsd, " & _
		"*PayFirstMediaRes.xsd, *Reference.cs, *Reference.map")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/Web References/ BNI_PaymentService2", _
		"*IFPostPaidPayment.wsdl, *Reference.cs, *Reference.map")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/lib/wsdl/Payment", _
		"*BNI_PaymentService.wsdl, *BNI_PaymentService2.wsdl, *InquiryFirstMediaReq.xsd, *InquiryFirstMediaRes.xsd, *PayFirstMediaReq.xsd, *PayFirstMediaRes.xsd")
	Call react.AddSystemChanges("WEB SERVICE", "Project Files", "Src_IIS/BNIMBankService/services", "*PembayaranTVBerlanggananService.cs")
	Call react.AddSystemChanges("MOBILE APP", "Android Apps Files", "Src_MobileApp/BNIMobileNew Android Studio/assets/www/", _
		"*menupembayaranTvberlangganan.html, *menupembayaranTvberlanggananFirstmediaPayment.html, *menupembayaranTvberlanggananPaymentFirstMediaSukses.html")
	Call react.AddSystemChanges("MOBILE APP", "Android Apps Files", "Src_MobileApp/BNIMobileNew Android Studio /assets/www/assets/js", _
		"*TV.js")
End Sub

REM =================================
REM Declare Aplic Report functions
REM =================================
Sub spAddScenario(ByVal no, ByVal useCaseDesc, ByVal scenarioDesc, ByVal exitCriteria, ByVal preparations)
	If IsArray(preparations) Then
		Dim sPreparations
		Dim index
		
		For index = 0 to UBound(preparations)
			sPreparations = sPreparations & react.MultipleDelimiter & preparations(index)
		Next
		
		sPreparations = Mid(sPreparations, 2)
		Call react.AddTitle(no, useCaseDesc, scenarioDesc, exitCriteria, sPreparations)
	Else
		If VarType(preparations) = vbString Then
			Call react.AddTitle(no, useCaseDesc, scenarioDesc, exitCriteria, preparations)
		End If
	End If
End Sub

REM *********************************
REM Create Scenario
REM *********************************
'Sub spAddScenario(ByVal scenarioName, ByVal exitCriteria, ByVal preparations)
'	If IsArray(preparations) Then
'		Dim sPreparations
'		Dim index
'		
'		For index = 0 to UBound(preparations)
'			sPreparations = sPreparations & react.MultipleDelimiter & preparations(index)
'		Next
'		
'		sPreparations = Mid(sPreparations, 2)
'		Call react.AddTitle(scenarioName, exitCriteria, sPreparations)
'	Else
'		If VarType(preparations) = vbString Then
'			Call react.AddTitle(scenarioName, exitCriteria, preparations)
'		End If
'	End If
'End Sub

REM *********************************
REM Add Image Step to Scenario
REM *********************************
Sub spAddImage(ByVal stepName, ByVal imageDescription, ByVal imagePath, ByVal compatibilityMode, ByVal stepStatus)
	Call react.AddImage(stepName, imageDescription, imagePath, compatibilityMode, stepStatus)
End Sub

REM *********************************
REM Add Multiple Image Step to Scenario
REM imageList can be an array, use Array("image1Path", "image1Desc", "image2Path", "image2Desc")
REM imageList can be a string, use "image1Path|image1Desc|image2Path|image2Desc"
REM *********************************
Sub spAddImages(ByVal stepName, ByVal imageList, ByVal compatibilityMode, ByVal stepStatus)
	If IsArray(imageList) Then
		Dim sImageList
		Dim index
		
		For index = 0 to UBound(imageList) - 1
			sImageList = sImageList & react.MultipleDelimiter & imageList(index)
		Next
		
		sImageList = Mid(sImageList, 2)
		Call react.AddImages(stepName, sImageList, compatibilityMode, stepStatus)
	Else
		If VarType(imageList) = vbString Then
			Call react.AddImages(stepName, imageList, compatibilityMode, stepStatus)
		End If
	End If
End Sub

REM **********************************
REM Add Step to scenario without image
REM **********************************
Sub spAddStep(ByVal stepName, ByVal stepDescription, ByVal stepStatus)
	Call react.AddStep(stepName, stepDescription, stepStatus)
End Sub

REM **********************************
REM Add Formatted Step to scenario
REM Only support Text, JSON and XML
REM **********************************
Sub spAddFormattedStep(ByVal stepName, ByVal stepDescription, ByVal delimiter, ByVal stepFormat, ByVal stepStatus)
	Call react.AddFormattedStep(stepName, stepDescription, delimiter, stepFormat, stepStatus)
End Sub

REM ********************************************
REM Save Report and Generate
REM - Based on UFT Last Test Iteration
REM ********************************************
Sub spReportSave()
	If CInt(Environment("ActionIteration")) = CInt(DataTable.LocalSheet.GetRowCount()) Then
		If initiated Then
			react.Save Environment("ActionName"), true
			initiated = false
		End If
	End If
End Sub

REM ********************************************
REM Save Report and Generate
REM ********************************************
Sub spReportForceSave()
	If initiated Then
		react.Save Environment("ActionName"), true
		initated = false
	End If
End Sub
