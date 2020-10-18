package com.kh.spring.search.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.dao.TotalSearchDao;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

@Service("tsService")
public class TotalSearchServiceImpl implements TotalSearchService {

	@Autowired
	private TotalSearchDao tsDao;
	
	@Override
	public ArrayList<Member> searcMember(Search srch) {
		
		return tsDao.searchMember(srch);
	}

//	@Override
//	public ArrayList<Group> searchGroup(Search srch) {
//		
//		return tsDao.searchGroup(srch);
//	}

	@Override
	public ArrayList<Feed> searchFeed(Search srch) {
		
		return tsDao.searchFeed(srch);
	}

	@Override
	public ArrayList<RelatedSearch> relatedSearch(Search srch) {
		return tsDao.relatedSearch(srch);
	}



}