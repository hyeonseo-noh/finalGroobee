package com.kh.spring.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.admin.dao.AdminDao;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.vo.Question;

@Service("aService")
public class AdminServiceImpl implements AdminService{

	@Autowired
	AdminDao aDao;

	@Override
	public ArrayList<Member> memberSearchList(Member m) {
		return aDao.memberSearchList(m);
	}

	@Override
	public ArrayList<Group> groupSearchList(Group g) {
		return aDao.groupSearchList(g);
	}

	@Override
	public ArrayList<Reply> replySearchList(Reply re) {
		return aDao.replySearchList(re);
	}

	@Override
	public int memberStatusChange(Member m) {
		return aDao.memberStatusChange(m);
	}

	@Override
	public ArrayList<Feed> feedSearchList(Feed f) {
		return aDao.feedSearchList(f);
	}

	@Override
	public int feedStatusChange(Feed f) {
		return aDao.feedStatusChange(f);
	}

	@Override
	public int replyStatusChange(Reply r) {
		return aDao.replyStatusChange(r);
	}

	@Override
	public int groupStatusChange(Group g) {
		return aDao.groupStatusChange(g);
	}

	@Override
	public ArrayList<Question> questionSearchList() {
		return aDao.questionSearchList();
	}

	@Override
	public ArrayList<Member> questionSearchListName() {
		return aDao.questionSearchListName();
	}
}