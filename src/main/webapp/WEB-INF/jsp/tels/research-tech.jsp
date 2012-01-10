<%@ include file="include.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>

<!DOCTYPE html>
<html>
<head>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" rel="stylesheet" type="text/css" />

<script src="<spring:theme code="jquerysource"/>" type="text/javascript"></script>

<link rel="shortcut icon" href="<spring:theme code="favicon"/>" />

<title>Research & Technology</title>

</head>

<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="contentPanel">
			
				<div class="panelHeader">WISE研究 & 科技</div>
				
				<div class="panelContent">
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-research.png" alt="research" />
						<div class="featureContentHeader">研究概觀</div>
						<div class="featureContent">
							<p>從20年前的合作研究開始，WISE社群運用教育科技開發教學課程，來幫助國高中學生熟悉複雜的科學概念。這個社群由教師、教育研究者、科學家與科技專家所組成。WISE專案與軟體由<a href="http://telscenter.org" target="_blank">Technology Enhanced Learning in Science (TELS) Community</a>的研究者所開發。TELS社群的夥伴包含十三個大學、一個非營利教育研究與發展組織，還有十五個學區。使用WISE專案的當地合作教師，在每年的暑期座談會與教室面談會中提供他們實務的觀點。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/ki.png" alt="knowledge integration" />
						<div class="featureContent">
							<div class="featureContentHeader" id="ki">知識整合</div>
							<p>學生解決科學中多樣、衝突以及困惑的想法。豐富的研究傳統驅動WISE課程與科技的發展，研究顯示當教師以學生觀點出發來從事科學探究，這樣的教學是最有效的。當教師和教學資源引導學習者，在不同的情境脈絡中清晰地表達個人的想法、增加新想法以及整理想法，而且在不同程度的分析中產生連結，他們發展了更細微的準則，用來評判想法、歸納與公式化有關科學現象的連結性觀點。TELS的領導者Marcia C. Linn描繪此為知識整合架構，而它也形成WISE專案與評量的基礎。(更多資訊在<a href="http://telscenter.org" target="_blank">TELS網站</a>以及<a href="http://telscenter.org/publications" target="_blank">TELS研究出版</a>)</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-group.png" alt="wise retreat group" />
						<div class="featureContentHeader">研究目標</div>
						<div class="featureContent">
