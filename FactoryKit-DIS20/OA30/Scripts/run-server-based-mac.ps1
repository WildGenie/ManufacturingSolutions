﻿param([System.String]$RootDir, [System.String]$Architecture = "amd64", [System.String]$NIC, [System.String]$IsShowingBarcode = "false");

#if($RootDir -eq $null)
if([System.String]::IsNullOrEmpty($RootDir) -eq $true)
{
   $RootDir = Split-Path -parent $MyInvocation.MyCommand.Definition;

   if($RootDir.EndsWith("\") -eq $true)
   {
      $RootDir = $RootDir.Substring(0, ($RootDir.Length -1));
   }

   if($RootDir.ToLower().EndsWith("\scripts") -eq $true)
   {
      $RootDir = $RootDir.Substring(0, ($RootDir.ToLower().LastIndexOf("\scripts")));
   }
}

if($RootDir.EndsWith("\") -eq $true)
{
  $RootDir = $RootDir.Substring(0, ($RootDir.Length -1));
}

[xml]$OemHardwareReportData = [xml]'<OEMOptionalInfo>
										  <Field>
											<Name>ZPC_MODEL_SKU</Name>
											<Value>ABCDEFGHIJKLM1122233344Z</Value>
										  </Field>
										  <Field>
											<Name>ZMANUF_GEO_LOC</Name>
											<Value>1</Value>
										  </Field>
										  <Field>
											<Name>ZPGM_ELIG_VAL</Name>
											<Value>12345678Z,ABC,DEFGH,1212,1212</Value>
										  </Field>
										  <Field>
											<Name>ZOEM_EXT_ID</Name>
											<Value>30000123</Value>
										  </Field>
										  <Field>
											<Name>ZCHANNEL_REL_ID</Name>
											<Value>China</Value>
										  </Field>
										  <Field>
											<Name>ZFRM_FACTOR_ CL1</Name>
											<Value>Tablet</Value>
										  </Field>
										  <Field>
											<Name>ZFRM_FACTOR_ CL2</Name>
											<Value>Standard</Value>
										  </Field>
										  <Field>
											<Name>ZSCREEN_SIZE</Name>
											<Value>10.1</Value>
										  </Field>
										  <Field>
											<Name>ZTOUCH_SCREEN</Name>
											<Value>Touch</Value>
										  </Field>
									   </OEMOptionalInfo>';


$OA3ToolPath = $RootDir + "\OA3Tool9600\amd64\oa3tool.exe";

$OA3ToolConfigurationFilePath = $RootDir + "\OA3Tool9600\amd64\OA3Tool-ServerBased.cfg";

if($Architecture.ToLower() -eq "x86")
{
   $OA3ToolPath = $RootDir + "\OA3Tool9600\x86\oa3tool.exe";

   $OA3ToolConfigurationFilePath = $RootDir + "\OA3Tool9600\x86\OA3Tool-ServerBased.cfg";
}

$DPKFilePath = $RootDir + "\DPKOutputs\";

$LogPath = $RootDir + "\Logs";

$TransactionID = [System.Guid]::NewGuid().ToString();

$OA3OutputBinFilePath = $RootDir + "\DPKInputs\" + $TransactionID + ".bin";
$OA3OutputXmlFilePath = $RootDir + "\DPKInputs\" + $TransactionID + ".xml";

[System.String]$SerialNumber = "";

[System.String]$Message = "";

#Retrieves MAC Info:
try
{
  $Message = [System.String]::Format("Retrieving MAC Info..., {0}", [System.DateTime]::Now);
  $Message;
  $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
   
  $NICName = $NIC; 

  $MacObject = Get-WmiObject Win32_NetworkAdapter | Where-Object { $_.MacAddress -and $_.Name -eq $NICName} | Select-Object Name, MacAddress; 

  "MAC Info: " | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
  $MacObject | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

  $SerialNumber = $MacObject.MacAddress;
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Error(s) occurred retrieving MAC info!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}

if([System.String]::IsNullOrEmpty($SerialNumber))
{
   $Host.UI.RawUI.BackgroundColor = "Red";
   $Host.UI.RawUI.ForegroundColor = "Yellow";
   Write-Host -Object "Failed to bind a value to serial number! ";
   Read-Host -Prompt "Press any key to exit...";
   exit;
}

"Transaction ID: " | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
$TransactionID | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

"Serial Number: " | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
$SerialNumber | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

#Invokes OA3Tool.exe /Validate to test if there is already a DPK injected
try
{
    $Message = [System.String]::Format("Validating ACPI MSDM table..., {0}", [System.DateTime]::Now);
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
       
    $Message = & ($OA3ToolPath) @("/Validate");
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    if($Message.Contains("The operation completed successfully.") -eq $true)
    {
       $Host.UI.RawUI.BackgroundColor = "Red";
       $Host.UI.RawUI.ForegroundColor = "Yellow";
       Write-Host -Object "The board has already got a DPK injected, and the ACPI MSDM table is NOT empty!";
       Read-Host -Prompt "Press any key to exit...";
       exit;
    }
    else
    {
       Write-Host -Object "OK.";
    }
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Error(s) occurred during ACPI MSDM table validation!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}

#Sets the output file paths for .bin file and .xml file in OA3Tool configuration file;
#And appends OHR data, serial number, CloudConfigurationID to OA3Tool configuration file(if there is not any for each):
try
{
    [xml]$OA3ToolConfigurationXml = Get-Content -Path $OA3ToolConfigurationFilePath -Encoding UTF8;

    if($OA3ToolConfigurationXml.OA3.ServerBased.Parameters.CloudConfigurationID -eq $null)
    {
       $Host.UI.RawUI.BackgroundColor = "Red";
       $Host.UI.RawUI.ForegroundColor = "Yellow";
       Write-Host -Object "The OA3Tool configuration file does NOT have a CloudConfigurationID, please set the CloudConfigurationID!";
       Read-Host -Prompt "Press any key to exit...";
       exit;
    }

    try
    {
       Write-Host -Object "Testing connection to KPS...";
       (New-Object Net.Sockets.TcpClient).Connect($OA3ToolConfigurationXml.OA3.ServerBased.KeyProviderServerLocation.IPAddress, $OA3ToolConfigurationXml.OA3.ServerBased.KeyProviderServerLocation.EndPoint);
    }
    catch [System.Exception]
    {
      $Message = $Error[0].Exception;
      $Message;
      $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

      $Host.UI.RawUI.BackgroundColor = "Red";
      $Host.UI.RawUI.ForegroundColor = "Yellow";
      Write-Host -Object "Connection test to KPS failed! Please check your KPS status and the OA3Tool Configuration File.";
      Read-Host -Prompt "Press any key to exit...";
      exit;
    }

    $OA3ToolConfigurationXml.OA3.OutputData.AssembledBinaryFile = $OA3OutputBinFilePath;

    $OA3ToolConfigurationXml.OA3.OutputData.ReportedXMLFile = $OA3OutputXmlFilePath;
    
    if($OA3ToolConfigurationXml.OA3.ServerBased.Parameters.OEMOptionalInfo -eq $null)
    {
        $OHRNodes = $OA3ToolConfigurationXml.ImportNode($OemHardwareReportData.OEMOptionalInfo, $true);
  
        #$OA3ToolConfigurationXml.OA3.ServerBased.Parameters.InsertBefore($OHRNodes, $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.CloudConfigurationID);
        $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.InsertBefore($OHRNodes, $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SelectSingleNode("CloudConfigurationID"));
    }

    #Adding serial number to OA3Tool configuration file:
    if($OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SerialNumber -ne $null)
    {
       $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SerialNumber = $SerialNumber;
    }
    else
    {
       [xml]$SerialNumberXml = [System.String]::Format("<SerialNumber>{0}</SerialNumber>", $SerialNumber);

       $SerialNumberNode = $OA3ToolConfigurationXml.ImportNode($SerialNumberXml.FirstChild, $true);

       #$OA3ToolConfigurationXml.OA3.ServerBased.Parameters.InsertAfter($SerialNumberNode, $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.CloudConfigurationID);
       #$OA3ToolConfigurationXml.OA3.ServerBased.Parameters.InsertAfter($SerialNumberNode, $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SelectSingleNode("CloudConfigurationID"));
       $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.InsertBefore($SerialNumberNode, $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SelectSingleNode("CloudConfigurationID"));

       $OA3ToolConfigurationXml.OA3.ServerBased.Parameters.SerialNumber;
    }

    $OA3ToolConfigurationFilePath = $RootDir + "\DPKInputs\" + $TransactionID + ".cfg";

    $OA3ToolConfigurationXml.Save($OA3ToolConfigurationFilePath);
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Errors occurred!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}


#Invokes OA3Tool.exe /Assemble to generate .bin file and output DPK info xml file
try
{
    $Message = [System.String]::Format("Assembling DPK..., {0}", [System.DateTime]::Now);
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
       
    #& ($RootDir + "\OA3Tool9600\amd64\oa3tool.exe") @("/Assemble",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath)) | Out-File -FilePath ($RootDir + "\production-log.log") -Append;

    #Start-Process -FilePath $OA3ToolPath -ArgumentList @("/Assemble",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath)) -Wait -NoNewWindow -RedirectStandardOutput ($LogPath + "\oa3tool-assemble-" + $TransactionID + ".log");
    Start-Process -FilePath $OA3ToolPath -ArgumentList @("/Assemble",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath)) -Wait -NoNewWindow -RedirectStandardOutput ($LogPath + "\" + $TransactionID + "-oa3tool-assemble.log");
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Errors occurred!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}


[xml]$ProductKeyInfo = [xml](Get-Content -Path $OA3OutputXmlFilePath); 

$ProductKeyID = $ProductKeyInfo.Key.ProductKeyID;

#Copies the output DPK xml file to the directory that archives all of the DPK xml files, and renames it to be in the form of "{product_key_id}.assemble.xml"
Copy-Item -Path $OA3OutputXmlFilePath -Destination ($DPKFilePath + $ProductKeyID + ".assemble.xml") -Force;

#Copies the output .bin file to the directory that archives all of the DPK .bin files, and renames it to be in the form of "{product_key_id}.bin"
Copy-Item -Path $OA3OutputBinFilePath -Destination ($DPKFilePath + $ProductKeyID + ".bin") -Force;

##Runs DPK Injection Tool Here
try
{
    $Message = [System.String]::Format("Injecting DPK..., {0}", [System.DateTime]::Now);
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Errors occurred!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}

#Invokes OA3Tool.exe /Validate to test if the DPK injection is successful
try
{
    $Message = [System.String]::Format("Validating ACPI MSDM table..., {0}", [System.DateTime]::Now);
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
       
    $Message = & ($OA3ToolPath) @("/Validate");
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    if($Message.Contains("The operation completed successfully.") -eq $false)
    {
       $Host.UI.RawUI.BackgroundColor = "Red";
       $Host.UI.RawUI.ForegroundColor = "Yellow";
       Write-Host -Object "Could NOT find a DPK injected, ACPI MSDM table is empty!";
       Read-Host -Prompt "Press any key to exit...";
       exit;
    }
    else
    {
       Write-Host -Object "OK.";
    }
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Error(s) occurred during ACPI MSDM table validation!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}
    

#Invokes OA3Tool.exe /Report to generate output DPK info xml file
try
{
    $Message = [System.String]::Format("Reporting DPK..., {0}", [System.DateTime]::Now);
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    #& ($RootDir + "\OA3Tool9600\amd64\oa3tool.exe") @("/Report",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath), ("/LogTrace=" + $OA3OutputXmlFilePath + ".log.xml")) | Out-File -FilePath ($RootDir + "\production-log.log") -Append;

    #Start-Process -FilePath $OA3ToolPath -ArgumentList @("/Report",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath), ("/LogTrace=" + $OA3OutputXmlFilePath + ".log.xml")) -Wait -NoNewWindow -RedirectStandardOutput ($LogPath + "\oa3tool-report-" + $TransactionID + ".log");
    Start-Process -FilePath $OA3ToolPath -ArgumentList @("/Report",  ("/ConfigFile=" + $OA3ToolConfigurationFilePath), ("/LogTrace=" + $OA3OutputXmlFilePath + ".log.xml")) -Wait -NoNewWindow -RedirectStandardOutput ($LogPath + "\" + $TransactionID + "-oa3tool-report.log");
}
catch [System.Exception]
{
    $Message = $Error[0].Exception;
    $Message;
    $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

    $Host.UI.RawUI.BackgroundColor = "Red";
    $Host.UI.RawUI.ForegroundColor = "Yellow";
    Write-Host -Object "Errors occurred!";
    Read-Host -Prompt "Press any key to exit...";
    exit;
}

[xml]$ProductKeyInfo = [xml](Get-Content -Path $OA3OutputXmlFilePath); 

$ProductKeyID = $ProductKeyInfo.Key.ProductKeyID;

#Copies the output DPK xml file to the directory that archives all of the DPK xml files, and renames it to be in the form of "{product_key_id}.report.xml"
Copy-Item -Path $OA3OutputXmlFilePath -Destination ($DPKFilePath + $ProductKeyID + ".report.xml") -Force;

$Message = [System.String]::Format("Finish processing '{0}', {1}", $DPKFilePath, [System.DateTime]::Now);
$Message;
$Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;


##Creates DPKID-SN pair, and saves the pair to the xml file of DPKID-SN.xml in the root directory
#if($MatchCount -eq 2)
if(([System.String]::IsNullOrEmpty($SerialNumber) -eq $false) -and ($MatchCount -eq 2))
{
   try
   {
      Import-Module ($RootDir + "\PowerShellModules\PowerShellOA3DPKSNBinder.dll");

      [xml]$ProductKeyInfo = [xml](Get-Content -Path $OA3OutputXmlFilePath); 

      $ProductKeyID = $ProductKeyInfo.Key.ProductKeyID;

      if($ProductKeyID -ne $null)
      {
         $PairID = Add-DPKIDSNBinding -ProductKeyID $ProductKeyID -SerialNumber $SerialNumber -TransactionID $TransactionID -PersistencyMode FileSystemXML -FilePath ($RootDir + "\DPKID-SN.xml");

         $Message = [System.String]::Format("Pair created, Product Key ID: {0}, Serial Number: {1}, Pair ID: {2}, {3}", $ProductKeyID, $SerialNumber, $PairID, [System.DateTime]::Now);
         $Message;
         $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

         $IsShowingDPKIDQRCode = (($IsShowingBarcode.ToLower() -eq "true") -or ($IsShowingBarcode -eq "1"));

         if($IsShowingDPKIDQRCode -eq $true)
         {
            Show-SNBarcode -BarcodeValue $ProductKeyID -BarcodeType QR_CODE -ImageWidth 300 -ImageHeight 300 -IsShowingBarcodeText $true;
         }

         #$Message = [System.String]::Format("Shutting down..., {0}", [System.DateTime]::Now);
         $Host.UI.RawUI.BackgroundColor = "Green";
         $Host.UI.RawUI.ForegroundColor = "Black";
         $Message = "OA3.0 process completed successfully!";
         $Message;
         $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;

         #& ("wpeutil") @("shutdown");

         [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");

         $DialogResult = [System.Windows.Forms.MessageBox]::Show("OA3.0 process completed successfully! Shutdown unit now?" , "Success" , 4);

         if($DialogResult -eq "YES")
         {
            Stop-Computer -ComputerName "localhost";
         }
      }
      else
      {
         $Host.UI.RawUI.BackgroundColor = "Red";
         $Host.UI.RawUI.ForegroundColor = "Yellow";
         $Message = [System.String]::Format("Could not find product key ID, {0}", [System.DateTime]::Now);
         $Message;
         $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
      }
   }
   catch [System.Exception]
   {
      $Message = $Error[0].Exception;
      $Message;
      $Message | Out-File -FilePath ($LogPath + "\production-log.log") -Append;
   }
} 