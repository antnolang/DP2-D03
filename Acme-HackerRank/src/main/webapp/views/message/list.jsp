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

<display:table name="sentMessages" id="row" requestURI="${requestURI}" pagesize="5" class="displaytag">
	<display:column>
		<a href="message/administrator,company,hacker/display.do?messageId=${row.id}">
			<spring:message code="message.display" />
		</a>
	</display:column>
	<display:column>
		<a href="message/administrator,company,hacker/delete.do?boxId=${row.id}">
			<spring:message code="message.delete" />
		</a>
	</display:column>
	
	<spring:message code="message.date.format" var="dateFormat"/>
	<display:column property="sentMoment" titleKey="message.sendMoment" format="${dateFormat}"/>
	
	<display:column property="subject" titleKey="message.subject"/>
	<display:column property="tags" titleKey="message.tags"/>	
</display:table>

<display:table name="receivedMessages" id="fila" requestURI="${requestURI}" pagesize="5" class="displaytag">
	<display:column>
		<a href="message/administrator,company,hacker/display.do?messageId=${fila.id}">
			<spring:message code="message.display" />
		</a>
	</display:column>
	<display:column>
		<a href="message/administrator,company,hacker/delete.do?boxId=${fila.id}">
			<spring:message code="message.delete" />
		</a>
	</display:column>
	
	<display:column property="sender.fullname" titleKey="actor.name" />
	
	<spring:message code="message.date.format" var="dateFormat"/>
	<display:column property="sentMoment" titleKey="message.sendMoment" format="${dateFormat}"/>
	
	<display:column property="subject" titleKey="message.subject"/>
	<display:column property="tags" titleKey="message.tags"/>	
</display:table>

<!-- LINKS -->
<a href="message/administrator,company,hacker/send.do">
	<spring:message code="message.send"/>
</a>
<br />

<security:authorize access="hasRole('ADMIN')">
	<a href="message/administrator/broadcast.do">
		<spring:message code="message.broadcast" />
	</a>
	<br />
	<a href="message/administrator/breachNotification.do" onclick="return confirm('<spring:message code="message.confirm"/>')">
		<spring:message code="message.breach" />
	</a>
</security:authorize>
	