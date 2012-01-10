<%@ include file="include.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"%>
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

<title>WISE Learning Environment</title>

</head>

<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
			<div class="contentPanel">
			
				<div class="panelHeader">
					WISE特色
				</div>
				
				<div class="panelContent">
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-vle.png" alt="WISE Virtual Learning Envirnment" />
						<div class="featureContent">
							<div class="featureContentHeader">WISE虛擬學習環境</div>
							<p>WISE是一個用來設計、發展與實施科學探究活動的強大線上平台。自從1977年開始，WISE提供服務給超過15,000位科學教師、研究者和課程設計者，還有世界各地超過10,000名的K-12學生，而且使用族群正在成長之中。</p>
							<p>WISE提供簡單的使用者介面、認知提示、嵌入式回應筆記與評量、線上討論，而且還有提供活動使用的軟體工具像畫板、概念地圖、表格與圖示。WISE亦可使用多樣化的網路科技建立互動式的模擬和模型。WISE專題透過合作反思活動與教師的回饋促進學生自我檢視。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featureContentHeader">課程特性與工具</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/vle-prompts.png" alt="prompts" />
						<div class="featureContent">
							<p class="featureHeader">閱讀&寫作提示</p>
							<ul>
								<li><span style="font-weight:bold;">預測、觀察、解釋、反思：</span><br>POER模式引導學生解釋主題、提出預測、描述觀察蒐集到的資料，並且用證據去解釋他們預測的改變。</li>
								<li><span style="font-weight:bold;">評論與回饋：</span><br>學生透過風格性、目的性和證據來源產生評論以評估不同的論點，以這些評論為基礎，他們寫下了對同儕實作的重要回應。</li>
								<li><span style="font-weight:bold;">科學論述：</span><br>學生寫下一致性的科學論述，這需要他們去選擇重要的事件，並且關注事件的順序性與連貫性。</li>
								<li><span style="font-weight:bold;">挑戰問題：</span><br>學生評估不同科學解釋的品質而且自動被引導到相關的活動以增進他們的理解。</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/vle-argumentation.png" alt="argumentation" />
						<div class="featureContent">
							<p class="featureHeader">組織辯論 & 產生解釋工具</p>
							<ul>
								<li><span style="font-weight:bold;">想法管理員：</span><br>就內容、來源以及主張的連結而言，圖形化組織工具引導了證據的評估。想法籃提供一個持續性的空間讓學生蒐集和整理多媒體資料。建立解釋使用想法籃的證據，提供一個組織化的空間，對論述的構想提供了鷹架。</li>								
								<li><span style="font-weight:bold;">WISE手繪圖 & 影格動畫：</span><br>學生可以手繪並擷取快照來建立動畫，並且可以重新播放他們的影格動畫。這樣可以引導學生將他們的論點轉化為不同的表現形式。</li>
								<li><span style="font-weight:bold;">系統圖：</span><br>圖表工具可以視覺化事件的順序並引導學生寫下口語的描述。轉化不同的表現方式幫助學生辨別描述性的抽象架構以及關鍵內容細節。</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/vle-activities.png" alt="activity structures" />
						<div class="featureContent">
							<p class="featureHeader">活動模板</p>
							<ul>
								<li><span style="font-weight:bold;">探索 & 角色扮演：</span><br>WISE專題探究對個人有意義的驅動問題。學生像科學家一般去探究一些現象，幫助學生覺得科學是可接近的，這樣可以提高他們探究科學的動機。</li>
								<li><span style="font-weight:bold;">同儕互評 & 回饋：</span><br>學生暱名而被指定分析與評論同儕。練習從過程中產生評論與回饋可以幫助學生發展重要的評估能力有如合作性的知識建構。</li>
								<li><span style="font-weight:bold;">辯論、腦力激盪、討論：</span><br>學生與同儕分享他們寫下的解釋和回饋。他們被鼓勵去精緻化與建構其他人的想法。</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/vle-simulations.png" alt="simulations" />
						<div class="featureContent">
							<p class="featureHeader">豐富的媒體 & 互動式模擬</p>
							<ul>
								<li><span style="font-weight:bold;">虛擬實驗：</span><br>類似專業科學家的活動，學生規畫和主導實驗的進行，並且蒐集資料以支持他們的論點。提示和圖形化組織工具運用豐富的複雜科學現象模擬及模型，提供學生互動的鷹架。</li>
								<li><span style="font-weight:bold;">多媒體版本：</span><br>課程設計者可以客製化並嵌入自己加工的豐富媒體，以適合每一個課程內容 (e.g. 動畫、影像、圖表、圖片、錄影、外部網頁，以及敘述文本)。由於有鷹架工具的支持，學生從抽象化資訊的不同表現形式中流暢地獲得知識。</li>
							</ul>
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