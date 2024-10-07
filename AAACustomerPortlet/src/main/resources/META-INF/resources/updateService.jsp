<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/frontend" prefix="liferay-frontend" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>

<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.kernel.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@ page import="com.liferay.petra.string.StringPool" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>
<%@ page import="com.liferay.portal.kernel.model.PersistedModel" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchEntry" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="AAACustomerServices.model.sitiCustomer" %>
<%@ page import="AAACustomerServices.service.sitiCustomerLocalServiceUtil" %>
<%@ page import="AAACustomerServices.service.sitiServicesLocalServiceUtil" %>
<%@ page import="AAACustomerServices.model.sitiServices" %> 


<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %><%@
page import="com.liferay.portal.kernel.template.TemplateHandler" %><%@
page import="com.liferay.portal.kernel.template.TemplateHandlerRegistryUtil" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<liferay-theme:defineObjects />
<portlet:defineObjects />

<%
	sitiServices services = null;
	long serviceId = ParamUtil.getLong(request, "serviceId");
	if (serviceId > 0) {
		services = sitiServicesLocalServiceUtil.getsitiServices(serviceId);
	}
	String redirect = ParamUtil.getString(request, "redirect");
%>

<aui:model-context bean="<%= services %>" model="<%= sitiServices.class %>" />
<portlet:renderURL var="viewServicesURL" />
<portlet:actionURL name='<%= services == null ? "addServices" : "updateServices" %>' var="editServicesURL" windowState="normal" />

<liferay-ui:header
	backURL="<%= viewServicesURL %>"
	title='<%= (services != null) ? services.getServiceName() : "New Service" %>'
/>

<aui:form action="<%= editServicesURL %>" method="POST" name="fm">
	<aui:fieldset>
		<aui:input name="redirect" type="hidden" value="<%= redirect %>" />

		<aui:input name="serviceId" type="hidden" value='<%= services == null ? "" : services.getServiceId() %>'/>

		<aui:input name="serviceName"></aui:input>
		
		<aui:input name="servicePrice"></aui:input>
		
		<aui:input name="serviceExpiration"></aui:input>
		
		<aui:input name="serviceType"></aui:input>
		


	</aui:fieldset>

	<aui:button-row>
		<aui:button type="submit" />

		<aui:button onClick="<%= viewServicesURL %>"  type="cancel" />
	</aui:button-row>
</aui:form>