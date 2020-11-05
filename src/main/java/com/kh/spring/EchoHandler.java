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
    private GroupController gController;
    
    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        String senderId = getId(session);
        userSessions.put(senderId, session);
        logger.info("{} 연결됨", session.getId()); 
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
        	for (int i = 0; i < strs.length; i++) {
				Rmsg = strs[0];
				toId = strs[1];
				sendType = strs[2];
				crno = strs[3];
			}
        	int crNo = Integer.parseInt(crno);
        	
        	if(sendType.equals("chatting")) {
        		WebSocketSession toSession =  userSessions.get(toId);
        		System.out.println(toSession);
        		if(Rmsg == null || Rmsg.equals("")) {
            		Rmsg = " ";
            		if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	} else {
            		int result = cController.sendMessage(new Chat(),fromId,toId,Rmsg,crNo);
            		if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
            			System.out.println("값 XXX");
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            		} else {
            			System.out.println("값 OOOOO");
            			session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			toSession.sendMessage(new TextMessage(Rmsg));
            		}
            	}
        		
        	} else if(sendType.equals("groupChatting")) {
        		ArrayList<GroupMember> list = gController.getGroupList(toId);
        		WebSocketSession toSession = null;
        		int result = cController.sendMessageGroup(new Chat(), fromId, toId, Rmsg, crNo);
        		String img = "";
        		for(GroupMember gg : list) {
        			if(gg.getGmId().equals(fromId)) {
        				img = gg.getGmImage();
        			}
        		}
        		for(GroupMember g : list) {
        			toSession = userSessions.get(g.getGmId());
        			if(Rmsg == null || Rmsg.equals("")) {
        				if(toSession.equals(fromId)) {
            				session.sendMessage(new TextMessage(Rmsg+"|sender"));
            			} else {
            				if(toSession.equals("") || toSession == null || !toSession.isOpen()) {
            					continue;
            				} else {
            					toSession.sendMessage(new TextMessage(Rmsg));
            				}
            			}
        			} else {
        				if(result == -1) {
        					if(g.getGmId().equals(fromId)) {
        						session.sendMessage(new TextMessage(Rmsg.substring(0, Rmsg.length()-4)+"|sender|sender"));
        					} else {
        						if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
        							continue;
        						} else {
        							toSession.sendMessage(new TextMessage(Rmsg.substring(0, Rmsg.length()-4)+"|sender|sender"));
        						}
        					}
        				} else {
        					if(g.getGmId().equals(fromId)) {
        						session.sendMessage(new TextMessage(Rmsg+"|sender"));
        					} else {
        						if(toSession == null || toSession.equals("") || !toSession.isOpen()) {
        							continue;
        						} else {
        							toSession.sendMessage(new TextMessage(Rmsg+"|"+fromId+"|memberProfileFiles/"+img));
        						}
        					}
        				}
        			}
        		}
        	} else if(sendType.equals("alarm")) {
        		
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