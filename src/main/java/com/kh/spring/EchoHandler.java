package com.kh.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.spring.chat.controller.ChatController;
import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.group.controller.GroupController;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.controller.NotificationController;
import com.kh.spring.notification.model.vo.PushAlram;


@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{
	
	// httpSession과 webSocketSession 맵객체에 담기
	private Map<String,WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();
    //세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
    
    @Autowired
    private ChatController cController;
    @Autowired
	private NotificationController nController;
    
    @Autowired
    private GroupController gController;
    
    @Autowired
    private GroupController gController;
    
    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        String senderId = getId(session);
        userSessions.put(senderId, session);
        logger.info("{} 연결됨", session.getId()); 
        
        Object[] x = sessionList.toArray();
        for(int i=0;i<x.length;i++) {
        	System.out.println("session :"+ x[i]);
        	
        }
        
        System.out.println("몇명 접속중인가? " + userSessions.size());
        System.out.println(userSessions.toString());
        
    }

	//클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        
        String msg = message.getPayload();
        if(!StringUtils.isEmpty(msg)) {
        	String[] strs = msg.split("\\|");
        	String fromId = getId(session);
        	String Rmsg = "";
			String toId = "";
			String sendType = "";
			String crno = "";
			System.out.println(fromId+Rmsg+Rmsg+sendType+crno);
        	for (int i = 0; i < strs.length; i++) {
				Rmsg = strs[0];
				toId = strs[1];
				sendType = strs[2];
				crno = strs[3];
			}
        	int crNo = Integer.parseInt(crno);
        	
        	if(sendType.equals("chatting")) {
        		WebSocketSession toSession =  userSessions.get(toId);
        		if(Rmsg == null || Rmsg.equals("")) {
            		Rmsg = " ";
            		if(toSession == null) {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	} else {
            		int result = cController.sendMessage(new Chat(),fromId,toId,Rmsg,crNo);
            		if(toSession == null) {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	}
        		
<<<<<<< HEAD
        	} else{
        		//작성자가 로그인 해서 있다면
				WebSocketSession boardWriterSession = userSessions.get(toId); // 이줄 맞는지 모르겠음 get()
				System.out.println("이게뭐지? "+boardWriterSession);
				System.out.println("왜 아무것도 안들어옴?"+fromId+Rmsg+sendType+crno);
				// 테스트용
				//int result = nController.sendAlram(new PushAlram(),toId,fromId,sendType,crNo);
				
				if(boardWriterSession != null) {
					if(sendType.equals("reply") ) {
						TextMessage tmpMsg = new TextMessage(fromId + "님이 " + 
											"<a type='external' href='/mentor/menteeboard/menteeboardView?seq="+"게시글번호"+"&pg=1'></a> 회원님 게시글에 댓글을 남겼습니다.");
						boardWriterSession.sendMessage(tmpMsg);
					
					}else if("follow".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage(fromId + "님이 회원님을 팔로우를 시작했습니다.");
						System.out.println(boardWriterSession.toString());
						System.out.println(boardWriterSession.getId() +"여기맞음"+ tmpMsg.toString());
						boardWriterSession.sendMessage(tmpMsg);
						
					}else if("like".equals(sendType)) {
						TextMessage tmpMsg = new TextMessage(fromId + "님이 회원님의 게시물을 좋아합니다.");
						PushAlram pa = new PushAlram(toId,fromId,sendType,Integer.parseInt(crno));
						int result = nController.alramLike(pa);
						boardWriterSession.sendMessage(tmpMsg);
					}
				}
=======
        	} else if(sendType.equals("groupChatting")) {
        		ArrayList<GroupMember> list = gController.getGroupList(toId);
        		WebSocketSession toSession = null;
        		for(GroupMember g : list) {
        			toSession = userSessions.get(g.getGmId());
        			if(Rmsg == null || Rmsg.equals("")) {
	        			if(toSession == null) {
	        				session.sendMessage(new TextMessage(Rmsg+"|sender"));
	        			} else {
	        				session.sendMessage(new TextMessage(Rmsg+"|sender"));
	            			toSession.sendMessage(new TextMessage(Rmsg));
	        			}
        			} else {
        				int result = cController.sendMessage(new Chat(), fromId, toId, Rmsg, crNo);
        				if(toSession == null) {
	        				session.sendMessage(new TextMessage(Rmsg+"|sender"));
	        			} else {
	        				session.sendMessage(new TextMessage(Rmsg+"|sender"));
	            			toSession.sendMessage(new TextMessage(Rmsg));
	        			}
        			}
        		}
        	} else if(sendType.equals("alarm")) {
        		
>>>>>>> branch 'master' of https://github.com/unimik/finalGroobee.git
        	}
        }
        
    }
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
    // Interceptor를 이용해 websocketsession에서 httpsession값 가져오는 메소드
    private String getId(WebSocketSession session) {
    	Map<String,Object> httpSession = session.getAttributes();
    	Member loginUser = (Member)httpSession.get("loginUser");
    	if(loginUser == null) {
    		return session.getId();
    	} else {
    		return loginUser.getUserId();
    	}
	}
    
}