/**
 * 알람 기능 관련 스크립트
 */

// 알람 전송
 function sendAlram(fromId,toId,type,aNo) {
// 	 var fromId = fromId;//알람을 보낼id   
// 	 var toId = toId;
//	 var sendType = type; // 보낼 알람의 타입
//	 var type = type;
//	 var crNo = aNo;//보내질 알람 타입별 유저/게시물번호   
	 console.log(fromId+","+toId+","+type+","+aNo +"여기까지나옴");
	 sock.send("alarm"+"|"+toId+"|"+type+"|"+aNo);

 }

 // 좋아요 클릭시 알람
 $(".likeIcon").on('click',function(e){
	 console.log("like클릭됨");
	 $("#"+e.target.id).css('background','red');
	 $("#"+e.target.id).parent().children('input').val()
	 console.log("상관없음",$("#"+e.target.id).parent().children('input').val(),'like',$("#"+e.target.id).parent().children('.fNo').val());
	 sendAlram("상관없음",$("#"+e.target.id).parent().children('input').val(),'like',$("#"+e.target.id).parent().children('.fNo').val());
 });

//그룹원 내보내기 알림
	$(".del_gm").on('click',function(e){
		console.log("e.target:"+e.target.getElementById());
		sendAlram();
	});

	//그룹 가입 신청 알람
	$("#joinBtn").on('click',function(){
		alert('그룹가입 신청');
		// 그룹 가입 알람
      	function sendAlarm(){
      		console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
      		sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');          		
      	};
	});
	// 팔로우 클릭
	$('#follow_btn').click(function() {

         console.log("follow 클릭됨");
        sendAlram('${loginUser.userId}','${ memberInfo.userId }','follow','1');
	});

	// 그룹가입알람 그룹디테일에 넣어야함
	$("#joinBtn").on('click',function test(){
			alert("test");
			console.log('${loginUser.userId}','${g.gCreator}',"groupjoin",'${g.gNo}');
  		sendAlram('${loginUser.userId}','${g.gCreator}','groupjoin','${g.gNo}');   
		});
