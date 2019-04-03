<%--
 * list.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="acme" tagdir="/WEB-INF/tags"%>



<display:table name="positions" id="row" requestURI="${requestURI}" pagesize="5" class="displaytag">

	<display:column>
		<a href="position/company/display.do?positionId=${row.id}"><spring:message code="position.display"/></a>
	</display:column>
	
	<security:authorize access="hasRole('COMPANY')">
	<jstl:if test="${principal == row.commpany}">
		<display:column>
			<a href="position/company/edit.do?positionId=${row.id}"><spring:message code="position.edit"/></a>
		</display:column>
	</jstl:if>
	</security:authorize>
	
	<display:column property="title" titleKey="positon.title" />
	
	<display:column property="deadline" titleKey="position.deadline" />

	
</display:table>

