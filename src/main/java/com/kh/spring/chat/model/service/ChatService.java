package com.kh.spring.chat.model.service;

import java.util.ArrayList;

import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.member.model.vo.Member;

public interface ChatService {

	/**
	 * 1. 채팅방 리스트 가져오기
	 * @param userId
	 * @return
	 */
	ArrayList<Chat> getChatList(String userId);

	/**
	 * 2. 채팅방 내용 불러오기
	 * @param readC
	 * @return
	 */
	ArrayList<Chat> getChatContentList(Chat readC);

	/**
	 * 3. 채팅내용 인서트
	 * @param c
	 * @return
	 */
	int insertChat(Chat c);

	/**
	 * 4. 채팅목록 이미지 가져오기
	 * @param mList
	 * @return
	 */
	ArrayList<Member> getChatImage(ArrayList<Member> mList);

	/**
	 * 5. 1대1 채팅방 생성
	 * @param myId
	 * @param otherId
	 * @return
	 */
	int insertChatRoom(String myId, String otherId);

	/**
	 * 6. 읽지않은 채팅 카운트
	 * @param myId
	 * @return
	 */
	int countChat(String myId);

	/**
	 * 7. 그룹 채팅방 생성
	 * @param c
	 * @return
	 */
	int insertGroupChatRoom(Chat c);

	/**
	 * 8. 그룹 채팅방 목록 불러오기
	 * @param userId
	 * @return
	 */
	ArrayList<Chat> getGroupChatList(String userId);

	/**
	 * 9. 그룹 채팅 보내기
	 * @param c
	 * @return
	 */
	int insertGroupChat(Chat c);

	/**
	 * 10. 그룹 채팅 내용 불러오기
	 * @param c
	 * @return
	 */
	ArrayList<Chat> getGroupChatContentList(Chat c);

	/**
	 * 11. 그룹 채팅멤버 추가
	 * @param c
	 * @return
	 */
	int insertJoinChatRoom(Chat c);

	/**
	 * 12. 같은 방 친구들 가져오기
	 * @param gNo
	 * @return
	 */
	ArrayList<Chat> getJoinMember(int gNo);

	/**
	 * 13. 채팅 내용 추가로 불러오기(20개씩 - 일대일)
	 * @param loadC
	 * @return
	 */
	ArrayList<Chat> chatContentLoad(Chat loadC);

	/**
	 * 14. 채팅 내용 추가로 불러오기(20개씩 - 그룹)
	 * @param chat
	 * @return
	 */
	ArrayList<Chat> groupChatContentLoad(Chat chat);

	/**
	 * 15. 채팅방 삭제
	 * @param crNo
	 * @return
	 */
	int deleteOneChat(int crNo);

	/**
	 * 16. 그룹 채팅방 나가기
	 * @param c
	 * @return
	 */
	int deleteGroupChat(Chat c);

}
