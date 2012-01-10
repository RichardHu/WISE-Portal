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
<script src="<spring:theme code="jqueryuisource"/>" type="text/javascript"></script>

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
					使用WISE教學
				</div>
				
				<div class="panelContent">
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/wise-teacher.png" alt="Teaching with WISE" />
						<div class="featureContent">
							<div class="featureContentHeader">WISE教師工具</div>
							<p>為了引導學生進入探究式的WISE課程，老師透過個別或小組的方式調查學生的想法，而且週期性地對全班提出關於整個課程的內容。WISE提供教師一系列的整合性工具來有效管理與促進學生使用WISE學習。教師可以即時觀看學生的學習過程，在學生實作中給予立即的回饋，並且可以使用自動化評分系統有效率地進行評分。 </p>
							<p>在更有效地促進課程管理工作方面，透過與個別學生的互動以及洞悉整個課堂的學習狀況，教師可以自由地關注不同學生的學習需求。</p>
							<p>WISE提供了各式各樣一個星期長度的探索單元，包含了與加州以及全國標準一致的重要概念。WISE單元不只符合教師現有的科學課程主題，而且可以客製化給予課堂使用。</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featureContentHeader">重要特色</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/teacher-manage.png" alt="management" />
						<div class="featureContent">
							<p class="featureHeader">管理、掌握與促進</p>
							<ul>
								<li><span style="font-weight:bold;">過程的掌握：</span><br>用課堂監控可以即時觀看學生線上實作情形。這個工具讓教師很快地評估每個學習小組的進行過程，並決定是否有需要介入個別學生或班級。</li>
								<li><span style="font-weight:bold;">步驟完成呈現：</span><br>可觀看學生在WISE課程中特殊步驟和活動的完成度百分比。這個特性提供了快速而簡易的方式，去確認透過WISE課程課堂是如何進行的。</li>
								<li><span style="font-weight:bold;">停留畫面：</span><br>停留功能在學生電腦同步實施，這個特性可以用來讓學生集中注意力於特殊的活動，如課堂討論或者控制學生WISE課程的學習步調。</li>
								<li><span style="font-weight:bold;">學生實作標記：</span><br>選取學生整個課堂上分享、探討或評論的特殊回應。謹慎地選取學生的例子可以當作一個有效的基礎，用來檢視主要的想法，或者對評論實作產生準則。</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase left">
						<img src="/webapp/themes/tels/default/images/features/teacher-grading.png" alt="grading and feedback" />
						<div class="featureContent">
							<p class="featureHeader">評分 & 回饋</p>
							<ul>
								<li><span style="font-weight:bold;">學生實作評分 & 提供回饋：</span><br>很容易觀看學生的實作並評分以及下評語，學生並可檢視與回應。教師可以依據課程步驟或學生分組為學生的實作評分。 </li>
								<li><span style="font-weight:bold;">預先的評語：</span><br>編輯與使用平常對於學生實作會用到的回饋評語模板。教師可以建立預先的評語讓回饋上百位學生的回應過程變得流暢。</li>
								<li><span style="font-weight:bold;">自動評分評量：</span><br>使用wise自動評分規則為學生評分。這個新發展的特性將輔助教師快速而正確地評判學生在重要課程步驟的實作情形。</li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="featuresShowcase right">
						<img src="/webapp/themes/tels/default/images/features/teacher-customization.png" alt="customization" />
						<div class="featureContent">
							<p class="featureHeader">客製化課程</p>
							<ul>
								<li><span style="font-weight:bold;">WISE編輯工具：</span><br>建立客製化的課程以符合特殊的課堂背景。WISE用設計課程頁面與嵌入式評量的方式提供了彈性與創造性。課程的編輯者可以修改現有的WISE專題以符合特殊的需求，甚至建立任何主題的全新專題。</li>
								<li><span style="font-weight:bold;">分享課程：</span><br>提供其他WISE教師取得課程。WISE使用者可以分享專題給想要在課堂上實施或者想客製化修改的教師。透過分享專題，課程編輯者可以合作編輯並且精緻化WISE單元。
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