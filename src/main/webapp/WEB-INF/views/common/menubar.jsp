<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.kh.spring.member.model.vo.Member"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="resources/css/common.css">
<link rel="stylesheet" href="resources/css/chat.css">
<link rel="stylesheet" href="resources/css/alarmPop.css">
<link rel="stylesheet" href="resources/css/user_alarmPop.css">
<link rel="stylesheet" href="resources/css/myAccount.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<style>
	a{text-decoration:none;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	 <div id="header">
            <img src="resources/icons/logo.png" alt="logo" id="logo" name="logo">
     </div>
     <div class="content">
     	<div id="chat" name="chat" class="chat">
            <div class="tab_menu">
                <button class="tab_menu_btn1 tab_menu_btn on">내 채팅</button>
                <button class="tab_menu_btn2 tab_menu_btn">그룹</button>
                <div class="tab_box_container">
                    <div class="tab_box1 tab_box on">
                        <div id="search_f">
                            <input type="search" id="f_list" name="f_list" placeholder="친구 검색">
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                        </div>
                        <div id="mcList">
                            <!-- 채팅목록 공간 냅둬주세요 -->
                        </div>
                    </div>
                    <div class="tab_box2 tab_box">
                        <div id="search_g">
                            <input type="search" id="g_list" name="g_list" placeholder="그룹 검색">
                            <input type="button" id="searchBtn" name="searchBtn" value="검색">
                        </div>
                        <div id="myGroupChat_list">
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="chat_room" name="chat_room" class="chat_room">
            <div class="chatRoomContainer">
                <div id="chat_top">
                    <button id="goList"><img src="${ contextPath }/resources/icons/goList.png"></button>
                    <p id="chatUser"></p>
                </div>
                <div id="chatArea">
                   	<!-- 채팅방 안 여기도 -->
                </div>
                <div id="input_chat">
                    <input type="text" id="inputArea" name="inputArea">
                    <input type="submit" id="send" name="send" value="보내기"> 
                </div>
            </div>
        </div>
	     <div class="search_userInfo">
	           <div id="searchbar">
	           	   <form action="search.do" method="post">
		               <input type="search" id="allSearch" name="allSearch">
		               <input type="submit" id="allSearchBtn" name="allSearchBtn" value="검색">
	           	</form>
	    	 </div>
	           <div id="userInfo">
	               <ul>
	                   <li id="goMypage">
	                   		<a href="goMypage.do?mNo=${ loginUser.mNo }">
		                   		<c:if test="${ !empty loginUser.mRenameImage }">
		                   		<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
		                   		</c:if>
		                   		<c:if test="${ empty loginUser.mRenameImage }">
		                   		<img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
		                   		</c:if>
		                   		<p>${ loginUser.userId }</p>
	                   		</a>
	                   </li>
	                   <li><a href="pInsertView.do"><img src="resources/icons/write.png" alt="WRITE" id="writeIcon"></a></li>
	                   <li><img src="resources/icons/alarm.png" alt="" id="alarmIcon" style="cursor:pointer;"></li>
	                   <li><a><img src="resources/icons/open.png" alt="" id="detailInfo"></a></li>
	               </ul>
	           </div>
	           <div class="user_alarm" style="display:none; cursor:pointer;">
                    <div id="alarmList">
                        <div id="list">
                            <img src="resources/images/mp_profile_sample.jpg">
                            <p><b>user01</b>님이 회원님의 게시글을 좋아합니다.</p>
                        </div>
                    </div>
                </div>
	     </div>
	     
	     
	     
	     
	     
	     <div class="myAccount">
				<div id="myId">
					<c:if test="${ !empty loginUser.mRenameImage }">
						<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="myProfile" id="myProfile">
					</c:if>
					<c:if test="${ empty loginUser.mRenameImage }">
						<img src="<%=request.getContextPath()%>/resources/icons/pro_default.png" alt="myProfile" id="myProfile">
					</c:if>
					<p>${ loginUser.userId }</p>
				</div>
				<div id="MyTab">
					<button class="MyTab_tab1 MyTab_tab on">팔로워</button>
					<button class="MyTab_tab2 MyTab_tab">팔로잉</button>
					<button class="MyTab_tab3 MyTab_tab">그룹</button>
					<div id="MyTab_container">
						<!-- 팔로워 -->
						<div class="MyTab_box1 MyTab_box on">
							<div id="My_follower_list">
							
							</div>
						</div>
						<!-- 팔로잉 -->
						<div class="MyTab_box2 MyTab_box">
							<div id="My_following_list">
							
							</div>
						</div>
						<!-- 그룹 -->
						<div class="MyTab_box3 MyTab_box">
							<div id="My_fgroup_list">
								
							</div>
						</div>
					</div>
				</div>
			</div>
	     
	     <div id="menubar">
	     	 <c:url var="goHome" value="home.do"/>
	     	 <c:url var="glist" value="glist.do"/>
	         <ul id="menu">
	             <li><a href="${ goHome }"><img src="resources/icons/menu_home.png" alt="HOME"></a></li>
             	 <li><img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon"></li>
             	 
	             <li><a href="${ glist }"><img src="resources/icons/logoicon.png"></a></li>
	             <li><a href="goSetting.do" ><img src="resources/icons/menu_set.png" alt="SET"></a></li>
	         </ul>
	     </div>
     <script type="text/javascript">
     /* 채팅 읽음 처리  */
    /*  function countChatRead() {
    	var myId = '<c:out value="${loginUser.userId}"/>';
    	$.ajax({
    		url:"countChat.do",
    		data:{myId:myId},
    		dataType:"json",
    		success:function(data){
    			$("#menu li:nth-child(2)").children().remove();
    			if(data.countChat > 0) {
	    			var $img = '<img src="resources/icons/menu_chat_new.png" alt="CHAT" id="chat_icon" name="chat_icon">';
    			} else {
    				var $img = '<img src="resources/icons/menu_chat.png" alt="CHAT" id="chat_icon" name="chat_icon">';
    			}
    			$("#menu li:nth-child(2)").append($img);
    		},
    		error:function(){
    			console.log("에러");
    		}
    	});
     } */
     /* 채팅 창 여는 스크립트 */	
     function openChat() {
        	 $.ajax({
             	url:"oneChatList.do",
             	data:{userId:'<c:out value="${loginUser.userId}"/>'},
             	type:"post",
        		dataType:"json",
             	success:function(data){
             		$("#mcList").children().remove();
             		$.each(data,function(index,value){
             			var $div = $('<div class="chRoom">');
						var $ul = $('<ul>');
						var $img = $("<li>");
						var $rImg = $('<img src="resources/'+value.chatImage+'">');
						var $inputt = $('<input type="hidden" class="crNo">').val(value.crNo);
						if(value.read == 'N') {
							if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
								var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
	    						var $id = $("<li>").text(value.toId+"  ");
	    						$id.append($nImg);
	    						var $inputId = $('<input type="hidden" class="readId">').val(value.toId);
    						} else {
    							var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
    							var $id = $("<li>").text(value.fromId);
    							$id.append($nImg);
    							var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
    						}
						} else {
							if('<c:out value="${loginUser.userId}"/>' == value.fromId) {
	    						var $id = $("<li>").text(value.toId);
	    						var $inputId = $('<input type="hidden" class="readId">').val(value.toId);
    						} else {
    							var $id = $("<li>").text(value.fromId);
    							var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
    						}
						}
						var $cContent = $("<li>").text(value.cContent);
						
						$img.append($rImg);
						$ul.append($img);
						$ul.append($id);
						$ul.append($cContent);
						$div.append($ul);
						$div.append($inputt);
						$div.append($inputId);
						$("#mcList").append($div);
					});
             	},
             	error:function(){
             		console.log("에러");
             	}
              });
     }
     /* 그룹 채팅창 여는 스크립트 */
     function openGruopChat(){
    	 $.ajax({
          	url:"GroupChatList.do",
          	data:{userId:'<c:out value="${loginUser.userId}"/>'},
          	type:"post",
     		dataType:"json",
          	success:function(data){
          		$("#myGroupChat_list").children().remove();
          		$.each(data,function(index,value){
          			var $div = $('<div class="chRoom2">');
					var $ul = $('<ul>');
					var $img = $("<li>");
					var $rImg = $('<img src="resources/'+value.chatImage+'">');
					var $inputt = $('<input type="hidden" class="crNo">').val(value.crNo);
					if(value.read == 'N') {
						var $nImg = $('<img class="chat_read" src="resources/icons/chat_new.png" style="width: 10px; height:10px;">');
						var $id = $("<li>").text(value.gName);
						$id.append($nImg);
						var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
					} else {
							var $id = $("<li>").text(value.gName);
							var $inputId = $('<input type="hidden" class="readId">').val(value.fromId);
					}
					var $cContent = $("<li>").text(value.cContent);
					
					$img.append($rImg);
					$ul.append($img);
					$ul.append($id);
					$ul.append($cContent);
					$div.append($ul);
					$div.append($inputt);
					$div.append($inputId);
					$("#myGroupChat_list").append($div);
				});
          	},
          	error:function(){
          		console.log("에러");
          	}
           });
     }
     
     /* 채팅방 채팅내용 불러오기 */
     $(document).on("click",".chRoom",function(){
    	 
    	 $("#inputArea").keydown(function(key){
    		if(key.keyCode == 13) {
   	 			sendMessage();
    		} 
    	 });
    	 
		var crNo = $(this).children(".crNo").val();
		var readId = $(this).children(".readId").val();
		console.log(crNo +":"+readId);
		$.ajax({
			url:"oneChatContentList.do",
			data:{crNo:crNo, readId:readId},
         	type:"post",
    		dataType:"json",
    		success:function(data){
    			console.log("ok");
    			var userId = '<c:out value="${loginUser.userId}"/>';
    			$("#chatArea").children().remove();
    			$.each(data,function(index,value){
	    			if(value.fromId == userId) {
	    				$div1 = $("<div class='myChating'>");
	    				$div = $("<div>");
	    				$p = $("<p id='myChatt'>").text(value.cContent);
	    				$inputId = $("<input type='hidden' class='1'>").val(value.toId);
	    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				
	    				$div.append($p);
	    				$div1.append($div);
	    				
	    				$("#chatArea").append($div1);
	    				$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputType);
	        			$("#chatArea").append($inputCrNo);
	    				
	    			} else {
	    				$div3 = $("<div class='chating'>");
	    				$inputId = $("<input type='hidden' class='1'>").val(value.fromId);
	    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
	    				$inputCrNo = $("<input type='hidden' class='3'>").val(value.crNo);
	    				$inputChatImage = $("<input type='hidden' class='4'>").val(value.chatImage);
	    				$div = $("<div>");
	        			$img = $('<img src="resources/'+value.chatImage+'">');
	        			$p = $("<p id='chatId'>").text(value.fromId);
	        			$div1 = $("<div>");
	        			$a = $("<a id='chatText'>").text(value.cContent);
	        			$userName = $("#chatUser").text(value.fromId);
	        			
	        			$div.append($img);
	        			$div.append($p);
	        			$div1.append($a);
	        			$div.append($div1);
	        			$div3.append($div);
	        			
	        			$("#chatArea").append($div3);
	        			$("#chatArea").append($inputId);
	        			$("#chatArea").append($inputType);
	        			$("#chatArea").append($inputCrNo);
	        			$("#chatArea").append($inputChatImage);
	    			}
    			});
    			$(".chat_room").show();
    			$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
    			countChatRead();
    		},
    		error:function(){
    			console.log('에러');
    		}
		});
		var msg = $("#inputArea").val();
	 });

     /* 페이지 로딩 시 실행되는 것들 */
     $(function(){
    	 countChatRead();
    	 $('#menu li:nth-child(2)').on("click",function(){
    		 var state = $(".chat").css('display');
    		 var state2 = $(".chat_room").css("display");
    		 if(state2 == 'none') {
    			 if(state =='none'){
    	             openChat();
    	             $('.chat').show();
                 } else {
                	 $(".chat").hide();
                 }
    		 } else {
    			 $(".chat_room").hide();
    			 $(".chat").hide();
    		 }
             
     	 });
    	 
    	 /* 채팅방 만들기 */
    	 $("#myFeed_message_btn").on("click",function(){
    		var nId1 = '${loginUser.userId}';
    		var nId2 = '${param.userId}';
    		console.log(nId1+":"+nId2);
    		$.ajax({
    			url:'insertChatRoom.do',
    			data:{myId:nId1,otherId:nId2},
    			success:function(data){
    				console.log("ok");
    				$('.myFeed_popup_others').hide();
    				$("#chatUser").text(nId2);
    				$div3 = $("<div class='chating'>");
    				$inputId = $("<input type='hidden' class='1'>").val(nId2);
    				$inputType = $("<input type='hidden' class='2'>").val("chatting");
    				$inputCrNo = $("<input type='hidden' class='3'>").val(data.crNo);
    				console.log(data.toId +":" + data.crNo);
    				$("#chatArea").append($div3);
        			$("#chatArea").append($inputId);
        			$("#chatArea").append($inputType);
        			$("#chatArea").append($inputCrNo);
        			
        			$("#inputArea").keydown(function(key){
        	    		if(key.keyCode == 13) {
        	   	 			sendMessage();
        	   	 			$('#inputArea').val('');
        	    		} 
        	    	 });
    				
    				$(".chat_room").show();
    			},
    			error:function(){
    				console.log("에러");
    			}
    		});
    	 });
    	 /* 그룹 채팅방 만들기 */
    	 $("#isnertGroupChat").on("click",function(){
    		var createId = '${loginUser.userId}';
    		var gNo = '${param.gNo}';
    		var gName = $("#groupName").children("b").text();
    		console.log(createId +":"+gNo + ":" + gName);
    		$.ajax({
    			url:'insertGroupChatRoom.do',
    			data:{createId:createId,gNo:gNo},
    			success:function(data){
    				$('.pop_menu_master').hide();
    				$("#chatUser").text(gName);
    				$div3 = $("<div class='chating'>");
    				$inputgNo = $("<input type='hidden' class='1'>").val(gNo);
    				$inputType = $("<input type='hidden' class='2'>").val("groupChatting");
    				$inputCrNo = $("<input type='hidden' class='3'>").val(data.crNo);
    				console.log(data.toId +":" + data.crNo);
    				$("#chatArea").append($div3);
        			$("#chatArea").append($inputgNo);
        			$("#chatArea").append($inputType);
        			$("#chatArea").append($inputCrNo);
        			
        			$("#inputArea").keydown(function(key){
        	    		if(key.keyCode == 13) {
        	   	 			sendMessage();
        	   	 			$('#inputArea').val('');
        	    		} 
        	    	 });
    				
    				$(".chat_room").show();
    			},
    			error:function(){
    				console.log("에러");
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
             openChat();
         });

         $('.tab_menu_btn2').on('click',function(){
             $('.tab_box').hide();
             $('.tab_box2').show();
             openGruopChat();
         });

         $("#list").on("click",function(){
             $(".chat_room").show();
         });

         $('#goList').on("click",function(){
             $(".chat_room").hide();
        	 openChat();
         });
     });
     
     /**************알림창 열기 ****************/
     $('#alarmIcon').on("click",function(){
        
    	 $('.user_alarm').slideToggle();
    	 $("#alarmIcon").attr('src',"resources/icons/alarm.png")           
       });
     
     /* 채팅 관련(sockJs) */
     $(function(){
 		$("#send").on("click",function(){
 			sendMessage();
 		});
 	 });
     
	 var sock = new SockJS("http://localhost:8888/spring/echo");
 	 sock.onmessage = onMessage;
 	 sock.onclose = onClose;
 	 
 	 // 메시지 전송
 	 function sendMessage() {
 	 	 var toId = $("#chatArea").children(".1").val();
 		 var sendType = $("#chatArea").children(".2").val();
 		 var crNo = $("#chatArea").children(".3").val();
 		 if(sendType == 'chatting' || sendType == 'groupChatting') {
	 		 sock.send($("#inputArea").val() +"|"+toId+"|"+sendType+"|"+crNo);
	 		 $('#inputArea').val('');
 		 }
 	 }
 	 // 서버로부터 메시지를 받았을 때
 	 function onMessage(msg) {
 		 var data = msg.data;
 		 var dArr = data.split('|');
 		 if(dArr.length == 2) {
 			if(dArr[0] == null || dArr[0] == ' ') {
 				
 			} else {
 				$div1 = $("<div class='myChating'>");
 				$div = $("<div>");
 				$p = $("<p id='myChatt'>").text(dArr[0]);
 				
 				$div.append($p);
 				$div1.append($div);
 				
 				$("#chatArea").append($div1);
 			}
 			
 		 } else {
			if(data == null || data == ' ') {
 				
 			} else {
 				var toId = $("#chatArea").children(".1").val();
 	 			var inputChatImage = $("#chatArea").children(".4").val();
 	 			$div3 = $("<div class='chating'>");
 				$div = $("<div>");
 				$img = $('<img src="resources/'+inputChatImage+'">');
 				$p = $("<p id='chatId'>").text(toId);
 				$div1 = $("<div>");
 				$a = $("<a id='chatText'>").text(data);
 				$userName = $("#chatUser").text(toId);
 				
 				$div.append($img);
 				$div.append($p);
 				$div1.append($a);
 				$div.append($div1);
 				$div3.append($div);
 				
 				$("#chatArea").append($div3);
 			}
 		 }
 		 $("#chatArea").scrollTop($("#chatArea")[0].scrollHeight);
 		 countChatRead();
 		 openChat();
 	 }
 	 // 서버와 연결을 끊었을 때
 	 function onClose(evt) {
 		 $("#chatArea").append("연결 끊김");
 	 }
 	 
 	 
 	 
 	/************* 내계정 자세히보기 script **************/

     $(document).ready(function(){
    	 $('.MyTab_tab').on("click",function(){
             $('.MyTab_tab').removeClass('on');
             $(this).addClass('on')
         });
    	 
    	 
         $("#detailInfo").on("click",function(){
        	 getFollowerList();
        	 $(".myAccount").animate({width:"toggle"},250);
         });

	     $('.MyTab_tab1').on('click', function(){
	    	 getFollowerList();
	    	 $('.MyTab_box').hide();
     		 $('.MyTab_box1').show();
    	 });
	     
	     $('.MyTab_tab2').on('click', function(){
	    	 getFollowList();
	    	 $('.MyTab_box').hide();
     		 $('.MyTab_box2').show();
	     });
     
	     $('.MyTab_tab3').on("click", function(){
    	 	 getGroupList();
       		 $('.MyTab_box').hide();
             $('.MyTab_box3').show();
	     });


	     
	     $(document).on("click","#goDetail",function(){
		     var gNo =$(this).parents().children('input').val();
	    	 console.log(gNo);
	    	 location.href="gdetail.do?gNo="+ gNo;
	     });
	     
	     $(document).on("click","#goUserPage",function(){
	    	 var userId = $(this).parents().children('a').text();
	    	 var mNo = $(this).parents().children('input').val();
	    	 location.href="goUserpage.do?userId=" + userId + "&mNo=" + mNo;
	     });
	     
	     
	     $(document).on("click","#follower", function(){
	    	 var mNo = ${ loginUser.mNo };
	    	 var follower = $(this).parents().children('input').val();
	    	 console.log(follower);
	    	 $.ajax({
	    		url:"delFollower.do",
	    		data:{mNo:mNo, foNo:follower},
	    		type:"post",
	    		success:function(data){
	    			if(data>0){
	    				alert("삭제하였습니다.");
	    				getFollowerList();
	    			}else{
	    				alert("삭제 실패하였습니다.");
	    			}
	    		},error:function(){
	    			alert("삭제오류");
	    		}
	    	 });
	    	 
	     });
     
	     
	     $(document).on("click","#following", function(){
	    	 var mNo = ${ loginUser.mNo };
	    	 var follows = $(this).parents().children('input').val();
	    	 console.log(follows);
	    	 $.ajax({
	    		 url:"delFollow.do",
	    		 data:{ mNo:mNo, foNo:follows},
	    		 type:"post",
	    		 success:function(data){
	    			 console.log(data);
	    			 	if(data> 0){
	    			 		alert("팔로우를 취소하였습니다.");
	    			 		getFollowList();
	    			 	}else{
	    			 		alert("실패했습니다.");
	    			 	}
		    		 	
		    		 },error:function(){
		    			 alert("불러오기 실패..");
		    		 }
	    	 });
	     });
     });


	     
	     $(document).on("click","#goDetail",function(){
		     var gNo =$(this).parents().children('input').val();
	    	 console.log(gNo);
	    	 location.href="gdetail.do?gNo="+ gNo;
	     });
	     
	     $(document).on("click","#goUserPage",function(){
	    	 var userId = $(this).parents().children('a').text();
	    	 var mNo = $(this).parents().children('input').val();
	    	 location.href="goUserpage.do?userId=" + userId + "&mNo=" + mNo;
	     });
	     
	     
	     $(document).on("click","#follower", function(){
	    	 var mNo = ${ loginUser.mNo };
	    	 var follower = $(this).parents().children('input').val();
	    	 console.log(follower);
	    	 $.ajax({
	    		url:"delFollower.do",
	    		data:{mNo:mNo, foNo:follower},
	    		type:"post",
	    		success:function(data){
	    			if(data>0){
	    				alert("삭제하였습니다.");
	    				getFollowerList();
	    			}else{
	    				alert("삭제 실패하였습니다.");
	    			}
	    		},error:function(){
	    			alert("삭제오류");
	    		}
	    	 });
	    	 
	     });
     
	     
	     $(document).on("click","#following", function(){
	    	 var mNo = ${ loginUser.mNo };
	    	 var follows = $(this).parents().children('input').val();
	    	 console.log(follows);
	    	 $.ajax({
	    		 url:"delFollow.do",
	    		 data:{ mNo:mNo, foNo:follows},
	    		 type:"post",
	    		 success:function(data){
	    			 console.log(data);
	    			 	if(data> 0){
	    			 		alert("팔로우를 취소하였습니다.");
	    			 		getFollowList();
	    			 	}else{
	    			 		alert("실패했습니다.");
	    			 	}
		    		 	
		    		 },error:function(){
		    			 alert("불러오기 실패..");
		    		 }
	    	 });
	     });
	     
	    
     

</script>
   


</body>
</html>