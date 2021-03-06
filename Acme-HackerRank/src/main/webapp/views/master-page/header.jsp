<%--
 * header.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<div>
	<a href="#"><img src="${banner}" alt="Acme-HackerRank, Inc." /></a>
</div>

<div>
	<ul id="jMenu">
		<!-- Do not forget the "fNiv" class for the first level links !! -->
		<security:authorize access="hasRole('HACKER')">
			<li><a class="fNiv"><spring:message	code="master.page.application" /></a>
				<ul>
					<li class="arrow"></li>
					<li><a href="application/hacker/list.do"><spring:message code="master.page.application.list" /></a></li>			
				</ul>
			</li>
		</security:authorize>
		
		<security:authorize access="hasRole('ADMIN')">
			<li><a class="fNiv"><spring:message	code="master.page.administrator" /></a>
				<ul>
					<li class="arrow"></li>
					<li><a href="customisation/administrator/display.do"> <spring:message code="master.page.customisation" /> </a></li>
					<li><a href="dashboard/administrator/display.do"> <spring:message code="master.page.dashboard" /> </a></li>
					<li><a href="actor/administrator/registerAdministrator.do"><spring:message code="master.page.administrator.create" /></a></li>
					<li><a href="actor/administrator/list.do"><spring:message code="master.page.administrator.list" /></a></li>
				</ul>
			</li>
		</security:authorize>
		
		<security:authorize access="hasRole('COMPANY')">
			<li><a  href="problem/company/list.do" class="fNiv"><spring:message	code="master.page.company.listAll" /></a>
			</li>
		</security:authorize>
		
		<security:authorize access="hasRole('HACKER')">
			<li><a href="curriculum/hacker/list.do" class="fNiv"><spring:message code="master.page.curriculum.list"/></a>
			</li>
			<li><a href="finder/hacker/display.do" class="fNiv"><spring:message code="master.page.finder"/></a>
			</li>
		</security:authorize>
		
		<!-- ALL USERS START -->
		<li><a href="position/search.do" class="fNiv"><spring:message code="master.page.searchposition"/></a>
		</li>
		<li><a  href="position/availableList.do" class="fNiv"><spring:message	code="master.page.availableposition" /></a>
		</li>
		<!-- ALL USERS END -->
		
		<security:authorize access="isAnonymous()">
		
			<li><a class="fNiv" href="company/list.do"><spring:message code="master.page.company.list" /></a></li>
			
			<li><a class="fNiv" href="security/login.do"><spring:message code="master.page.login" /></a></li>
			
			<li><a class="fNiv"><spring:message	code="master.page.register" /></a>	
				<ul>
					<li class="arrow"></li>
					<li><a href="actor/registerCompany.do"><spring:message code="master.page.company.create" /></a></li>
					<li><a href="actor/registerHacker.do"><spring:message code="master.page.hacker.create" /></a></li>
				</ul>
			</li>
		</security:authorize>
		
		<security:authorize access="isAuthenticated()">
		
			<li><a class="fNiv" href="company/list.do"><spring:message code="master.page.company.list" /></a></li>
			<li>
				<a class="fNiv"> 
					<spring:message code="master.page.profile" /> 
			        (<security:authentication property="principal.username" />)
				</a>
				<ul>
					<li class="arrow"></li>		
					<li><a href="actor/display.do"><spring:message code="master.page.actor.display" /></a></li>			
					<li><a href="message/administrator,company,hacker/list.do"><spring:message code="master.page.message.list" /></a></li>
					<li><a href="j_spring_security_logout"><spring:message code="master.page.logout" /> </a></li>
				</ul>
			</li>
		</security:authorize>
	</ul>
</div>

<div>
	<a href="?language=en">en</a> | <a href="?language=es">es</a>
</div>

