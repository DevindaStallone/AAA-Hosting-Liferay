<%@ include file="init.jsp" %>

<%
	ResultRow row = (ResultRow) request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	sitiServices services = (sitiServices) row.getObject();
	long groupId = services.getGroupId();
	String name = sitiServices.class.getName();
	long serviceId = services.getServiceId();
	String redirect = PortalUtil.getCurrentURL(renderRequest);
%>

<liferay-ui:icon-menu>
	<portlet:renderURL var="editURL">
		<portlet:param name="mvcPath"
			value="/updateService.jsp" />
		<portlet:param name="serviceId"
			value="<%=String.valueOf(serviceId)%>" />
		<portlet:param name="redirect" value="<%=redirect%>" />
	</portlet:renderURL>

	<liferay-ui:icon image="edit" url="<%=editURL.toString()%>" />

	<portlet:actionURL name="deleteServices" var="deleteURL">
		<portlet:param name="serviceId"
			value="<%=String.valueOf(serviceId)%>" />
		<portlet:param name="redirect" value="<%=redirect%>" />
	</portlet:actionURL>

	<liferay-ui:icon image="delete" url="<%=deleteURL.toString()%>" />
</liferay-ui:icon-menu>