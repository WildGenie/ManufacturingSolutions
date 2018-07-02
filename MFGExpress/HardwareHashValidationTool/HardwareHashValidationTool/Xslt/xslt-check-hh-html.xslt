﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:hhvxslx="HHValidation.XsltExt">
    <xsl:output method="html" indent="yes" standalone="yes"/>
    <xsl:param name="transactionId"></xsl:param>
    <xsl:param name="productKeyId"></xsl:param>
  <xsl:param name="mode">online</xsl:param>
  <xsl:template match="/">
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>
         Result-
         <xsl:value-of select="$transactionId"/>
            <xsl:value-of select="'-'"/>
            <xsl:value-of select="$productKeyId"/>
        </title>
        <!--<script type="text/javascript">
          function SetWindowSize()
          {
              window.resizeTo((screen.width - 6), (screen.height - 20));
          }
        </script>-->
      </head>
      <body>
        <p style="font-weight:bolder;font-size:x-large;font-family:Arial">Total Result: 
          <xsl:call-template name="TotalResult"/>
        </p>
        <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
        <a >
          <xsl:attribute name="href">
            <xsl:value-of select="$transactionId"/>
            <xsl:value-of select="'_'"/>
            <xsl:value-of select="$productKeyId"/>
            <xsl:value-of select="'_All.zip'"/>
          </xsl:attribute>
          Download Result
        </a>
        <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
        <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
        <a target="_blank">
           <xsl:attribute name="href">
             <xsl:value-of select="'../Log/'"/>
             <xsl:value-of select="$transactionId"/>
             <xsl:value-of select="'.log'"/>
           </xsl:attribute>
           View Log
        </a>
        <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
        <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
        <a target="_self" onclick="window.close();">
           <xsl:attribute name="href">
             <xsl:value-of select="'#'"/>
           </xsl:attribute>
           Close
        </a>
        <hr/>
        <br/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">ProductKeyID: </p>
          <xsl:apply-templates select="TestItems/ProductKeyID">
          </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">OSType: </p>
          <xsl:apply-templates select="TestItems/OSType">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">ChassisType: </p>
        <xsl:apply-templates select="TestItems/ChassisType">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosSystemManufacturer: </p>
        <xsl:apply-templates select="TestItems/SmbiosSystemManufacturer">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosSystemFamily: </p>
        <xsl:apply-templates select="TestItems/SmbiosSystemFamily">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosSystemProductName: </p>
        <xsl:apply-templates select="TestItems/SmbiosSystemProductName">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosBoardProduct: </p>
        <xsl:apply-templates select="TestItems/SmbiosBoardProduct">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosSkuNumber: </p>
        <xsl:apply-templates select="TestItems/SmbiosSkuNumber">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosSystemSerialNumber: </p>
        <xsl:apply-templates select="TestItems/SmbiosSystemSerialNumber">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">SmbiosUuid: </p>
        <xsl:apply-templates select="TestItems/SmbiosUuid">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">DigitizerSupportID: </p>
        <xsl:apply-templates select="TestItems/DigitizerSupportID">
        </xsl:apply-templates>
        <br/>
        <hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">ProcessorModel: </p>
          <xsl:apply-templates select="TestItems/ProcessorModel">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">TotalPhysicalRAM: </p>
          <xsl:apply-templates select="TestItems/TotalPhysicalRAM">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">PrimaryDiskType: </p>
          <xsl:apply-templates select="TestItems/PrimaryDiskType">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">PrimaryDiskTotalCapacity: </p>
          <xsl:apply-templates select="TestItems/PrimaryDiskTotalCapacity">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">DisplayResolutionHorizontal: </p>
          <xsl:apply-templates select="TestItems/DisplayResolutionHorizontal">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">DisplayResolutionVertical: </p>
          <xsl:apply-templates select="TestItems/DisplayResolutionVertical">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">DisplaySizePhysicalH: </p>
          <xsl:apply-templates select="TestItems/DisplaySizePhysicalH">
          </xsl:apply-templates>
        <br/><hr/>
        <p style="font-weight:bolder;text-decoration:underline;font-style:italic">DisplaySizePhysicalY: </p>
          <xsl:apply-templates select="TestItems/DisplaySizePhysicalY">
          </xsl:apply-templates>
        <br/><hr/>
      </body>
    </html>
    </xsl:template>

  <xsl:template name="TotalResult">
    <xsl:variable name="totalItemCount" select="count(//Result)"/>
    <xsl:variable name="passedItemCount" select="count(//Result[./text() = 'Passed'])"/>
    <Span>
      <xsl:if test="$totalItemCount = $passedItemCount">
        <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
        Passed
      </xsl:if>
      <xsl:if test="$totalItemCount &gt; $passedItemCount">
        <xsl:attribute name="style">background-color:red</xsl:attribute>
        Failed
      </xsl:if>
    </Span>
  </xsl:template>

  <xsl:template match="TestItems/ProductKeyID">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/OSType">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          OS Build Number:
          <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
          <xsl:value-of select="./Detail/OSBuild"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
    <xsl:template match="TestItems/ChassisType">
     <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Unexpected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Unexpected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosSystemManufacturer">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosSystemFamily">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosSystemProductName">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosBoardProduct">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosSkuNumber">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosSystemSerialNumber">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/SmbiosUuid">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/DigitizerSupportID">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Unexpected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Unexpected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/ProcessorModel">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="TestItems/TotalPhysicalRAM">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:if test="$mode = 'online' and ./Result = 'Failed' and $transactionId != '' and $productKeyId != ''">
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_Trace.xml'"/>
              </xsl:attribute>
              View OA3Tool Log Trace
            </a>
            <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_SMBIOS_Dump.txt'"/>
              </xsl:attribute>
              View SMBIOS Dump
            </a>
            <br/>
          </xsl:if>
          
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/PrimaryDiskType">
     <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Expected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Expected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Unexpected Value: </td>
        <td>
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Unexpected)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="hhvxslx:GetHtmlSpacedString(./Value)" disable-output-escaping="yes"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:if test="$mode = 'online' and ./Result = 'Failed' and $transactionId != '' and $productKeyId != ''">
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_Trace.xml'"/>
              </xsl:attribute>
              View OA3Tool Log Trace
            </a>
            <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_SMBIOS_Dump.txt'"/>
              </xsl:attribute>
              View SMBIOS Dump
            </a>
            <br/>
          </xsl:if>
          
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/PrimaryDiskTotalCapacity">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value: </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value: </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:if test="$mode = 'online' and ./Result = 'Failed' and $transactionId != '' and $productKeyId != ''">
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_Trace.xml'"/>
              </xsl:attribute>
              View OA3Tool Log Trace
            </a>
            <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_SMBIOS_Dump.txt'"/>
              </xsl:attribute>
              View SMBIOS Dump
            </a>
            <br/>
          </xsl:if>
          
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/DisplayResolutionHorizontal">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Chassis Type: </td>
        <td>
          <xsl:value-of select="./ChassisType"/>
          <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
          (<xsl:value-of select="hhvxslx:GetEnclosureType(./ChassisType)"/>)
      </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/DisplayResolutionVertical">
   <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
     <tr>
       <td>Max Value (Length): </td>
       <td>
         <xsl:value-of select="./Max"/>
       </td>
     </tr>
      <tr>
        <td>Chassis Type: </td>
        <td>
          <xsl:value-of select="./ChassisType"/>
          <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
          (<xsl:value-of select="hhvxslx:GetEnclosureType(./ChassisType)"/>)
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/DisplaySizePhysicalH">
     <table xmlns="http://www.w3.org/1999/xhtml">
       <tr>
         <td>Min Value (Length): </td>
         <td>
           <xsl:value-of select="./Min"/>
         </td>
       </tr>
       <tr>
         <td>Max Value (Length): </td>
         <td>
           <xsl:value-of select="./Max"/>
         </td>
       </tr>
      <tr>
        <td>Chassis Type: </td>
        <td>
          <xsl:value-of select="./ChassisType"/>
          <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
          (<xsl:value-of select="hhvxslx:GetEnclosureType(./ChassisType)"/>)
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:if test="$mode = 'online' and ./Result = 'Failed' and $transactionId != '' and $productKeyId != ''">
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_Trace.xml'"/>
              </xsl:attribute>
              View OA3Tool Log Trace
            </a>
            <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_MonitorSize_Dump.txt'"/>
              </xsl:attribute>
              View Monitor Size Dump
            </a>
            <br/>
          </xsl:if>
          
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="TestItems/DisplaySizePhysicalY">
    <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
        <td>Min Value (Length): </td>
        <td>
          <xsl:value-of select="./Min"/>
        </td>
      </tr>
      <tr>
        <td>Max Value (Length): </td>
        <td>
          <xsl:value-of select="./Max"/>
        </td>
      </tr>
      <tr>
        <td>Chassis Type: </td>
        <td>
          <xsl:value-of select="./ChassisType"/>
          <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
          (<xsl:value-of select="hhvxslx:GetEnclosureType(./ChassisType)"/>)
        </td>
      </tr>
      <tr>
        <td>Test Value: </td>
        <td style="background-color:yellow">
          <xsl:value-of select="./Value"/>
        </td>
      </tr>
      <tr>
        <td>Result: </td>
        <td>
          <xsl:if test="./Result = 'Passed'">
            <xsl:attribute name="style">background-color:forestgreen</xsl:attribute>
          </xsl:if>
          <xsl:if test="./Result = 'Failed'">
            <xsl:attribute name="style">background-color:red</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="./Result"/>
        </td>
      </tr>
      <tr>
        <td>Detail: </td>
        <td>
          <xsl:if test="$mode = 'online' and ./Result = 'Failed' and $transactionId != '' and $productKeyId != ''">
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_Trace.xml'"/>
              </xsl:attribute>
              View OA3Tool Log Trace
            </a>
            <xsl:value-of select="'&amp;nbsp;'" disable-output-escaping="yes"/>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:value-of select="$transactionId"/>
                <xsl:value-of select="'_'"/>
                <xsl:value-of select="$productKeyId"/>
                <xsl:value-of select="'_MonitorSize_Dump.txt'"/>
              </xsl:attribute>
              View Monitor Size Dump
            </a>
            <br/>
          </xsl:if>
          
          <xsl:value-of select="./Detail"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
</xsl:stylesheet>
