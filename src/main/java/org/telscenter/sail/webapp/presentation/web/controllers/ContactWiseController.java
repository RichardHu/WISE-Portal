package org.telscenter.sail.webapp.presentation.web.controllers;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.mail.IMailFacade;
import net.sf.sail.webapp.mail.JavaMailHelper;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.TeacherUserDetails;
import org.telscenter.sail.webapp.domain.general.contactwise.ContactWISE;
import org.telscenter.sail.webapp.domain.general.contactwise.IssueType;
import org.telscenter.sail.webapp.domain.general.contactwise.OperatingSystem;
import org.telscenter.sail.webapp.domain.general.contactwise.WebBrowser;
import org.telscenter.sail.webapp.domain.general.contactwise.impl.ContactWISEGeneral;

/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

public class ContactWiseController extends SimpleFormController {

	protected IMailFacade javaMail = null;
	
	protected Properties uiHTMLProperties = null;
	
	/* change this to true if you are testing and do not want to send mail to
	   the actual groups */
	private static final Boolean DEBUG = false;
	
	//set this to your email
	private static final String DEBUG_EMAIL = "youremail@gmail.com";
	
	public ContactWiseController() {
		setSessionForm(true);
	}
	
	@Override
	public ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
	throws Exception {
		ContactWISEGeneral contactWISEGeneral = (ContactWISEGeneral) command;
		
		//retrieves the contents of the email to be sent
		String[] recipients = contactWISEGeneral.getMailRecipients();
		String subject = contactWISEGeneral.getMailSubject();
		String fromEmail = contactWISEGeneral.getEmail();
		String message = contactWISEGeneral.getMailMessage();
		String[] cc = contactWISEGeneral.getMailCcs();

		//for testing out the email functionality without spamming the groups
		if(DEBUG) {
			cc = new String[1];
			cc[0] = fromEmail;
			recipients[0] = DEBUG_EMAIL;
		}
		
		//sends the email to the recipients
		javaMail.postMail(recipients, subject, message, fromEmail, cc);
		//System.out.println(message);
		
		ModelAndView modelAndView = new ModelAndView(getSuccessView());

		return modelAndView;
	}
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) 
			throws Exception {
		ContactWISEGeneral contactWISE = new ContactWISEGeneral();
		
		//tries to retrieve the user from the session
		User user = ControllerUtil.getSignedInUser();

		/* if the user is logged in to the session, auto populate the name and 
		   email address in the form, if not, the fields will just be blank */
		if (user != null) {
			//contactWISE.setUser(user);
			contactWISE.setIsStudent(user);
			
			MutableUserDetails telsUserDetails = 
				(MutableUserDetails) user.getUserDetails();

			contactWISE.setName(telsUserDetails.getFirstname() + " " + 
					telsUserDetails.getLastname());
			
			//if user is a teacher, retrieve their email
			/* NOTE: this check may be removed later if we never allow students
			   to submit feedback */
			if(telsUserDetails instanceof TeacherUserDetails) {
				contactWISE.setEmail(telsUserDetails.getEmailAddress());
			}
		}
		return contactWISE;
	}
	
	@Override
	protected Map<String, Object> referenceData(HttpServletRequest request) 
			throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		//places the array of constants into the model so the view can display
		model.put("issuetypes", IssueType.values());
		model.put("operatingsystems", OperatingSystem.values());
		model.put("webbrowsers", WebBrowser.values());
		return model;
	}

	/**
	 * @return the javaMail
	 */
	public IMailFacade getJavaMail() {
		return javaMail;
	}

	/**
	 * @param javaMail is the object that contains the functionality to send
	 * an email. This javaMail is set by the contactWiseController bean 
	 * in controllers.xml.
	 */
	public void setJavaMail(IMailFacade javaMail) {
		this.javaMail = javaMail;
	}


	/**
	 * @param uiHTMLProperties contains the regularly formatted (regular 
	 * casing and spaces instead of underscores) for the enums. This properties
	 * file is set by the contactWiseController bean in controllers.xml.
	 */
	public void setUiHTMLProperties(Properties uiHTMLProperties) {
		/* these are necessary so that the enums can retrieve the values from 
		the properties file */
		IssueType.setProperties(uiHTMLProperties);
		OperatingSystem.setProperties(uiHTMLProperties);
		WebBrowser.setProperties(uiHTMLProperties);
	}

}