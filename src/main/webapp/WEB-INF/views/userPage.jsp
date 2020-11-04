<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_Main.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/chat.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/pop_menu.css">
   <style>
   		#myPage_feed{
   			width:640px;
   		}
   		.feedPost{
   			border-bottom:2px solid #47c6a3;
   			transition:0.5s all;
   		}
   		#interests{
	    font-size:smaller;
	    color:grey;
	    }
	    #myPage_introduction{
	    padding-top: 20px;
	    }
	    #mp_profile_info>h5{
	    color:#555555;
		margin: 0px;
		height:15px;
		margin-left:20px;
		font-weight:500;
	    }
	    #mp_profile_info>h3{
	    margin-bottom:5px;
	    }
	    #mp_profile_follow{
	    margin-top:10px;
	    }
	    #self-introduction{
	    margin:0 40px 30px 30px;
	    }
	    .follow_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
    	background-color: rgba(0,0,0,0.5);}
    	.following_wrap{ display: none; width: 100%; height: 100%; position: fixed; top: 0; left: 0; z-index: 1; background-color: rgb(0,0,0); 
   		background-color: rgba(0,0,0,0.5);}
    	.follow_detail{ background: white; border-radius: 15px; -ms-overflow-style: none; width: 400px; height: 500px; position: fixed; top: 20%; left: 42%;}
    	.follow_title{ height: 60px; border-bottom: 1px solid #e5e5e5; text-align: center; }
    	.follow_title>p{ padding:20px; color:#555555; font-weight:600; }
    	.follow_list{ height: 440px; overflow-y: scroll; }
    	.follow_list>ul{ 
		    margin: 30px;
		    text-align: center;
		    list-style: none;
		    padding: unset;
    	 }
    	.follow_list>ul>li{ 
		    height: 40px;
		    margin-bottom: 10px;
    	 }
		.follow_list::-webkit-scrollbar{display: none;}
		.close_popup>img{ width:20px; height: 20px; margin: 10px; float: right; }
   </style>
</head>
<body>
   <c:import url="common/menubar.jsp"/>
            
        <!-- 피드 부분 -->
            <div id="feedArea">
                <div id="feed">

                <!-- 프로필 시작 -->
                    <div id="myPage_profile">
                        <div id="mp_profile_img">
                           <c:if test="${ !empty memberInfo.mRenameImage }">
                           	<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ memberInfo.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                            <c:if test="${ empty memberInfo.mRenameImage }">
                            <img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                        </div>
                        <div id="mp_profile_info">
                            <h3>${ memberInfo.userId }</h3>
                            <h5>${ memberInfo.userName }</h5>
                        </div>
                        <div id="mp_profile_edit">
                        <input type="hidden" id="mNo" value="${ loginUser.mNo }"/>
                        <input type="hidden" id="follow" value="${ memberInfo.mNo }"/>
                        <input type="hidden" id="followYN" value="${followYN}"/>
                       
                        <c:choose>
                        	<c:when test="${followYN ne 'N'}">
                        		<input type="button" id="followCancle_btn" name="followCancle_btn" value="팔로우 취소">
                        	</c:when>
                        	<c:otherwise>
                        		<input type="button" id="follow_btn" name="follow_btn" value="팔로우">                        	
                        	</c:otherwise>
                        </c:choose>          
                            <img src="<%=request.getContextPath()%>/resources/images/dot.png" type="button" id="details_btn">
                        </div>

                    <!-- 다른 사람이 내 피드를 방문했을 때 -->
                       <div class="myFeed_popup_others">
                            <div id="myFeed_others_list">
                                <ul>
                                <li><a id="myFeed_report_btn">신고</a></li> 
                                <li><a id="myFeed_block_btn">차단하기</a></li> 
                                <li><a id="myFeed_message_btn">메세지</a></li> 
                                <li><a id="close">취소</a></li>
                                </ul>
                            </div>
                        </div>

                    <!-- 신고했을 경우 -->
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

                    <!-- 차단했을 경우 -->
                        <div class="feed_block">
                            <div id="feed_block_pop">
                                <input type="button" id="block_pop" value="user01 님을 차단하였습니다.">
                            </div>
                        </div>
                        <div id="mp_profile_follow">
                            <ul id="follow_post">
                                <li>게시물</li>
                                <li class="post_num">${ feedCnt }</li>
                            </ul>
                            <a style="cursor:pointer;">
                            	<ul id="follow_follower">
                                <li>팔로워</li>
                                <li class="follower_num">${ followInfo.followers }</li>
                            </ul>
                            </a>
                            <a style="cursor:pointer;">
                            <ul id="follow_following">
                                <li>팔로잉</li>
                                <li class="following_num">${ followInfo.follows }</li>
                            </ul>
                            </a>
                        </div>
                    </div>
                    
                    <!-- 팔로워,팔로우 리스트 -->
                     <div class="follow_wrap">
                    	<div class="close_popup">
                            <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                    	</div>
                    	<div class="follow_detail">
	                    	<div class="follow_title">
	                    		<p>팔로워</p>
	                    	</div>
	                    	<div class="follow_list">
		                    	<c:forEach var="followerList" items="${ followerList }">
	                    		<ul>
	                    		   <c:url var="goUserPage" value="goUserpage.do">
	                               		<c:param name="mNo" value="${ followerList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followerList.mNo }">
	                    		   		<li><a href="goUserpage.do?userId=${ followerList.userId }&mNo=${ loginUser.mNo }">${ followerList.userId }</a></li>
                                   </c:if>
                                   <c:if test="${ empty followerList.mNo }">
	                    		   		<li>팔로워가 없습니다. </li>
                                   </c:if>
	                    		</ul>
		                    	</c:forEach>
	                    	</div>
                    	</div>
                    </div>
                    <div class="following_wrap">
                    	<div class="close_popup">
                            <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                    	</div>
                    	<div class="follow_detail">
	                    	<div class="follow_title">
	                    		<p>팔로우</p>
	                    	</div>
	                    	<div class="follow_list">
		                    	<c:forEach var="followingList" items="${ followingList }">
	                    		<ul>
	                    		   <c:url var="goMypage" value="goMypage.do">
	                               		<c:param name="mNo" value="${ followingList.mNo }"/>
	                               </c:url>
                                   <c:if test="${ !empty followingList.mNo }">
	                    		   		<li><a href="goUserpage.do?userId=${ followingList.userId }&mNo=${ loginUser.mNo }">${ followingList.userId }</a></li>
                                   </c:if>
                                   <c:if test="${ empty followingList.mNo }">
	                    		   		<li>팔로우가 없습니다. </li>
                                   </c:if>
	                    		</ul>
		                    	</c:forEach>
	                    	</div>
                    	</div>
                    </div>

                <!-- 소개 부분 -->
                    <div id="myPage_introduction">
                        <div id="self-introduction">
                            ${ memberInfo.mIntro }
                        </div>
                        <div id="interests">
                             ${ memberInfo.interestes }
                        </div>
                    </div>
                    
            <!-- 내가 올린 피드 목록 -->
                <div id="myPage_feedList">
                    <table id="myPage_feed">
                        <tr>
                            <th colspan="3"><div class="feedPost">게시글</div></th>
                        </tr>

                    <!-- 게시글 -->
                        <%! int i = 0; %>
                        <c:forEach var="feedlist" items="${ feedList }">
                        <% if (i%3==0){ %>
                        <tr class="post">
                        <%} %>
                              <c:choose>
                                 <c:when test="${!empty feedlist.fRenameFile }">
                                     <td class="postbox" name="postbox"><img src="<%=request.getContextPath()%>/resources/feedUpFiles/${ feedlist.fRenameFile }" type="button" id="pb1"></td>
                                 </c:when>
                                 <c:otherwise>
                                     <td class="postbox" name="postbox">
                                         <div type="button" id="pb2">
                                             <text>${ feedlist.fContent }</text>
                                             <text class="hashtag">#피자 #치킨 #맥주 #콜라 #피자 #치킨 #맥주 #콜라 #피자 #치...</text>
                                         </div>
                                     </td>
                                 </c:otherwise>
                              </c:choose>
                          <% if (i%3==2){ %>
	                      </tr>
	                      <%} i++; %>
                          </c:forEach>
                        
                    <!-- 포스트박스 클릭 시 -->
                        <div class="pop_feed">
                            <div class="feed_delete">
                                <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                            </div>
                            <div id="writer_submenu">
                                <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
                                <div id="user_time">
                                    <p id="feed_id">user01</p>
                                    <h6>1시간 전</h6>
                                </div>  
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="feed_menu">
                            </div>
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
                                <div id="feed_content">
                                    <img src="<%=request.getContextPath()%>/resources/images/IMG_7572.JPG" alt="" id="input_img">
                                    <div id="heart_reply">
                                        <img src="<%=request.getContextPath()%>/resources/icons/heart.png" type="button" alt="" id="likeIcon">
                                        <img src="<%=request.getContextPath()%>/resources/icons/bubble.png" type="button" alt="" id="replyIcon">
                                    </div>
                                    <p id="text">맛있게 먹었던 피짜~~~!</p>
                                    <ul id="tag">
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                        <li>#피자</li>
                                        <li>#강남역</li>
                                        <li>#피자맛집</li>
                                    </ul>
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

                    <!-- 포스트박스 클릭 시2 -->
                        <div class="pop_feed2">
                            <div class="feed_delete">
                                <img src="<%=request.getContextPath()%>/resources/icons/close_white.png" type="button">
                            </div>
                            <div id="writer_submenu">
                                <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="feed_profile_img">
                                <div id="user_time">
                                    <p id="feed_id">user01</p>
                                    <h6>1시간 전</h6>
                                </div>  
                                <img src="<%=request.getContextPath()%>/resources/icons/feed_menu.png" alt="" id="feed_menu">
                            </div>
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
                                <div id="feed_content">
                                    <!-- <img src="" alt="" id="input_img"> -->
                                    <div id="heart_reply">
                                        <img src="<%=request.getContextPath()%>/resources/icons/heart.png" type="button" alt="" id="likeIcon">
                                        <img src="<%=request.getContextPath()%>/resources/icons/bubble.png" type="button" alt="" id="replyIcon">
                                    </div>
                                    <p id="text">피자 먹고 싶당 치킨 먹고 싶당</p>
                                    <ul id="tag">
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                        <li>#피자</li>
                                        <li>#치킨</li>
                                        <li>#맥주</li>
                                        <li>#콜라</li>
                                    </ul>
                                </div>
                                <div id="replyArea">
                                    <div id="replyList">
                                        <ul id="re_list">
                                            <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">pizza11</p></li>
                                            <li><p id="replyCon">당장 나와</p></li>
                                            <li><p id="time">1분 전</p></li>
                                            <li><img src="<%=request.getContextPath()%>/resources/icons/replyMenu.png" type="button" alt="" id="updateBtn"></li>
                                        </ul>
                                        <ul id="re_list">
                                            <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="" id="reply_img">&nbsp;&nbsp;&nbsp;<p id="userId">honeybee</p></li>
                                            <li><p id="replyCon">다이어트 한다며......</p></li>
                                            <li><p id="time">39분 전</p></li>
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
                    </table>
                </div>
            </div>
        </div>


    <script>
    	
		/* 팔로우,팔로워 클릭 시 */
	    $('#follow_following').click(function() {
	        $('.following_wrap').show();
	    });
	    $('#follow_follower').click(function() {
	        $('.follow_wrap').show();
	    });
	
	    $('.close_popup').click(function() {
	        $('.follow_wrap').hide();
	        $('.following_wrap').hide();
	    });

        $('div[type = button]').css({'cursor' : 'pointer'});
        $('input[type = button]').css({'cursor' : 'pointer'});
        $('img[type = button]').css({'cursor' : 'pointer'});


        $(document).ready(function(){
            $('#chat_icon').click(function(){
                var state = $(".chat").css('display');
                if(state=='none'){
                    $('.chat').show();
                }else{
                    $('.chat').hide();
                }
            });
        });

       $('.tab_menu_btn').on('click',function(){
            $('.tab_menu_btn').removeClass('on');
            $(this).addClass('on')
        });

        $('.tab_menu_btn1').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box1').show();
        });

        $('.tab_menu_btn2').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box2').show();
        });

        $(document).ready(function(){
            $('#detailInfo').click(function(){
                $(".myAccount").animate({width:"toggle"},250);
            });
        });

        $('.MyTab_tab').on("click",function(){
            $('.MyTab_tab').removeClass('on');
            $(this).addClass('on')
        });

        $('.MyTab_tab1').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box1').show();
        });

        $('.MyTab_tab2').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box2').show();
        });

        
        /************ 팔로우 언팔로우 script ************/

        $('#follow_btn').click(function() {
            
            var mNo = $('#mNo').val();
            var follow = $('#follow').val();
            
            $.ajax({
 	       		 url: 'insertFollow.do',
 	      		  	 type: 'post',
 	      		   	 data: {follow:follow,mNo:mNo},
 	      		   	 datatype:"text",
 	      		   	 success: function(data){
 		      		   	if(data == 'success'){
 		      		 	  	window.location.reload();
 		  		   		 }else{
 		  		   			alert("팔로우 실패했습니다.");
 		  		   		 }
 	      		   	 },error: function(error){
 	      		   		 alert(error+"팔로우 에러");
 	      		   	 }
 	       	 });
        });

        $('#followCancle_btn').click(function() {
           
            var mNo = $('#mNo').val();
            var follow = $('#follow').val();
            
            $.ajax({
 	       		 url: 'deleteFollow.do',
 	      		  	 type: 'post',
 	      		   	 data: {follow:follow,mNo:mNo},
 	      		   	 datatype:"text",
 	      		   	 success: function(data){
 		      		   	if(data == 'success'){
 		      		   		window.location.reload();
 		  		   		 }else{
 		  		   			alert("팔로우 취소 실패했습니다.");
 		  		   		 }
 	      		   	 },error: function(error){
 	      		   		 alert(error+"팔로우 에러");
 	      		   	 }
 	       	 });
        });


        /************ 게시글, 보관함, 내 그룹 전환 시 script ************/

        $('.feedPost_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').show();
            $('.storagebox').hide();
            $('.group').hide();
        });

        $('.feedStorageBox_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').hide();
            $('.storagebox').show();
            $('.group').hide();
        });

        $('.feedMyGroup_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.post').hide();
            $('.storagebox').hide();
            $('.group').show();
        });



        /********* 보관함 수정 및 삭제 script ************/
        
         $('.storageBox_subBtn1').click(function() {
            var mNo = $('#mNo').val();
         $.ajax({
            url:"insertBox.do",
            dataType:"json",
            data:{mNo: mNo},
            type:"post",
            success:function(data){
               if(data.storageBoxList != null && data.storageBoxList != 'undefined'){
               alert("되냐");
                  /* $('.folder_default').show();
                     $('.folder_correct').hide();
                     $('.folder_delete').hide();

                     $('.storageBox_subBtn3').hide();
                     $('.storageBox_subBtn4').show(); */
                     
                     var input="";
                     input += "<td class='storageBox_folder'>";<%-- <img src="<%=request.getContextPath()%>/resources/icons/folder.png" type='button'>"; --%>
                     input += "<table>";
                     input += "<tr class='storagebox'>";
                        input += "<td class='folder_default' align='center'>";
                      input += "<label class='current_folder'>"+data.storageBoxList.sbName+"</label>";
                      input += "</td>";
                      input += "<td class='folder_correct' align='center'>";
                      input += "<input type='text' id='rename_folder' class='rename_folder' value='"+data.storageBoxList.sbName+"' maxlength='10'>";
                      input += "</td>";
                      input += "<td class='folder_delete' align='center' id='folder_delete'>";
                      input += "<input type='checkbox' id='delete_folder'>";
                      input += "<label for='delete_folder1' class='dltfolder'>"+data.storageBoxList.sbName+"</label>";
                      input += "</td>";
                      input += "</tr>";
                      input += "</table>";
                     input += "</td>";
                     
                     $("#box").append(input);
                    /*  $("#box").html(input); */

               }else if(data.msg != null && data.msg != 'undefined'){
                  alert(data.msg);
               }else{
                  alert("시스템 오류입니다.");
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
           
        });
        
        $('#close_btn').on('click',function(){
           $('.myFeed_popup_myEdit').hide();
         });

        $('.storageBox_subBtn2').click(function() {
            $('.folder_default').hide();
            $('.folder_correct').show();
            $('.folder_delete').hide();

            $('.storageBox_subBtn3').hide();
            $('.storageBox_subBtn4').show();
        });

        $('.storageBox_subBtn3').click(function() {
               var rename_folderId = 
               $.ajax({
                  url:"updateBox.do",
                  data:{
                     id: rename_folder0   
                  },
                  type:"post",
                  success:function(data){
                     console.log(data);
                        $('.folder_default').hide();
                        $('.folder_correct').hide();
                        $('.folder_delete').show();

                        $('.storageBox_subBtn2').hide();
                        $('.storageBox_subBtn4').show();
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
            
            
        });

        $('.storageBox_subBtn4').click(function() {
            $('.folder_default').show();
            $('.folder_correct').hide();
            $('.folder_delete').hide();

            $('.storageBox_subBtn4').hide();
            $('.storageBox_subBtn2').show();
            $('.storageBox_subBtn3').show();
        });


        /************ 포스트 박스 클릭 시 script ************/

        $('#pb1').click(function() {
            $(".pop_feed").show();
        });

        $('#pb2').mouseover(function() {
            $(this).css({'background' : '#daf4eda1'});
        }).mouseleave(function() {
            $(this).css({'background' : 'none'});
        }).click(function() {
            $(".pop_feed2").show();
        });

        $('.feed_delete').click(function() {
            $(".pop_feed2").hide();
            $(".pop_feed").hide();
        });



        /************* 팝업 메뉴 script *************/

        $('#details_btn').on("click", function(){
            $('.myFeed_popup_others').show();
        });

        $('#close').on('click', function(){
            $('.myFeed_popup_others').hide();
        });

        $('#myFeed_report_btn').on("click", function(){
            $('.feed_report').show();
        });

        $('#cancel').on("click", function(){
            $('.feed_report').hide();
        });

        $('#myFeed_block_btn').on('click', function(){
            $('.feed_block').show();
        });

        $('#block_pop').on("click", function(){
            $('.feed_block').hide();
            $('.myFeed_popup_others').hide();
        });

        $('#profile_edit_btn').on("click", function(){
            $('.myFeed_popup_myEdit').show();
        });

        $('#close').on("click", function(){
            $('.myFeed_popup_myEdit').hide();
        });

        $('#updateBtn').on("click", function(){
            $('.reply_menu').show();
        });

        $('#re_close').on("click", function(){
            $('.reply_menu').hide();
        });

    </script>
</body>
</html>