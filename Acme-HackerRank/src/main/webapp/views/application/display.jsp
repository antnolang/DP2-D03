<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>


	<strong><spring:message code="application.hacker" />:</strong>
	<jstl:out value="${application.hacker.fullname}" />
	<br />


<strong><spring:message code="application.applicationMoment" />:</strong>
<jstl:out value="${application.applicationMoment}" />
<br />

<strong><spring:message code="application.status" />:</strong>
<jstl:out value="${application.status}" />
<br />

<jstl:if test="${application.status!='PENDING'}">
	<strong><spring:message code="application.submittedMoment" />:</strong>
	<jstl:out value="${application.submittedMoment}" />
	<br />

<strong><spring:message code="application.answer" />:</strong>
	<a
		href="answer/company,hacker/display.do?answerId=${application.answer.id}"><spring:message
			code="application.display.answer" /></a>
	<br />

</jstl:if>

<strong><spring:message code="application.curriculum" />:</strong>
<a
	href="curriculum/display.do?curriculumId=${application.curriculum.id}"><spring:message
		code="application.display.curriculum" /></a>
<br />


<strong><spring:message code="application.position" />:</strong>
<jstl:out value="${application.position.title}" />
<br />

<strong><spring:message code="application.problem" />:</strong>
<jstl:out value="${application.problem.title}" />
<br />
<br />

<jstl:if test="${application.status=='PENDING'}">
	<a href="answer/hacker/create.do?applicationId=${application.id}"><spring:message
			code="application.answer.create" /></a>
	<br />
</jstl:if>

<br />
<!-- Links -->
<jstl:if test="${rolActor=='hacker'}">
<a href="application/hacker/list.do"> <spring:message
		code="application.return" />
</a>
</jstl:if>

<jstl:if test="${rolActor=='company'}">
<a href="application/company/list.do?positionId=${application.position.id}"> <spring:message
		code="application.return" />
</a>
</jstl:if>