<%@ include file="include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<!-- $Id: signup.jsp 323 2007-04-21 18:08:49Z hiroki $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="utilssource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="browserdetectsource"/>"></script>
<script type="text/javascript" src="<spring:theme code="checkcompatibilitysource"/>"></script>
<script type="text/javascript" src="./javascript/tels/deployJava.js"></script>

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
  
<title><spring:message code="checkcompatibility.title" /></title>

<link rel="shortcut icon" href="./themes/tels/default/images/favicon_panda.ico" /> 

</head>

<body onload='checkCompatibility(${specificRequirements})'>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">WISE4系統確認</div>
				<div class="panelContent">

					<div class="sectionHead" style="padding-top:0;">瀏覽器相容性確認</div>
					<div class="sectionContent"> 
						<div><table>
							<tr>
								<th>資源</th>
								<th>狀態</th>
								<th>版本需求</th>
								<th>您的版本</th>
								<th>需求滿足性</th>
								<th>附加資訊</th>
							</tr>
							<noscript>
								<tr>
								<td>Javascript</td>
								<td>Required</td>
								<td>Enabled</td>
								<td>Disabled</td>
								<td><img src='./themes/tels/default/images/error_16.gif' /></td>
								<td><a href='https://www.google.com/support/adsense/bin/answer.py?answer=12654'>如何啟用Javascript</a></td>
								</tr>
							</noscript>
							<tr>
								<td id='javascriptResource'></td>
								<td id='javascriptStatus'></td>
								<td id='javascriptRequiredVersion'></td>
								<td id='javascriptYourVersion'></td>
								<td id='javascriptRequirementSatisfied'></td>
								<td id='javascriptAdditionalInfo'></td>
							</tr>
							<tr>
								<td id='browserResource'></td>
								<td id='browserStatus'></td>
								<td id='browserRequiredVersion'></td>
								<td id='browserYourVersion'></td>
								<td id='browserRequirementSatisfied'></td>
								<td id='browserAdditionalInfo'></td>
							</tr>
							<tr>
								<td id='quickTimeResource'></td>
								<td id='quickTimeStatus'></td>
								<td id='quickTimeRequiredVersion'></td>
								<td id='quickTimeYourVersion'></td>
								<td id='quickTimeRequirementSatisfied'></td>
								<td id='quickTimeAdditionalInfo'></td>
							</tr>
							<tr>
								<td id='flashResource'></td>
								<td id='flashStatus'></td>
								<td id='flashRequiredVersion'></td>
								<td id='flashYourVersion'></td>
								<td id='flashRequirementSatisfied'></td>
								<td id='flashAdditionalInfo'></td>
							</tr>
							<tr>
								<td id='javaResource'></td>
								<td id='javaStatus'></td>
								<td id='javaRequiredVersion'></td>
								<td id='javaYourVersion'></td>
								<td id='javaRequirementSatisfied'></td>
								<td id='javaAdditionalInfo'></td>
							</tr>
						</table></div>
						<noscript>
						<div>瀏覽器相容性確認結果：您不能執行WISE4</div>
						<div class='checkCompatibilityWarning'>警告：您必須啟用Javascript以順利執行WISE4，請點選"如何啟用Javascript"的連結以找到啟用方法</div></noscript>
						<div id='compatibilityCheckResult' style="font-weight:bold;"></div>
						<div id='compatibilityCheckMessages'></div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">網路相容性確認 (防火牆/代理伺服器)</div>
					<div class="sectionContent"> 
						<div>當執行WISE專案時防火牆/代理伺服器可能會造成執行的問題。WISE並無法自動改變您所在學校防火牆的設定。這部分的確認方法為：如果您在WISE伺服器存取一些資源時受到限制，或者WISE無法正常運作，請聯絡您的伺服器管理員。
						</div>
						<div id='contentFilterMessageSwf'>
							<span>可以存取Flash物件 (.swf):</span><span id='contentFilterSwfRequirementSatisfied'>確認中...</span><br/><br/>
							<span>可以存取Java檔案 (.jar):</span><span id='contentFilterJarRequirementSatisfied'>確認中...</span>
						</div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">瀏覽器建議</div>
					<div class="sectionContent"> 
						<div>選擇瀏覽器以執行WISE</div>
						<div><table>
							<tr>
								<th>瀏覽器、版本、作業系統</th>
								<th>已知問題</th>
								<th>建議度</th>
							</tr>
							<tr>
								<td>Firefox 3.5/3.6 on OSX and Windows</td>
								<td>無</td>
								<td>強烈建議</td>
							</tr>
							<tr>
								<td>Chrome on OSX and OSX and Windows</td>
								<td>無</td>
								<td>建議</td>
							</tr>
							<tr>
								<td>Safari 4.0+ on OSX</td>
								<td>無</td>
								<td>建議</td>
							</tr>
							<tr>
								<td>IE 7,8 on Windows</td>
								<td>手繪圖與系統圖步驟無法運作；教師與學生頁面的一些使用性問題</td>
								<td>不建議</td>
							</tr>
							<tr>
								<td colspan="3">其他瀏覽器尚未經過測試並不建議使用</td>
							</tr>
						</table></div>
					</div>
					
					<div id='contentFilter' class="sectionHead" style="padding-top:0;">電腦系統需求</div>
					<div class="sectionContent"> 
						<div>完全支援的配置：</div>
						<div>
							<table class='confluenceTable'><tbody> 
								<tr> 
								<td class='confluenceTd'>作業系統</td> 
								<td class='confluenceTd'>OS X &gt;=10.5 or Windows XP/2k, Vista, 7</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>記憶體</td> 
								<td class='confluenceTd'>>=512MB</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>Java</td> 
								<td class='confluenceTd'>1.5.0以上</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>Flash</td> 
								<td class='confluenceTd'>10.0以上</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>防火牆</td> 
								<td class='confluenceTd'>無防火牆</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>代理伺服器</td> 
								<td class='confluenceTd'>無代理伺服器</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>執行</td> 
								<td class='confluenceTd'>使用者允許執行 (<a href="http://javatechniques.com/blog/launching-java-webstart-from-the-command-line" rel="nofollow">javaws</a>)</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>儲存</td> 
								<td class='confluenceTd'>使用者允許寫入系統磁碟</td> 
								</tr>
                                <!--								
								<tr> 								
								<td class='confluenceTd'>Peristence</td> 
								<td class='confluenceTd'>Writes to disk persist all week</td> 
								</tr> 
								-->
								</tbody>
							</table>
						</div>
						<div style="margin-top:1em;">部分支援的配置：</div>
						<div>
							<table class='confluenceTable'><tbody> 
								<tr> 
								<td class='confluenceTd'>作業系統</td> 
								<td class='confluenceTd'>OS X &gt;=10.4 or Windows XP,Vista, 7</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>記憶體</td> 
								<td class='confluenceTd'>>=256MB</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>Java</td> 
								<td class='confluenceTd'>1.5.0以上</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>Flash</td> 
								<td class='confluenceTd'>10.0以上</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>防火牆</td> 
								<td class='confluenceTd'>無防火牆</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>代理伺服器</td> 
								<td class='confluenceTd'>部分代理伺服器</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>執行</td> 
								<td class='confluenceTd'>使用者允許執行javaws</td> 
								</tr> 
								<tr> 
								<td class='confluenceTd'>儲存</td> 
								<td class='confluenceTd'>使用者允許寫入系統磁碟</td> 
								</tr> 
								<tr> 
								<!--
								<td class='confluenceTd'>Peristence</td> 
								<td class='confluenceTd'>without persistence, downloads take place each session</td> 
								-->
								</tr> 
							</tbody></table> 
						</div>
						<div style="margin-top:1em;"><a href="pages/schoolIT.html">學校技術人員資源</a></div>
					</div>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->
	
	<%@ include file="footer.jsp"%>
</div>

</body>
</html>