<ol><li><span style="font-weight:bold;">課程發展：</span><br>教師可透過科學現象的電腦視覺表徵以豐富新學習環境的建構與客製化；在學校對不同的學生族群測試這些學習環境。
</li>
<li><span style="font-weight:bold;">專業發展：</span><br>增加能完全利用科技促進科學教育之教師與管理者的數量及類型。</li>
<li><span style="font-weight:bold;">研究所教育：</span><br>擴展研究生的課程以培養科學教育科技、課程發展、專業發展以及教育政策的領導者與專家。
</li>
<li><span style="font-weight:bold;">科學教育研究：</span><br>增加研究的量與質以調查有效的科技如何促進科學學習。</li>
<li><span style="font-weight:bold;">有效運用科技：</span><br>組織夥伴關係致力於提高科技促進科學教育；成立開放原始碼社群設計經過改進的教學資源。
</li></ol>
						</div>
						<div style="clear:both;"></div>
					</div>
					<!--
					<div class="featuresShowcase left">
						<div class="featureContent">
							<img src="/webapp/themes/tels/default/images/features/tels-projects.png" alt="tels nsf projects" />
							<div class="featureContentHeader">National Science Foundation Funded Research Grants</div>
							<p>The TELS Community currently operates five NSF funded research projects:</p>
							<ol>
								<li><a style="font-weight:bold;" href="http://telscenter.org/projects/clear" target="_blank">The CLEAR project</a> investigates how science assessments can both capture and contribute to cumulative, integrated learning of energy in middle-school science courses.</li>
								<li><a style="font-weight:bold;" href="http://telscenter.org/projects/visual" target="_blank">The VISUAL project</a> investigates, compares, and refines promising visualizations to determine when and how they improve physical science learning.</li>
								<li><a style="font-weight:bold;" href="http://telscenter.org/projects/loops" target="_blank">The LOOPS project</a> makes innovative use of technology to allow teachers to make data-based decisions about alternative teaching strategies during the course of instruction.</li>
								<li><a style="font-weight:bold;" href="http://telscenter.org/projects/models" target="_blank">The MODELS project</a> enables middle and high schools to design and sustain school-based professional development and supports teachers as they integrate technology-enhanced science curricula into existing instruction.</li>
								<li><a style="font-weight:bold;" href="http://telscenter.org/projects/surge" target="_blank">The SURGE project</a> harnesses popular videogame design principles to help students learn challenging ideas in Newtonian mechanics.</li>
							</ol>
						</div>
						<div style="clear:both;"></div>
					</div>
					-->
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-results.png" alt="results" />
						<div class="featureContentHeader">被證明的學習改善</div>
						<div class="featureContent">
							<p>WISE課程已經在國高中的課堂上測試超過二十年的時間，遍及了超過十個學區。之前的研究顯示WISE課程單元增進學生困難科學主題的學習(<a href="http://www.sciencemag.org/content/313/5790/1049.citation" target="_blank">Linn et al., 2006</a>)，而即使在單元結束後，學生持續地整合想法以及增強他們的理解。更多關於WISE學習成果的資訊，瀏覽<a href="http://telscenter.org/publications" target="_blank">WISE出版資料庫</a>。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/collaborators.png" alt="collaborators" />
						<div class="featureContent">
							<div class="featureContentHeader" id="technology">開放原始碼科技</div>
							<p>WISE是開放原始碼平台，可以支持課程發展以及教學科技研究事項的範疇。原本發展來支持中學探究式科學學習的研究，WISE現在已經適合支持K-12與大學程度工程教育的研究(<a href="http://www.wisengineering.org" target="_blank">http://www.wisengineering.org</a>)。支持高中學生如何使用資料庫證據來建構論點(<a href="http://www.sciencemathpartnerships.net/webapp/index.html" target="_blank">http://www.sciencemathpartnerships.net/webapp/index.html</a>)，結合學習管理系統以研究大學程度的電腦科學教育(<a href="http://sage.cs.berkeley.edu/" target="_blank">http://sage.cs.berkeley.edu/</a>)，並且翻譯了中文化課程來支持臺灣的地球科學教育(<a href="http://twise4.es.ntnu.edu.tw:8080/webapp/index.html" target="_blank">http://twise4.es.ntnu.edu.tw:8080/webapp/index.html</a>)。K-12獨立教師也運用WISE平台建構了不同主題領域的課程。這些改編與獨立建構是WISE做為一個容易使用且具彈性之課程與教學科技平台的例證。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise4-org.png" alt="wise4.org" />
						<div class="featureContentHeader">WISE開發社群</div>
						<div class="featureContent">
							<p>我們正在發展一個以WISE為中心，活躍與動態的軟體開發者社群。客製化的WISE伺服器已經建置在華盛頓大學、維吉尼亞州立大學、多倫多大學、臺灣師範大學與臺灣高雄師範大學。一些採用者已經在當地的課堂實施WISE專題而且蒐集研究資料(華盛頓大學)。WISE採用者幫助我們將WISE翻譯成繁體中文，以及主動地建立新的步驟類型和學習活動。關於和WISE合作以及如何安裝軟體在你的伺服器等相關資訊，請瀏覽我們的開發者網站(<a href="http://wise4.org" target="_blank">http://wise4.org</a>)並加入我們的<a href="https://groups.google.com/forum/?pli=1#!forum/wise4-dev" target="_blank">WISE4開發者論壇</a>。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase">
						<div class="featureContent">
							<div class="featureContentHeader">合作機會</div>
							<p>我們正在尋求新的研究與發展合作機會。如果您對WISE研究社群有興趣或者有任何問題，請<a href="/webapp/contactwisegeneral.html">與我們聯繫</a>。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
				</div>
			</div>
		
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="footer.jsp"%>
</div>

</body>

</html>