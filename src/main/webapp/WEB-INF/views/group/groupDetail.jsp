<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="<%=request.getContextPath()%>/resources/css/groupDetail.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/groupJoinPop.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/pop_menu.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="resources/js/Alarm.js"></script>
	<style>
		#cancel2{margin-left: 16px; margin-top:-4px;cursor: pointer;display: block;width: 100px; background:#e5e5e5;border: none;border-radius: 10px;width:100px;height: 35px;float: left;}	
		#report-submit{margin-left:50px; margin-top:-4px; float:left; width:100px; background:#daf4ed;}
		#selectRtype{ width:100px; margin-left:50px; background:#daf4ed;}
		#reportContent{margin-top:14px; margin-left:50px; background:#daf4ed; resize:none;display:none; border:none;}
		/*검색했을 때 피드들 */
		#searchFeed {display: none; width: 630px; height: 100%;}
		.postbox{ width: 200px; height: 200px; margin: 10px 5px 0 5px; float: left; display: inline-block;}
		.postbox > img {width: 100%; height: 100%;}
		.feedContainar { height: 100%;}
		/*피드 팝업*/
		.pop_feed{ position: fixed; display: none; width: 100%; height: 100%; left:0; top:0; z-index: 100; overflow: auto; background-color:rgb(0,0,0); background-color: rgba(0,0,0,0.4); }
		.feed_delete>img{ width:20px; height: 20px; margin: 10px; float: right; }
		.pop_feed > #writer_submenu_pop{ width: 630px; height: 60px; border-bottom: 1px solid #e5e5e5; background: white; margin: auto; margin-top: 50px; }
		.pop_feed > #feed_profile_img{width: 35px; height: 35px; border-radius: 15px; border: 3px double #47c6a3; float: left; margin:10px 20px 0 20px; }
		.pop_feed > #feed_id{ padding-top:11px; margin:0; color:#555555; font-weight: 600; font-size: 16px; }
		.pop_feed > #feed_menu_pop{ float: right; margin:27px 20px 0 0; }
		.pop_feed > #user_time{ float: left; width: 200px; }
		.pop_feed > #feed h6{ color: #cccccc; margin: 0; padding:0; margin-top: 2px; }
		.pop_feed > #input_img{ width: 630px; height: 630px; }
		
		.pop_feed > #heart_reply{ border-bottom: 1px solid #e5e5e5; width: 100%; height: 40px; }
		.pop_feed > #likeIcon{ width: 25px; height: 25px; opacity: 80%; margin: 6px 0 0 25px; }
		.pop_feed > #replyIcon{ width: 23px; height: 23px; opacity: 65%; margin: -6px 0 0 15px;}
		.pop_feed > #text{ margin:25px 0 25px 25px; font-size: 18px; color:#555555; }
		.pop_feed > #con{ width: 630px; background: white; margin: auto; }
		.pop_feed > #con #tag{ padding: 5px 5px 5px 0; height: 60px; width: 90%; margin:auto; }
		.pop_feed > #con #tag li{ list-style: none; float: left; margin-right: 5px; font-size: 14px; color: #555555;}
		
		.pop_feed >#replyArea{ width: 630px; padding-top: 20px;background: white; margin: auto; }
		.pop_feed >#replyList{ width: 630px; height: 150px; overflow: auto; margin: auto; }
		.pop_feed >#replyList::-webkit-scrollbar{ width: 7px; }
		.pop_feed >#replyList::-webkit-scrollbar-thumb{ border-radius: 10px;background-color: #47c6a3; }
		.pop_feed >#replyList::-webkit-scrollbar-track{ background-color: #daf4ed; }
		.pop_feed >#replyList ul{ margin: auto; margin-left:25px; padding: 0; }
		.pop_feed >#re_list li{ list-style: none; float: left; }
		.pop_feed >#re_list li:nth-child(1){ width: 25%; }
		.pop_feed >#re_list li:nth-child(2){ width: 55%; }
		.pop_feed >#re_list li:nth-child(3){ width: 10%; }
		.pop_feed >#re_list li:nth-child(4){ width: 10%; }
		.pop_feed >#updateBtn{ margin: 15px 0 0 14px; padding: 5px 0px 5px 0px; }
		
		.pop_feed >#userId{ float: left; margin: 9px 0px 0 15px; font-weight: 600; color: #555555;}
		.pop_feed >#reply_img{ width: 35px; height: 35px; border-radius: 15px; border: 3px double #47c6a3; float: left; }
		.pop_feed >#replyCon{ font-size: 14px; color:#555555; font-weight:lighter; margin-top:9px; height: 100%; }
		.pop_feed >#time{ font-size: 12px; float: right; color: #aaaaaa;}
		.pop_feed >#reply{ width: 630px; padding: 20px 0 20px 0; margin: auto; margin-bottom: 50px; }
		.pop_feed >#textArea{ width: 470px; height: 40px; border-radius: 10px; border: 1px solid #e5e5e5; margin:0 10px 0 25px; }
		.pop_feed >#replyBtn{ width: 90px; height: 40px; border-radius: 10px; border: 0; background: #daf4ed; }
		
	</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	<div id="feedArea">
		<div id="section1">
                <div id="infofeed">
                    <!--그룹 정보 나오는 칸-->
                    <div id="groupInfoArea" > 
                        <!--그룹 이미지 넣는 장소?-->
                        <c:if test="${ !empty g.gImage }">
	                        <div id="groupImage" >
	                            <img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameImage }" alt="" >
	                        </div>
                        </c:if>
                        <c:if test="${ empty g.gImage }">
                        	<div id="groupImage" >
                            	<img src="<%=request.getContextPath()%>/resources/images/g_back.png" alt="" >
                        	</div>
                        </c:if>
                        <!--그룹명, 관심사, 소개 등등-->
                        <div id="groupInfo">
                            <!-- 그룹명 관심사-->
                            <div id="groupNameAndInterest">
                                <p id="groupName"><b>${ g.gName }</b> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</p>
                                <p id="groupInterest">${ g.gCategory }</p>
                            </div>
                            <!-- ... 버튼 -->
                            <button id="groupdotbtn" style="cursor:pointer;">
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" id="group_menuBtn" name="group_menuBtn">
                            </button>
                            <div class="pop_menu">
                                <div id="feed_menu_list">
                                    <ul>
                                        <li><a id="groupJoin_btn" class="gmSelet">그룹가입</a></li>
                                        <li><a id="feed_report_btn">신고</a></li> 
                                        <li><a id="close">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pop_menu_gm">
                                <div id="feed_menu_list">
                                <c:url var="gmDelete" value="gmDelete.do">
                                	<c:param name="gNo" value="${ g.gNo }"/>
                                	<c:param name="gmId" value="${ loginUser.userId }"/>
                                </c:url>
                                    <ul>
                                        <li><a href="${ gmDelete }">그룹탈퇴</a></li>
                                        <li><a id="feed_report_btn">신고</a></li> 
                                        <li><a id="close_gm">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="pop_menu_master">
                                <div id="feed_groupmenu_list">
                                	<c:url var="gUpdateView" value="gUpdateView.do">
                                		<c:param name="gNo" value="${ g.gNo }"/>
                                		<c:param name="gmId" value="${ loginUser.userId }"/>
                                	</c:url>
                                    <c:url var="gdelete" value="gdelete.do"/>
                                    <ul>
                                        <li><a href="${ gUpdateView }">그룹관리</a></li>
                                        <li><a href="${ gdelete }">그룹삭제</a></li>
                                        <li><a id="isnertGroupChat">채팅방생성</a></li>
                                        <li><a id="close_master">취소</a></li>
                                    </ul>
                                </div>
                            </div>
                           <div class="feed_report">
                                <div id="feed_report_con">
                                    <p>신고사유</p>
                                    <select id="reportType" class="selectRtype">
                                        <option value="unacceptfeed" selected>부적절한 게시글</option>
                                        <option value="insult">욕설</option>
                                        <option value="ad">광고</option>
                                        <option value="spam">도배</option>
                                    </select>
                                    	<textarea class="sendreport" id="reportContent" cols="28" rows="4"></textarea>
                                    <br>
                                    <input class="selectRtype" id="selectRtype"type="button" value="확인" style="cursor:pointer;">
                                    <input class="sendreport" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
                                    <button class="selectRtype" id="cancel" style="cursor:pointer;">취소</button>
                                    <button class="sendreport" id="cancel2" style="cursor:pointer; display:none;">취소</button>
                                </div>
                            </div>
                            </div>

                            <!-- 그룹 가입 팝업 -->
                            <div class="joinPop_back">
                                <div class="join">
                                    <div id="group_info">
                                        <p id="title">그룹가입</p>
                                        <div id="group_top">
                                        	<c:if test="${ !empty g.gProfile }">
                                            	<img src="<%=request.getContextPath()%>/resources/gUploadFiles/${ g.gRenameProfile }">
                                            </c:if>
                                            <c:if test="${ empty g.gProfile }">
												<img src="<%=request.getContextPath()%>/resources/icons/g_pro.png">
                                            </c:if>
                                            <p id="join_groupName">${ g.gName }</p>
                                            <ul>
						                      <c:forTokens var="gTag" items="${ g.gTag }" delims=" ">
								              		<li>${ gTag }&nbsp;</li>
							                  </c:forTokens>
                                            </ul>
                                        </div>
	                                    <form action="gmInsert.do" method="post">
	                                    	<input type="hidden" name="mId" value="${ loginUser.userId }">
	                                    	<input type="hidden" name="gNo" value="${ g.gNo }">
	                                    	<div id="join_questionCon">
	                                            <c:set var="q_status" value="${ g.gQset }"/>
                                        		<c:choose>
		                                            <c:when test="${ 'Y' eq q_status }">
		            									<c:if test="${ !empty g.q1 }">
			                                                <div id="questionBox">
			                                                    <p>질문 : ${ g.q1 }</p>
			                                                    <textarea cols="70" rows="5" name="a1"></textarea>
			                                                </div>
		                                                </c:if>
		                                                <c:if test="${ !empty g.q2 }">
		                                                	<div id="questionBox">
		                                                    	<p>질문 : ${ g.q2 }</p>
		                                                    	<textarea cols="70" rows="5" name="a2"></textarea>
		                                                	</div>
		                                                </c:if>
		                                                <c:if test="${ !empty g.q3 }">
		                                                	<div id="questionBox">
		                                                    	<p>질문 : ${ g.q3 }</p>
		                                                    	<textarea cols="70" rows="5" name="a3"></textarea>
		                                                	</div>
		                                                </c:if>
		                                            </c:when>
		                                            <c:otherwise>
		                                        		<p id="p1"><b>${ g.gName }</b>에 가입신청을 하시겠습니까?</p>
		                                        	</c:otherwise>
	                                        	</c:choose>
	                                            </div>
	                                            <div id="btnBox">
	                                                <input type="submit"  id="joinBtn" name="joinBtn" value="가입하기">
	                                                <input type="button" id="close_joinPop" name="close_joinPop" value="취소">
	                                    	</div>
	                                	</form>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 그룹 소개글-->
                            <div id="groupintroduction">
                                <b>그룹소개</b><br>
                                <p id="groupInfo">${ g.gIntro }</p><br>
                                <ul id="tag">
                                <c:forTokens var="gTag" items="${ g.gTag }" delims=" ">
	               					<li>${ gTag }&nbsp;</li>
                                </c:forTokens>
            					</ul>
                            </div> 
                        </div>
                    </div>
                 </div>
                 <c:set var="gOpenScope" value="${ g.gOpenScope }"/>
                 <c:set var="gmId" value="${gmId }"/>
                 <c:choose>
                 	<c:when test="${ 'N' eq gOpenScope }">
                		<c:if test="${ not fn:contains(gmId, loginUser.userId) }">
		                 	<div id="nOpen" style="display:block">
	                			<p>비공개 그룹입니다. 가입신청을 하신 후 이용해주세요.</p>
	                		</div>
                		</c:if>
                		<c:if test="${ fn:contains(gmId, loginUser.userId) }">
		                 	<div id="nOpen" style="display:none">
	                			<p>비공개 그룹입니다. 가입신청을 하신 후 이용해주세요.</p>
	                		</div>
                		<!-- 그룹 내 검색 -->
                       	<div id="section2">
		                    <div id="groupSearchbar">
		                        <input type="search" id="groupSearch" name="groupSearch" placeholder="그룹 내 검색">
		                        <input type="button" id="groupSearchBtn" name="groupSearchBtn" value="검색">
		                    </div>
		                    <div id="groupFeedArea">
		                        <div id="btnsbox">
		                            <button class="newFeedBtn feedbtns on" id="newFeedBtn" >최근 게시글</button>
		                            <button class="hotFeedBtn feedbtns" id="hotFeedBtn" >인기 게시글</button>
		                        </div>
		                    </div>
	                 	</div>        
	                        <div class="feedContainar">
	                            <div class="newConBox conBox on">
	                            <div id="newfeedArea">
								<c:if test="${ !empty ngflist }">
								<c:forEach var="f" items="${ ngflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a id="storageBox_btn">보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a>삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
							                <div id="feed_content">
												<c:if test="${ !empty f.photoList and f.photoList ne null }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
														
														<ul id="imgList" style="height:633px">
															<c:forEach var="p" items="${ f.photoList }">
															<c:if test="${ p.changeName ne null }">
																<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
															</c:if>
															</c:forEach>
														</ul>
												</c:if>
							                   <p id="text"><c:out value="${ f.fContent }" /></p>

												<div id="heart_reply">
												<!-- 좋아요 금지가 되어 있지 않을 경우 -->
												<c:if test="${ f.fLikeSet == 'Y' || empty f.fLikeSet }">
												<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
								             	<c:choose>
									             	<c:when test="${ f.likeChk eq null }">
									             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
									             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:when>
									             	<c:otherwise>
									             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
										               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:otherwise>
								             	</c:choose>
												</c:if>
								               		<input type="hidden" class="toNo" value="${ f.fNo }">
								               		<input type="hidden" class="toId" value="${ f.fWriter }">
								               		<!-- 댓글이 전체 허용일 경우 -->
													<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
													<c:choose>
														<c:when test="${ f.fLikeSet == 'N' }">
														<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:when>
														<c:otherwise>
														<!-- 댓글과 좋아요 모두 허용될 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:otherwise>
													</c:choose>
													</c:if>
								
													<c:if test="${ f.fReplySet == 'N' && f.fLikeSet == 'N' }">
														<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
													</c:if>
								           		</div>
											</div>
											<div id="replyArea">
												<div id="replyList" style="display: block; height: fit-content;">
												<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
												<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
												<c:if test="${ f.fReplyCnt ne null && f.replyList[0].rStatus eq 'Y' }">
													<div id="replySub" style="display: block; height: 150px; overflow: auto;">
													<c:forEach var="r" items="${ f.replyList }">
														<div id="selectOne">
														<!-- 댓글 번호 -->
														<input type="hidden" class="rNum" value="${ r.rNo }">
											  				<ul id="re_list" class="list">
											  				<c:if test="${ !empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
															<c:if test="${ empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
																<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
																<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
																<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
																<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
															</ul>
															<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
															<c:if test="${ loginUser.userId eq r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
																		<li><a class="rDelete">댓글 삭제</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
															<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
															<c:if test="${ loginUser.userId ne r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
																		<li><a id="rReport" class="rReport">댓글 신고</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
														</div>
													</c:forEach>
													</div>
												</c:if>
												</div>
												<!-- 댓글 전체 허용일 경우 -->
												<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
												<div id="reply">
													<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
													<input type="text" id="textArea" class="rContent" name="textArea">
													<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
												</div>
												</c:if>
											</div>
										</div>
							       	</div>
							   
							   </c:forEach>
							   </c:if>
							   </div>
							   </div>
	                            <div class="hotConBox conBox">
	                                <div id="newfeedArea">
								<c:if test="${ !empty hgflist }">
								<c:forEach var="f" items="${ hgflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a>삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    </div>
							            <div id="con">
											<div id="feed_content">
												<c:if test="${ !empty f.photoList and f.photoList ne null }">
													<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
													<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
														
														<ul id="imgList" style="height:633px">
															<c:forEach var="p" items="${ f.photoList }">
															<c:if test="${ p.changeName ne null }">
																<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
															</c:if>
															</c:forEach>
														</ul>
												</c:if>
												 <p id="text"><c:out value="${ f.fContent }" /></p>

												<div id="heart_reply">
												<!-- 좋아요 금지가 되어 있지 않을 경우 -->
												<c:if test="${ f.fLikeSet == 'Y' || empty f.fLikeSet }">
												<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
								             	<c:choose>
									             	<c:when test="${ f.likeChk eq null }">
									             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
									             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:when>
									             	<c:otherwise>
									             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
										               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:otherwise>
								             	</c:choose>
												</c:if>
								               		<input type="hidden" class="toNo" value="${ f.fNo }">
								               		<input type="hidden" class="toId" value="${ f.fWriter }">
								               		<!-- 댓글이 전체 허용일 경우 -->
													<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
													<c:choose>
														<c:when test="${ f.fLikeSet == 'N' }">
														<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:when>
														<c:otherwise>
														<!-- 댓글과 좋아요 모두 허용될 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:otherwise>
													</c:choose>
													</c:if>
								
													<c:if test="${ f.fReplySet == 'N' && f.fLikeSet == 'N' }">
														<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
													</c:if>
								           		</div>
											</div>
											<div id="replyArea">
												<div id="replyList" style="display: block; height: fit-content;">
												<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
												<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
												<c:if test="${ f.fReplyCnt ne null && f.replyList[0].rStatus eq 'Y' }">
													<div id="replySub" style="display: block; height: 150px; overflow: auto;">
													<c:forEach var="r" items="${ f.replyList }">
														<div id="selectOne">
														<!-- 댓글 번호 -->
														<input type="hidden" class="rNum" value="${ r.rNo }">
											  				<ul id="re_list" class="list">
											  				<c:if test="${ !empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
															<c:if test="${ empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
																<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
																<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
																<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
																<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
															</ul>
															<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
															<c:if test="${ loginUser.userId eq r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
																		<li><a class="rDelete">댓글 삭제</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
															<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
															<c:if test="${ loginUser.userId ne r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
																		<li><a id="rReport" class="rReport">댓글 신고</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
														</div>
													</c:forEach>
													</div>
												</c:if>
												</div>
												<!-- 댓글 전체 허용일 경우 -->
												<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
												<div id="reply">
													<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
													<input type="text" id="textArea" class="rContent" name="textArea">
													<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
												</div>
												</c:if>
											</div>
										</div>
							       	</div>
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                        	<div id="searchFeed"></div>
	                        </div>
	                   </c:if>	
	               </c:when>
                 	<c:otherwise>
                	<!-- 그룹 내 검색 -->
	                 	<div id="section2">
	                    <div id="groupSearchbar">
	                        <input type="search" id="groupSearch" name="groupSearch" placeholder="그룹 내 검색">
	                        <input type="button" id="groupSearchBtn" name="groupSearchBtn" value="검색">
	                    </div>
	                    <div id="groupFeedArea">
	                        <div id="btnsbox">
	                            <button class="newFeedBtn feedbtns on" id="newFeedBtn" >최근 게시글</button>
	                            <button class="hotFeedBtn feedbtns" id="hotFeedBtn" >인기 게시글</button>
	                        </div>
	                    </div>
	                 </div>        
	                        <div class="feedContainar">
	                        	<div id="searchFeed"></div>
	                            <div class="newConBox conBox on">
	                            <div id="newfeedArea">
								<c:if test="${ !empty ngflist }">
								<c:forEach var="f" items="${ ngflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a>삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
											<div id="feed_content">
													<c:if test="${ !empty f.photoList and f.photoList ne null }">
														<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
														<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
															
															<ul id="imgList" style="height:633px">
																<c:forEach var="p" items="${ f.photoList }">
																<c:if test="${ p.changeName ne null }">
																	<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
																</c:if>
																</c:forEach>
															</ul>
													</c:if>
												 <p id="text"><c:out value="${ f.fContent }" /></p>

												<div id="heart_reply">
												<!-- 좋아요 금지가 되어 있지 않을 경우 -->
												<c:if test="${ f.fLikeSet == 'Y' || empty f.fLikeSet }">
												<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
								             	<c:choose>
									             	<c:when test="${ f.likeChk eq null }">
									             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
									             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:when>
									             	<c:otherwise>
									             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
										               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:otherwise>
								             	</c:choose>
												</c:if>
								               		<input type="hidden" class="toNo" value="${ f.fNo }">
								               		<input type="hidden" class="toId" value="${ f.fWriter }">
								               		<!-- 댓글이 전체 허용일 경우 -->
													<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
													<c:choose>
														<c:when test="${ f.fLikeSet == 'N' }">
														<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:when>
														<c:otherwise>
														<!-- 댓글과 좋아요 모두 허용될 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:otherwise>
													</c:choose>
													</c:if>
								
													<c:if test="${ f.fReplySet == 'N' && f.fLikeSet == 'N' }">
														<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
													</c:if>
								           		</div>
											</div>
											<div id="replyArea">
												<div id="replyList" style="display: block; height: fit-content;">
												<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
												<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
												<c:if test="${ f.fReplyCnt ne null && f.replyList[0].rStatus eq 'Y' }">
													<div id="replySub" style="display: block; height: 150px; overflow: auto;">
													<c:forEach var="r" items="${ f.replyList }">
														<div id="selectOne">
														<!-- 댓글 번호 -->
														<input type="hidden" class="rNum" value="${ r.rNo }">
											  				<ul id="re_list" class="list">
											  				<c:if test="${ !empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
															<c:if test="${ empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
																<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
																<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
																<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
																<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
															</ul>
															<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
															<c:if test="${ loginUser.userId eq r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
																		<li><a class="rDelete">댓글 삭제</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
															<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
															<c:if test="${ loginUser.userId ne r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
																		<li><a id="rReport" class="rReport">댓글 신고</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
														</div>
													</c:forEach>
													</div>
												</c:if>
												</div>
												<!-- 댓글 전체 허용일 경우 -->
												<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
												<div id="reply">
													<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
													<input type="text" id="textArea" class="rContent" name="textArea">
													<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
												</div>
												</c:if>
											</div>
										</div>
							       	</div>
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                            <div class="hotConBox conBox">
	                            <div id="hotfeedArea">
								<c:if test="${ !empty hgflist }">
								<c:forEach var="f" items="${ hgflist }" varStatus="status">
									<c:set var="i" value="${ i + 1 }"/>
									<div id="feed${ i }" class="feed">
										<div id="writer_submenu">
											<a href="goUserpage.do?userId=${ f.fWriter }&mNo=${ loginUser.mNo }">
											<img src="${ contextPath }/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
											<div id="user_time">
												<p id="feed_id"><c:out value="${ f.fWriter }" /></p>
												<h6><c:out value="${ f.fCreateDate }" /></h6>
												<c:url var="godetail" value="gdetail.do">
													<c:param name="gNo" value="${ f.gNo }"/>
												</c:url>
												<a href="${ godetail }" id="feed_gName">｜&nbsp;<c:out value="${ f.gName }"/></a>
											</div>
											</a>
											<img src="${ contextPath }/resources/icons/feed_menu.png" alt="" id="feed_menu" class="feed_menu${ i }">
								    <div class="feed_report">
						                   <div id="feed_report_con">
						                        <p>신고사유</p>
						                        <select id="reportType" class="selectRtype">
						                            <option value="unacceptfeed" selected>부적절한 게시글</option>
						                            <option value="insult">욕설</option>
						                            <option value="ad">광고</option>
						                            <option value="spam">도배</option>
						                        </select>
						                        	<textarea class="sendreport Rcontent" id="reportContent" cols="28" rows="4"></textarea>
						                        <br>
						                        <input class="selectRtype Rtype" id="selectRtype" type="button" value="확인" style="cursor:pointer;">
						                        <input class="sendreport report-submit" type="button" id="report-submit" value="확인" style="cursor:pointer; display:none;">
						                        <button class="selectRtype cancel" id="cancel" style="cursor:pointer;">취소</button>
						                        <button class="sendreport cancel2" id="cancel2" style="cursor:pointer; display:none;">취소</button>
						                </div>
							        </div>
								    <c:choose>
										<c:when test="${ loginUser.userId ne f.fWriter }">
								            <!-- 다른 회원 글 볼 때 피드메뉴 -->
								            <div class="g_pop_menu" id="g_pop_menu${ i }">
								                <div id="g_feed_menu_list">
								                    <ul>
								                       <li><a id="feed_report_btn" class="feed_report_btn">신고</a></li> 
								                       <li><a>공유하기</a></li> 
								                       <li><a>보관함</a></li> 
								                       <li><a id="close" class="close">취소</a></li>
								                    </ul>
								                </div>
								            </div>
								        </c:when>
										<c:otherwise>
											<!-- 내가 쓴 글 볼 때 피드 메뉴 -->
							                <div class="g_pop_Mymenu">
							                    <div id="g_feed_Mymenu_list">
							                        <ul>
							                        <li><a href="pUpdateView.do?fNo=${ f.fNo }" id="feed_menu1_btn">수정</a></li> 
							                        <li><a>삭제</a></li> 
							                        <li><a id="close" class="close">취소</a></li>
							                        </ul>
							                    </div>
							                </div>
										</c:otherwise>
									</c:choose>
								    
								    </div>
							            <div id="con">
											<div id="feed_content">
													<c:if test="${ !empty f.photoList and f.photoList ne null }">
														<button id="nextBtn${ i }" name="nextBtn" class="imgbtn nextBtn"><img src="${ contextPath }/resources/icons/nextbtn.png"></button>
														<button id="prevBtn${ i }" name="prevBtn" class="imgbtn prevBtn"><img src="${ contextPath }/resources/icons/prevbtn.png"></button>
															
															<ul id="imgList" style="height:633px">
																<c:forEach var="p" items="${ f.photoList }">
																<c:if test="${ p.changeName ne null }">
																	<li><img src="${ contextPath }/resources/pUploadFiles/${ p.changeName }" alt="" class="input_img"></li>
																</c:if>
																</c:forEach>
															</ul>
													</c:if>
												 <p id="text"><c:out value="${ f.fContent }" /></p>

												<div id="heart_reply">
												<!-- 좋아요 금지가 되어 있지 않을 경우 -->
												<c:if test="${ f.fLikeSet == 'Y' || empty f.fLikeSet }">
												<!-- true / false 로 나누어서 하트를 채울지 말지 결정 -->
								             	<c:choose>
									             	<c:when test="${ f.likeChk eq null }">
									             		<img src="${ contextPath }/resources/icons/heart.png" alt="" name="${ f.fNo }"class="likeIcon" id="likeIcon">
									             		<label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:when>
									             	<c:otherwise>
									             	<img src="${ contextPath }/resources/icons/heart_red.png" alt="" name="${ f.fNo }" class="likeIcon" id="liked">	             	
										               <label class="likeCnt" id="${ f.fNo }">${ f.fLikeCnt }개</label>
									             	</c:otherwise>
								             	</c:choose>
												</c:if>
								               		<input type="hidden" class="toNo" value="${ f.fNo }">
								               		<input type="hidden" class="toId" value="${ f.fWriter }">
								               		<!-- 댓글이 전체 허용일 경우 -->
													<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
													<c:choose>
														<c:when test="${ f.fLikeSet == 'N' }">
														<!-- 댓글이 전체 허용되면서 좋아요는 금지일 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon" style="margin: 9px 0 0 25px;">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:when>
														<c:otherwise>
														<!-- 댓글과 좋아요 모두 허용될 때 -->
														<img src="${ contextPath }/resources/icons/bubble.png" alt="" id="replyIcon">
															<c:if test="${ f.replyList[0].rStatus eq 'Y' }">
																<label class="replycnt_p">${ f.replyList.size() }개</label>
															</c:if>
															<c:if test="${ f.replyList[0].rStatus eq 'N' || empty f.replyList[0].rStatus }">
																<label class="replycnt_p">0개</label>
															</c:if>
														</c:otherwise>
													</c:choose>
													</c:if>
								
													<c:if test="${ f.fReplySet == 'N' && f.fLikeSet == 'N' }">
														<label class="setN">댓글과 좋아요가 금지된 포스트입니다.</label>
													</c:if>
								           		</div>
											</div>
											<div id="replyArea">
												<div id="replyList" style="display: block; height: fit-content;">
												<input type="hidden" class="rCnt" value="${ f.fReplyCnt }">
												<!-- 댓글 갯수(삭제된 댓글 갯수 포함)가 0이 아니고 댓글 상태가 'Y'인 것만 표시 -->
												<c:if test="${ f.fReplyCnt ne null && f.replyList[0].rStatus eq 'Y' }">
													<div id="replySub" style="display: block; height: 150px; overflow: auto;">
													<c:forEach var="r" items="${ f.replyList }">
														<div id="selectOne">
														<!-- 댓글 번호 -->
														<input type="hidden" class="rNum" value="${ r.rNo }">
											  				<ul id="re_list" class="list">
											  				<c:if test="${ !empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/memberProfileFiles/${ r.rWriterImg }" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
															<c:if test="${ empty r.rWriterImg }">
																<li><img src="${ contextPath }/resources/icons/pro_default.png" alt=""
																	id="reply_img">&nbsp;&nbsp;&nbsp;
																	<p id="userId"><c:out value="${ r.rWriter }" /></p></li>
															</c:if>
																<li><textarea id="replyCon" class="rCon" data-autoresize readonly required="required" placeholder="댓글을 입력해 주세요." cols=40 rows=auto disabled><c:out value="${ r.rContent }" /></textarea>
																<input type="button" id="confirmR" class="rConfirm" value="완료"></li>
																<li><p id="time"><c:out value="${ r.rModifyDate }" /></p></li>
																<li><img src="${ contextPath }/resources/icons/replyMenu.png" alt="" id="updateBtn" class="rUpBtn"></li>
															</ul>
															<!-- 내가 단 댓글 볼 때 댓글 메뉴-->
															<c:if test="${ loginUser.userId eq r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a id="rEdit" class="rEdit">댓글 수정</a></li>
																		<li><a class="rDelete">댓글 삭제</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
															<!-- 다른 사람이 단 댓글 볼 때 메뉴 -->
															<c:if test="${ loginUser.userId ne r.rWriter }">
															<div id="reply_menu" class="reply_menu">
																<div id="re_menu_list">
																	<ul>
																		<li><a href="goUserpage.do?userId=${ r.rWriter }&mNo=${ r.mNo }" class="rGoFeed">피드 가기</a></li>
																		<li><a id="rReport" class="rReport">댓글 신고</a></li>
																		<li><a id="re_close" class="rClose">취소</a></li>
																	</ul>
																</div>
															</div>
															</c:if>
														</div>
													</c:forEach>
													</div>
												</c:if>
												</div>
												<!-- 댓글 전체 허용일 경우 -->
												<c:if test="${ f.fReplySet == 'Y' || empty f.fReplySet }">
												<div id="reply">
													<input type="hidden" class="replyFeedNo" name="replyFeedNo" value="${ f.fNo }">
													<input type="text" id="textArea" class="rContent" name="textArea">
													<input type="button" id="replyBtn" class="replyUpBtn${ f.fNo } replyUpBtn" name="replyBtn" value="등록">
												</div>
												</c:if>
											</div>
										</div>
							       	</div>
							   </c:forEach>
							   </c:if>
							   </div>
	                            </div>
	                        </div>
                 	</c:otherwise>
                 </c:choose>
                	</div>
                <!-- 검색 게시글  팝업 -->
    			<div class="pop_feed">
                    <div class="feed_delete">
                        <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                    </div>
                    <div id="writer_submenu_pop"></div>
                    <!-- 다른 회원 글 볼 때 피드 메뉴 -->
                    <div class="pop_menu">
                        <div id="feed_menu_list">
                            <ul>
                            <li><a id="feed_report_btn">신고</a></li> 
                            <li><a>공유하기</a></li> 
                            <li><a>보관함</a></li> 
                            <li><a id="close">취소</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- 내가 쓴 글 볼 때 피드 메뉴 -->
                        <div class="pop_Mymenu">
                            <div id="feed_Mymenu_list">
                                <ul>
                                <li><a id="feed_menu1_btn">수정</a></li> 
                                <li><a>삭제</a></li> 
                                <li><a id="close">취소</a></li>
                                </ul>
                            </div>
                        </div>
                    <div class="feed_report">
                        <div id="feed_report_con">
                            <p>신고 사유</p>
                            <select style=>
                                <option>부적절한 게시글</option>
                                <option>욕설</option>
                                <option>광고</option>
                                <option>도배</option>
                            </select>
                            <br>
                            <input type="button" id="submit" name="submit" value="확인">
                            <button id="cancel">취소</button>
                        </div>
                    </div>
                    <div id="con">
                        <div id="feed_content_pop">
                           
                        </div>
                        <div id="replyArea">
                            <div id="replyList">
                                <ul id="re_list">
                                    <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">user01</p></li>
                                    <li><p id="replyCon">맛있겠다... 여기 어디인가요?? 대박 정보 좀....</p></li>
                                    <li><p id="time">1시간 전</p></li>
                                    <li><img src="<%=request.getContextPath()%>/resources/icons/replyMenu.png" type="button" alt="" id="updateBtn"></li>
                                </ul>
                            </div>
                            <!-- 남이 단 댓글 볼 때 댓글 메뉴 -->
                            <div class="reply_menu">
                                <div id="re_menu_list">
                                    <ul>
                                        <li><a>댓글 수정</a></li>
                                        <li><a>댓글 삭제</a></li>
                                        <li><a id="re_close">취소</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div id="reply">
                                <input type="text" id="textArea" name="textArea">
                                <input type="button" id="replyBtn" name="replyBtn" value="등록">
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
        
        <script>

        /************** 채팅 팝업 *****************/

        $(document).ready(function(){
          
            /************  팝업 메뉴 script *********** */

            $('#group_menuBtn').on("click",function(){
            	$.ajax({
            		url:"gmSelect.do",
            		data:{ userId:"${loginUser.userId}", gNo:${g.gNo}},
            		type:"post",
            		success:function(data){
            			console.log(data);
            			if(data > 0){
            				if("${g.gManager}" == "${loginUser.userId}"){
            					$('.pop_menu_master').show();
            				} else if("${g.gCreator}" != "${loginUser.userId}"){
            					$('.pop_menu_gm').show();
            				} else {
            					$('.pop_menu_master').show();
            				}
            			} else {
           		            $('.pop_menu').show();
            			}
            		}, error:function(){
            			alert("오류");
            		}
            	});
            });
            

            $('#close').on('click',function(){
                $('.pop_menu').hide();
            });
            $('#close_gm').on('click',function(){
                $('.pop_menu_gm').hide();
            });
            $('#close_master').on('click',function(){
                $('.pop_menu_master').hide();
            });

            $('#feed_report_btn').on("click",function(){
                $('.feed_report').show();
            });

            $('#cancel').on("click",function(){
                $('.feed_report').hide();
            });

            $('#updateBtn').on("click",function(){
                $('.reply_menu').show();
            });

            $('#re_close').on("click",function(){
                $('.reply_menu').hide();
            });

            
           	$('#groupJoin_btn').on("click",function(){
           		if ( "${ g.gJoinSet }" == "N"){
           			alert("멤버 가입이 불가능한 그룹입니다.");
           		} else{
           		
                  $.ajax({
                  	url:"gmCheckId.do",
                  	data:{ gNo:${g.gNo}, gmId:"${loginUser.userId}"},
              		success:function(data){
              			console.log(data);
              			if(data == 0){
              				$('.joinPop_back').show();
              			} else {
              				alert("이미 가입신청하셨습니다.");
              			}
              		},error:function(){
              			alert("오류");
              		}
                  });
           		}
              });	
           	
            $("#close_joinPop").on("click",function(){
                $('.joinPop_back').hide();
            });
        });

        $(document).ready(function(){
			
    		
			var count = $(".feed").length;
		
			for(var i = 1; i <= count; i++){
				console.log('.feed_menu'+i);
				 $('.feed_menu'+i).on("click",function(){
			         $(this).nextAll('div .g_pop_menu').show();
			         $(this).nextAll('div .g_pop_Mymenu').show();
			     });
				 
				  $('.close').on("click",function(){
			         $('.g_pop_menu').hide();
			         $('.g_pop_Mymenu').hide();
			     });
				  
				  
				  
			 	$('.feed_report_btn').on("click",function(){
			 		 $('.feed_report').show();
	            });
				 
			 	
			}
        });

         /*********** 뉴피드 / 핫피드 *************/

         $('.feedbtns').on('click', function(){
                $('.feedbtns').removeClass('on');
                $(this).addClass('on');
            });

            $("#newFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.newConBox').show();
                $('#searchFeed').hide();
                
            });

            $("#hotFeedBtn").on('click',function(){
                $('.conBox').hide();
                $('.hotConBox').show();
                $('#searchFeed').hide();
                
                
                
            });
            
            var size;
 	        var idx = idx1 = 0;
 	        var count = $(".feed").children('div#con').children('div#feed_content').children("ul#imgList").length;
 	        var ul;
 	        console.log(count);
 	        var liCount;
 	        
 			for (var i = 1; i <= count; i++){
 				ul = $("#feed"+i).children('div#con').children('div#feed_content').children("ul#imgList").children("li").length;
 				
 				console.log(ul);
 				
 				if( ul > 1){
 	        		$('#nextBtn'+i).css("display","block");
 	        		$('#prevBtn'+i).css({"display":"block"});
 	        	}
 				
 				
 				$('#prevBtn'+i).on("click",function(){
     	  			size = $(this).nextAll().children('li').length;
     	  			console.log(size);
     	  			
     	  			if(size > 1){
     	  				idx1 = (idx-1) % size;
     	  				if(idx1 < 0)
     	  					idx1 = size - 1;
     	  					
     	  					$(this).nextAll().children('li:hidden').css("left","-633px");
     	  					$(this).nextAll().children('li:eq('+idx+')').animate({left:"+=633px"},500,function(){
     	  						$(this).css("display","none").css("left","-633px");
     	  					});
     	  					$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"+=633px"},500);
     	  					idx = idx1;
     	  			}
     	  		});
 				
 				$('#nextBtn'+i).on("click",function(){
     	  			size = $(this).nextAll().children('li').length;
     	  			console.log(size);
     	  			
     	  			if( size > 1){
     	  				idx1 = (idx + 1) % size;
     	  				$(this).nextAll().children('li:hidden').css("left","633px");
     	  				$(this).nextAll().children('li:eq('+idx+')').animate({left:"-=633px"},500, function(){
     	  					$(this).css("display","none").css("left","633px");
     	  				});
     	  				$(this).nextAll().children('li:eq('+idx1+')').css("display","block").animate({left:"-=633px"},500);
     	  				idx = idx1;
     	  			}
     	  				
     	  			
     	  		});
 			
 				
 			}
            
            
            /**************** 그룹 신고 관련*******************/ 
    		$(document).on('click',"#report-submit",function(){
    			
    			if($("#reportContent").val() == ""){
    				alert('신고 사유를 입력해 주세요.')
    			}else{
    				
    				$.ajax({
    					url:'/spring/report.do',
    					data:{
    						reportType : $("#reportType").val(),
    						feedType : "group",
    						content : $("#reportContent").val()
    					},
    					success: function(){
    						$(".feed_report").css('display','none');
    						$(".selectRtype").css("display","inline-block");
    			      		$(".sendreport").css("display","none");
    			      		$("#reportContent").val('')
    						alert('신고완료');
    					},error:function(){
    						alert('신고 실패!');
    					}
    				});
    				
    			};
    		});
          	 
          	$("#cancel2").on('click',function(){
          		$(".feed_report").css('display','none');
    			$(".selectRtype").css("display","inline-block");
          		$(".sendreport").css("display","none");
          		$("#reportContent").val("");
          	})
          	
          	$("#selectRtype").on('click',function(){
          		$(".selectRtype").css("display","none");
          		$(".sendreport").css("display","block");
          	}); 
          	
          	
          	
          	$('.rUpBtn').on("click", function(event){
//      	  	  var btn = $(event.target).parents("div#replyArea").find("div#reply_menu");
      	      var btn = $(event.target).parent('li').parent('ul').next('div#reply_menu')
      		  $(btn).show();
      	    });
      	    $('.rClose').on("click", function(){
      	        $('.reply_menu').hide();
      	    });
      	    $('.deleteMyPost').on('click', function () {
      	    	confirm('이 포스트를 정말 삭제하시겠습니까?');
      	    });
      	    $('.rEdit').on("click", function(e) {
      			var repCon = $(this.parentElement).parents("div#selectOne").find("textarea#replyCon.rCon");
      			var repBtn = $(this.parentElement).parents("div#selectOne").find("input#confirmR");

      			repCon.css('border', '1px solid #555555');
      	  	  	repCon.removeAttr('disabled');
      	  	  	repCon.removeAttr('readonly');
      	  	  	repBtn.css('display', 'block');
      	  	  	$('.reply_menu').hide();
      	    });
      	          
      	    // text-area resize
      		$.each(jQuery('textarea[data-autoresize]'), function() {
      			var offset = this.offsetHeight - this.clientHeight;
      			var resizeTextarea = function(el) {
      				$(el).css('height', 'auto').css('height', el.scrollHeight + offset);
      			};
      			$(this).on('keyup input', function() {
      			 resizeTextarea(this);
      			}).removeAttr('data-autoresize');
      		});
      		
          	
          	
          	
 			
 			// 알림 기능
 			$("#joinBtn").on('click',function test(){
 				console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
 	  			sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');   
 			});
 			
 			
 	/*그룸내 검색*/
 	$("#groupSearchBtn").on('click',function(){
 		var gsearch = $('#groupSearch').val();
   		var sign = gsearch.charAt(0);		
		var keyword = gsearch.substr(1);	
		var gNo = ${ g.gNo };					
		
		if(gsearch.length == 0){
			alert('검색어를 입력해주세요');			
		}else if(sign == " "){
			alert('검색어 첫글자를 띄어 쓸 수 없습니다');		
		}else{
			$.ajax({
				url:'/spring/gSearch.do',
				dataType:'json',
				type:'post',
				data:{gNo: gNo,
					  gsearch:gsearch
					  },
		        success:function(data){
					if(data.flist != null){
						$('.conBox').hide();
	    				var input="";
	    				var j = 0;
	    				for(var i=0; i < data.flist.length; i++){
	    						if(data.flist[i].thumbnail != null){
			   						input += "<div class='postbox "+i+"' id='"+data.flist[i].fno+"' name='postbox'>";	
				    				input += "<img src='/spring/resources/pUploadFiles/"+data.flist[i].thumbnail+"'>";	
				    				input += "</div>";
			    				}else{
				    				input += "<div class='postbox "+i+"' id='"+data.flist[i].fno+"' name='postbox'>";	
				    				input += "<text>"+data.flist[i].fcontent+"</text>";	
				    				input += "</div>";
	    						}	
	    				}
	    				$("#searchFeed").append(input);
	                    $("#searchFeed").html(input);
						$('#searchFeed').show();

					}else{
						alert(data.msg);
					}
	            },
	             error:function(request,jqXHR,exception){
	               var msg="";
	               if(request.status == 0){
	                  msg = 'Not Connect. \n Verify Network.';
	               } else if(request.status == 404){
	                  msg = 'Requested page not fount [404]';
	               } else if(request.status == 500){
	                  msg = 'Internal Server Error [500]';
	               } else if(request.status == 'parsererror'){
	                  msg = 'Requested JSON parse failed';
	               } else if(exception == 'timeout'){
	                  msg = 'Time out error';
	               } else if(exception == 'abort'){
	                  msg = 'Ajax request aborted';
	               } else {
	                  msg = 'Error. \n' + jqXHR.responseText;
	               }
	               alert(msg);
	            } 
				
			});
		}
 	});
	/*그룹 내 팝업*/
 	$(document).on('click','.postbox',function(){
 		console.log($(this).attr("id") );
 		$.ajax({
 			url:'feedPop.do',
 			dataType:'json',
 			type:'post',
 		
 			data:{ fno : $(this).attr("id") },
 			async:false,
 	        success:function(data){
 				console.log(data);
 	        	var input_writer ="";
                var feed_content ="";
 	        	input_writer += "<img src='/spring/resources/memberProfileFiles/"+data.mImage+"' id='feed_profile_img'>";
 	        	input_writer += "<div id='user_time'>";
 	        	input_writer += "<p id='feed_id'>"+data.fwriter+"</p>";
 	        	input_writer += "<h6>1시간 전</h6>";
 	        	input_writer += "</div>";	
 	        	input_writer +="<img src='/spring/resources/icons/feed_menu.png' id='feed_menu'>" ;
 	        	$("#writer_submenu_pop").append(input_writer);
                $("#writer_submenu_pop").html(input_writer);
                //나중에 for문으로 돌려서 여러장 볼 수 있어야 함
                if(data.plist == ""){
                }else{
                feed_content += "<img src='/spring/resources/pUploadFiles/"+data.plist[0]+"' alt='' id='input_img'>";                	
                }
                feed_content += "<div id='heart_reply'>";
                feed_content += "<img src='/spring/resources/icons/heart.png' type='button' id='likeIcon'>";
                feed_content += "<img src='/spring/resources/icons/bubble.png' type='button' id='replyIcon'>";
                feed_content += "</div>";  
                feed_content += "<p id='text'>"+data.fcontent+"</p>";

                $("#feed_content_pop").append(feed_content);
                $("#feed_content_pop").html(feed_content);
                
 	        	$('.pop_feed').show();
 	        	
 	        },error:function(request,jqXHR,exception){
 	               var msg="";
 	               if(request.status == 0){
 	                  msg = 'Not Connect. \n Verify Network.';
 	               } else if(request.status == 404){
 	                  msg = 'Requested page not fount [404]';
 	               } else if(request.status == 500){
 	                  msg = 'Internal Server Error [500]';
 	               } else if(request.status == 'parsererror'){
 	                  msg = 'Requested JSON parse failed';
 	               } else if(exception == 'timeout'){
 	                  msg = 'Time out error';
 	               } else if(exception == 'abort'){
 	                  msg = 'Ajax request aborted';
 	               } else {
 	                  msg = 'Error. \n' + jqXHR.responseText;
 	               }
 	               alert(msg);
 	            } 
 				
 			});
 	});
 	
    $('.feed_delete').click(function() {
        $(".pop_feed").hide();
    });
 	
    $(function(){
		
		$('.share_feed').on("click",function(){
			var fNo = $(this).parents().children('.fn').val();
			console.log(fNo);
			
			$.ajax({
				url:"shareFeed.do",
				data:{ fNo:fNo, mNo:${ loginUser.mNo} },
				type:"post",
				success:function(data){
					if( data > 0){
						alert("게시글을 공유하였습니다.");
						$('.pop_menu').hide();
					}
				},error:function(){
					alert("공유 실패");
				}
			});
		});
	});
	
	$(function(){
		$('.goStorage').on("click",function(){
			var mNo = ${ loginUser.mNo};
			var fNo = $(this).parents().children('.fn').val();
			console.log(mNo);
			$.ajax({
				url:"selectStorage.do",
				data:{ mNo:mNo},
				dataType:"json",
				success:function(data){
					$('.pop_menu').hide();
			         $('.pop_Mymenu').hide();
					$divAll = $('.storagePop');
					$divAll.html("");
					
						var $input = $('<input type="hidden" id="in_fno" class="in_fno" value="'+fNo+'">')
						var $div = $('<div class="storagePop_menu" id="storagePop_menu" style="background: white; width: 320px; margin: auto; height: 183px; border-radius: 15px; margin-top:300px;">');
						var $p = $('<p id="sbText" style="text-align:center; padding:20px 0 20px 0; border-bottom:1px solid #ccc; color:#555555; font-weight:600">').text("보관함");
						var $p2 = $('<p id="sbText2" style="color:#555555; font-size:14px; text-align:center; padding:20px 0 20px 0">').text("보관함을 선택해주세요.")
						var $select = $('<select id="sbSel" style="width:140px; height:32px; border-radius:10px; margin:0 10px 0 40px">');
						for(var i=0; i < data.length; i++){
							$select.append('<option id="op" value="'+data[i].sbNo+'">'+data[i].sbName+"</option>");
						}
						var $button = $('<input type="button" id="insertStorage" class="insertStorage" value="확인" style="width:80px; height:32px; border:0; border-radius:10px; background:#daf4ed">');	
						
						
						$div.append($p);
						$div.append($p2);
						$div.append($select);
						$div.append($button);
						$divAll.append($input);
						$divAll.append($div);
					
					$('.storagePop').show();
				}
			});
			
			$(document).on("click",".insertStorage",function(){

				
				var fNo = $(this).parents().children('.in_fno').val();
				console.log(fNo);
				var mNo = ${ loginUser.mNo};
				var sbNo = $(this).prev('select').children('option:selected').val();
				var sbName = $(this).prev('select').children('option:selected').text();
				console.log(sbNo);
				console.log(sbName);
				$.ajax({
					url:"insertStorage.do",
					data:{ fNo:fNo,mNo:mNo,sbNo:sbNo,sbName:sbName },
					type:"post",
					success:function(data){
						if(data > 0){
							alert("게시글을 보관함에 넣었습니다.");
						}else if(data ==0){
							alert("게시글이 이미 보관되어있습니다.");
						}
						$('.storagePop').hide();
						$('.pop_menu').hide();
					},error:function(){
						alert("보관함에 이미 게시글이 있거나, 보관함에 넣기 실패하였습니다.");
					}
				});
			});
		});
	})

 	/**************** 댓글 등록 ****************/
			$(function() {
				
				$(".replyUpBtn").on("click", function(event) {
					var rContent = event.target.parentElement.children[1].value;
					var rfNo = event.target.parentElement.children[0].value;
					var rWriter = "${ loginUser.userId }";
					var gNo = ${ g.gNo };
					
					$.ajax({
						url: "addReply.do",
						data: {
							rContent: rContent,
							rfNo: rfNo,
							rWriter: rWriter
						},
						type: "post",
						success: function(data) {	// 성공 시: success, 실패 시: fail
							if(data == "success") {
								$(rContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
								location.href="gdetail.do?gNo="+gNo;
							}
						}, error: function() {
							console.log("전송 실패");
						}
					});
					
					var ok = confirm("댓글을 등록하시겠습니까?");
		         	console.log(ok);
		         	if(ok){
		         	console.log(오케이);
		        	sendAlram("상관없음",fWriter,"reply",rfNo); 
		        	console.log("상관없음",fWriter,"reply",rfNo+"테스트");
//		        	alert('stop');
		         }
			});

			// 댓글 수정 시 완료 버튼
		 	$('.rConfirm').on("click", function(e) {
		/* 		var rContent = e.target.parentElement.children[1].value; */
				var rNo = e.target.parentElement.parentElement.previousElementSibling.value;
//				var rNo = e.target.parentElement.parentElement.parentElement.parentElement.previousElementSibling.children[0].children[0].value;
				var rWriter = "${ loginUser.userId }";
				
				var replyContent = e.target.previousElementSibling.value;
//				var replyContent = e.target.parentElement.parentElement.parentElement.previousSibling.parentElement.children[0].children[0].children[1].innerText;
//				var replyDiv = e.target.parentElement.parentElement.parentElement.parentElement;
				
					$.ajax({
						url: "editReply.do",
						data: {
							rContent: replyContent,
							rNo: rNo,
							rWriter: rWriter
						},
						type: "post",
						success: function(data) {	// 성공 시: success, 실패 시: fail
							console.log(data);
		 					if(data == "success") {
//								$(replyContent).val("");	// 등록 시에 사용한 댓글 내용 초기화
//								location.href="home.do?userId=" + rWriter;
								location.reload();
							}
						}, error: function() {
							console.log("전송 실패");
						}
					});
					
				confirm("댓글을 수정하시겠습니까?");
			});
			
			// 댓글 삭제 시
		 	$('.rDelete').on("click", function(e) {
				var rNo = $(this.parentElement).parents("div#selectOne").find("input.rNum").val();
				var ul = $(this.parentElement).parents("div#selectOne").find("ul#re_list.list");
				var rWriter = "${ loginUser.userId }";
				var none = $(this.parentElement).parents("div#replySub").children.length;
				
				$.ajax({
					url: "deleteReply.do",
					data: {rNo: rNo},
					type: "post",
					success: function(data) {	// 성공 시: success, 실패 시: fail
//						console.log(data);
		  				if(data == "success") {
//							$(ul).css('display', 'none');
							$('.rNum').css('display', 'none');
//							location.href="home.do?userId=" + rWriter;
							location.reload();
						}
					}, error: function() {
						console.log("전송 실패");
					}
				});
				
				// 마지막 댓글 삭제 후 div 안에 댓글이 모두 지워지면
				if(none == 0) {
					$(this.parentElement).parents("div#replySub").css('display', 'none');
				}
				
				confirm("댓글을 삭제하시겠습니까?");
			});
			
			});
			
		 	// 좋아요 알람
			$(".likeIcon").on('click',function(e){
				console.log("likeicon 클릭");
				console.log($(e.target).parent().children('.likeIcon')[0].id);
				var toId = $(e.target).parent().children('.toId').val();
				var toNo = $(e.target).parent().children('.toNo').val();   
				var fromId = '${loginUser.userId}';
				
				if($(e.target).parent().children('.likeIcon')[0].id == 'likeIcon'){
					$(e.target).attr('src','/spring/resources/icons/heart_red.png');
					$(e.target).attr('id','liked');				
					sendAlram("상관없음",toId,"like",toNo);
					var test = $("#"+e.target.name).text();
					test *= 1;
					test = test + 1;
					$("#"+e.target.name).text(test)
					
					$.ajax({
						url: "likeCount.do",
						data : {fNo : toNo,
								type : 'up',
								userId : 'null'},
						success : function(data){
							console.log(data + "좋아요 카운트 up 성공");
						}
					});
				}else{
					$.ajax({
						url: "likeCount.do",
						data : {fNo : toNo,
								type : 'down',
								userId : fromId},
						success : function(data){
							console.log(data + "좋아요 카운트 down 성공");
						}
					});
					$(e.target).attr('src','/spring/resources/icons/heart.png');
					$(e.target).attr('id','likeIcon');
					var test = $("#"+e.target.name).text();
					test *= 1;
					test = test - 1;
					$("#"+e.target.name).text(test)
				}
				
			});
				
	/* 스크롤 맨위로 올리기 */
	$(function(){
		$("#feedArea").scroll(function(){
			var st = $("#feedArea").scrollTop();
			if(st > 0) {
				$("#topScrollBox").show();
			} else if(st == 0) {
				$("#topScrollBox").hide();
			}
		});
		
		$("#topScrollBtn").on("click",function(){
			$("#feedArea").animate( { scrollTop : 0 }, 400 );
			return false;
		});
	});
    </script>
</body>
</html>