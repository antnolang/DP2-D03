<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="acme" tagdir="/WEB-INF/tags" %>


<form:form action="positionData/hacker/edit.do" modelAttribute="positionData">
	<input type="hidden" name="curriculumId" value="${curriculumId}"/>
	<form:hidden path="id" />
	<form:hidden path="version" />

	<fieldset>
		<legend><spring:message code="positionData.fieldset"/></legend>
		
		<acme:textbox code="positionData.title" path="title"/>
		<acme:textbox code="positionData.description" path="description"/>
		<acme:textbox code="positionData.startDate" path="startDate" placeholder="dd/mm/yyyy"/>
		<acme:textbox code="positionData.endDate" path="endDate" placeholder="dd/mm/yyyy"/>
	</fieldset>
	
	<!-- Buttons -->
	<acme:submit name="save" code="positionData.save"/>
	&nbsp;
	<acme:submit name="delete" code="positionData.delete"/>
	&nbsp;
	<acme:cancel code="positionData.cancel" url="positionData/hacker/backCurriculum.do?positionDataId=${positionData.id}"/>
</form:form>