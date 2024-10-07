package AAACustomerPortlet.portlet;

import AAACustomerPortlet.constants.AAACustomerPortletKeys;
import AAACustomerServices.model.sitiCustomer;
import AAACustomerServices.model.sitiServices;
import AAACustomerServices.service.sitiCustomerLocalService;
import AAACustomerServices.service.sitiCustomerLocalServiceUtil;
import AAACustomerServices.service.sitiServicesLocalService;
import AAACustomerServices.service.sitiServicesLocalServiceUtil;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.util.ParamUtil;

import java.util.Calendar;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author Devinda
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=AAACustomer",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + AAACustomerPortletKeys.AAACUSTOMER,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class AAACustomerPortlet extends MVCPortlet {
	//CustomerPortlet
	public void addCustomer(ActionRequest request, ActionResponse response)
            throws Exception {

        _updateCustomer(request);

        sendRedirect(request, response);
    }

    public void deleteCustomer(ActionRequest request, ActionResponse response)
        throws Exception {

        long customerId = ParamUtil.getLong(request, "customerId");

        sitiCustomerLocalServiceUtil.deleteCustomer(customerId);

        sendRedirect(request, response);
    }

    public void updateCustomer(ActionRequest request, ActionResponse response)
        throws Exception {

        _updateCustomer(request);

        sendRedirect(request, response);
    }

    private sitiCustomer _updateCustomer(ActionRequest request)
        throws PortalException, SystemException {

    	// Collect all information from JSP
        long customerId = ParamUtil.getLong(request, "customerId");
        String name = ParamUtil.getString(request, "customerName");
        String email = ParamUtil.getString(request, "customerEmail");
        String address = ParamUtil.getString(request, "customerAddress");
        String national_Id = ParamUtil.getString(request, "customerNRIC");
        String contact = ParamUtil.getString(request, "customerContact");
        long serviceId = ParamUtil.getLong(request, "serviceId");

        int year = ParamUtil.getInteger(request, "start_dateYear");
        int month = ParamUtil.getInteger(request, "start_dateMonth");
        int day = ParamUtil.getInteger(request, "start_dateDay");
        int hour = ParamUtil.getInteger(request, "start_dateHour");
        int minute = ParamUtil.getInteger(request, "start_dateMinute");
        int amPm = ParamUtil.getInteger(request, "start_dateAmPm");

        if (amPm == Calendar.PM) {
            hour += 12;
        }

        ServiceContext serviceContext = ServiceContextFactory.getInstance(
            sitiCustomer.class.getName(), request);

        sitiCustomer customer = null;
        
        //Check old customer or new Customer
        if (customerId <= 0) {
        	System.out.println("Add Customer ");
        	//  add Customer Method 
        	customer = sitiCustomerLocalServiceUtil.addCustomer(
                serviceContext.getUserId(), serviceContext.getScopeGroupId(),
                name, email, address, national_Id, contact, month, day, year, hour, minute, serviceId,
                serviceContext);
        }
        else {
        	System.out.println("Update Customer ");
        	customer = sitiCustomerLocalServiceUtil.getCustomer(customerId);
        	//Call update method
        	customer = sitiCustomerLocalServiceUtil.updateCustomer(
                serviceContext.getUserId(), customerId, name, email, address, national_Id, contact, month,
                day, year, hour, minute, serviceId, serviceContext);
        }
        
        return customer;
    }

    //ServicePortlet
    
    public void addServices(ActionRequest request, ActionResponse response)
            throws Exception {

        _updateServices(request);

        sendRedirect(request, response);
    }

    public void deleteServices(ActionRequest request, ActionResponse response)
        throws Exception {

        long serviceId = ParamUtil.getLong(request, "serviceId");

        sitiServicesLocalServiceUtil.deleteServices(serviceId);

        sendRedirect(request, response);
    }

    public void updateServices(ActionRequest request, ActionResponse response)
        throws Exception {

        _updateServices(request);

        sendRedirect(request, response);
    }

    private sitiServices _updateServices(ActionRequest request)
            throws PortalException, SystemException {
 
		

        long serviceId = ParamUtil.getLong(request,"serviceId");
        String serviceName = ParamUtil.getString(request,"serviceName");
        
        String servicePrice = ParamUtil.getString(request,"servicePrice");
        String serviceExpiration = ParamUtil.getString(request,"serviceExpiration");
        String serviceType = ParamUtil.getString(request,"serviceType");
       
        ServiceContext serviceContext = ServiceContextFactory.getInstance(
                sitiServices.class.getName(), request);

        sitiServices services = null;

        if (serviceId <= 0) {

            services = sitiServicesLocalServiceUtil.addServices(
                serviceContext.getUserId(), serviceContext.getScopeGroupId(), serviceName, servicePrice, serviceExpiration, serviceType, serviceContext);
        }
        else {
            services = sitiServicesLocalServiceUtil.getsitiServices(serviceId);

            services = sitiServicesLocalServiceUtil.updateServices(
                    serviceContext.getUserId(), serviceId, serviceName, servicePrice, serviceExpiration,serviceType,
                    serviceContext);
        }

        return services;
    }

    private static Log _log = LogFactoryUtil.getLog(AAACustomerPortlet.class);
    
@Reference
private sitiCustomerLocalService _customerEntryLocalService;

@Reference
private sitiServicesLocalService _servicesLocalService;
	}

